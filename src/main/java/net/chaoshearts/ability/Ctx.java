package net.chaoshearts.ability;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import net.chaoshearts.combat.Combat;
import net.chaoshearts.config.ChaosConfig;
import net.chaoshearts.fx.Fx;
import net.chaoshearts.heart.HeartType;
import net.chaoshearts.mastery.Mastery;
import net.chaoshearts.skill.SkillSet;
import net.minecraft.core.Holder;
import net.minecraft.core.particles.ParticleTypes;
import net.minecraft.network.chat.Component;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.world.effect.MobEffect;
import net.minecraft.world.entity.Entity;
import net.minecraft.world.entity.LivingEntity;
import net.minecraft.world.entity.monster.Enemy;
import net.minecraft.world.entity.player.Player;
import net.minecraft.world.level.ClipContext;
import net.minecraft.world.phys.AABB;
import net.minecraft.world.phys.BlockHitResult;
import net.minecraft.world.phys.HitResult;
import net.minecraft.world.phys.Vec3;

/**
 * Everything an ability or passive needs about its caster: mastery, awakening, skill modifiers,
 * targeting, damage with mastery rewards, and per-player state.
 */
public final class Ctx {
	public final ServerPlayer player;
	public final ServerLevel level;
	public final HeartType type;
	public final HeartKit kit;
	public final int mastery;
	public final boolean awakened;
	public final SkillSet skills;
	public final PlayerState state;
	/** The ability being cast, or null for passives. */
	public Ability ability;

	Ctx(ServerPlayer player, HeartType type, HeartKit kit, int mastery, boolean awakened, SkillSet skills, PlayerState state) {
		this.player = player;
		this.level = (ServerLevel) player.level();
		this.type = type;
		this.kit = kit;
		this.mastery = mastery;
		this.awakened = awakened;
		this.skills = skills;
		this.state = state;
	}

	// ---------------------------------------------------------------- numbers

	/** A balance number for this heart, "a1.damage" style, after skill modifiers. */
	public double num(String key, double def) {
		double base = ChaosConfig.num(type.id() + "." + key, def);
		return base * (1 + skills.mod(key));
	}

	/** Damage number: config, skills (capped), Honed (+10% at 60) and awakening (+10%). */
	public float dmg(String key, double def) {
		double base = ChaosConfig.num(type.id() + "." + key, def);
		double bonus = Math.min(skills.mod(key), ChaosConfig.get().maxSkillDamageBonus);
		if (mastery >= Mastery.LVL_HONED) bonus += 0.10;
		if (awakened) bonus += 0.10;
		return (float) (base * (1 + bonus));
	}

	/** Seconds from config converted to ticks, after skill modifiers. */
	public int ticks(String key, double defSeconds) {
		return (int) Math.round(num(key, defSeconds) * 20);
	}

	public boolean flag(String flag) {
		return skills.flag(flag);
	}

	public boolean unlocked(int level) {
		return mastery >= level || awakened;
	}

	// ---------------------------------------------------------------- positions

	public Vec3 eye() {
		return player.getEyePosition();
	}

	public Vec3 look() {
		return player.getLookAngle();
	}

	public Vec3 pos() {
		return player.position();
	}

	public Vec3 center() {
		return player.position().add(0, player.getBbHeight() / 2, 0);
	}

	/** Horizontal look direction. */
	public Vec3 flatLook() {
		Vec3 l = look();
		Vec3 f = new Vec3(l.x, 0, l.z);
		return f.lengthSqr() < 1e-4 ? new Vec3(0, 0, 1) : f.normalize();
	}

	/** The block point the player looks at, or the point at max range. */
	public Vec3 aimPoint(double range) {
		Vec3 from = eye();
		Vec3 to = from.add(look().scale(range));
		BlockHitResult hit = level.clip(new ClipContext(from, to, ClipContext.Block.COLLIDER, ClipContext.Fluid.NONE, player));
		return hit.getType() == HitResult.Type.MISS ? to : hit.getLocation();
	}

	public BlockHitResult aimBlock(double range) {
		Vec3 from = eye();
		return level.clip(new ClipContext(from, from.add(look().scale(range)), ClipContext.Block.COLLIDER, ClipContext.Fluid.NONE, player));
	}

	/** First valid target along the look ray (with a little aim assist), not through walls. */
	public LivingEntity aimEntity(double range, double assist) {
		Vec3 from = eye();
		Vec3 dir = look();
		Vec3 wall = aimPoint(range);
		double max = from.distanceTo(wall);
		Vec3 to = from.add(dir.scale(max));
		AABB box = new AABB(from, to).inflate(assist + 1);
		LivingEntity best = null;
		double bestD = Double.MAX_VALUE;
		for (LivingEntity e : level.getEntitiesOfClass(LivingEntity.class, box, e -> Combat.canTarget(player, e))) {
			AABB bb = e.getBoundingBox().inflate(assist);
			var clip = bb.clip(from, to);
			double d;
			if (bb.contains(from)) d = 0;
			else if (clip.isPresent()) d = from.distanceTo(clip.get());
			else continue;
			if (d < bestD) {
				bestD = d;
				best = e;
			}
		}
		return best;
	}

	public List<LivingEntity> enemies(Vec3 c, double radius) {
		AABB box = new AABB(c, c).inflate(radius);
		List<LivingEntity> out = new ArrayList<>();
		for (LivingEntity e : level.getEntitiesOfClass(LivingEntity.class, box, e -> Combat.canTarget(player, e))) {
			if (e.getBoundingBox().getCenter().distanceToSqr(c) <= radius * radius + e.getBbWidth()) out.add(e);
		}
		out.sort(Comparator.comparingDouble(e -> e.distanceToSqr(c)));
		return out;
	}

	/** Players and pets on the caster's team (and the caster). */
	public List<LivingEntity> allies(Vec3 c, double radius) {
		AABB box = new AABB(c, c).inflate(radius);
		return new ArrayList<>(level.getEntitiesOfClass(LivingEntity.class, box,
				e -> e.isAlive() && (e == player || (e instanceof Player && player.isAlliedTo(e)))));
	}

	// ---------------------------------------------------------------- effects

	/**
	 * Damages a target with this heart, rewards mastery for meaningful hits and shows the hit
	 * indicator. Returns true if damage landed.
	 */
	public boolean hit(LivingEntity target, float amount) {
		return hit(target, amount, false);
	}

	public boolean hit(LivingEntity target, float amount, boolean trueDamage) {
		if (!Combat.canTarget(player, target)) return false;
		boolean landed = Combat.damage(player, target, amount, trueDamage);
		if (!landed) return false;
		indicator(target);
		rewardHit(target);
		kit.afterHit(this, target, amount, true);
		if (!target.isAlive()) {
			rewardKill(target);
			kit.onKill(this, target);
		}
		return true;
	}

	public void rewardHit(LivingEntity target) {
		if (net.chaoshearts.trial.TrialManager.isTrialMob(target)) return;
		var cfg = ChaosConfig.get();
		if (target instanceof ServerPlayer) {
			Mastery.award(player, cfg.xpAbilityHitPlayer * Mastery.targetFactor(player, target.getUUID()));
		} else if (target instanceof Enemy && target.getMaxHealth() >= 10) {
			Mastery.award(player, cfg.xpAbilityHitMob * Mastery.targetFactor(player, target.getUUID()));
		}
	}

	private void rewardKill(LivingEntity target) {
		if (net.chaoshearts.trial.TrialManager.isTrialMob(target)) return;
		if (target instanceof Enemy && !(target instanceof Player) && target.getMaxHealth() >= 10) {
			Mastery.award(player, ChaosConfig.get().xpAbilityKillMob * Mastery.targetFactor(player, target.getUUID()));
		}
	}

	public void indicator(LivingEntity target) {
		Vec3 c = target.position().add(0, target.getBbHeight() * 0.6, 0);
		level.sendParticles(player, ParticleTypes.DAMAGE_INDICATOR, false, false, c.x, c.y, c.z, 3, 0.2, 0.2, 0.2, 0.1);
		long now = level.getGameTime();
		if (now - state.lastIndicatorTick >= 4) {
			state.lastIndicatorTick = now;
			Fx.soundTo(player, SoundEvents.ARROW_HIT_PLAYER, 0.35f, 1.6f + level.random.nextFloat() * 0.2f);
			state.hudFlash(Component.literal("✦ HIT " + target.getName().getString()).withStyle(type.style().withBold(true)), 12);
		}
	}

	public boolean control(LivingEntity target, Holder<MobEffect> effect, int ticks, int amplifier) {
		return Combat.control(target, effect, ticks, amplifier, player);
	}

	/** Pushes an entity; players get their velocity synced. */
	public static void push(Entity e, Vec3 v) {
		e.setDeltaMovement(e.getDeltaMovement().add(v));
		e.hurtMarked = true;
	}

	public static void setVelocity(Entity e, Vec3 v) {
		e.setDeltaMovement(v);
		e.hurtMarked = true;
	}

	/** Knock target away from a point. */
	public static void knockFrom(Entity e, Vec3 from, double strength, double up) {
		Vec3 d = e.position().subtract(from);
		d = new Vec3(d.x, 0, d.z);
		if (d.lengthSqr() < 1e-4) d = new Vec3(0.01, 0, 0);
		double kbRes = e instanceof LivingEntity le ? le.getAttributeValue(net.minecraft.world.entity.ai.attributes.Attributes.KNOCKBACK_RESISTANCE) : 0;
		double s = strength * (1 - Math.min(0.9, kbRes));
		push(e, d.normalize().scale(s).add(0, up * (1 - Math.min(0.9, kbRes)), 0));
	}
}
