package net.chaoshearts.ability.hearts;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import net.chaoshearts.ability.AbilityManager;
import net.chaoshearts.ability.Ctx;
import net.chaoshearts.ability.HeartKit;
import net.chaoshearts.ability.KitUtil;
import net.chaoshearts.combat.Combat;
import net.chaoshearts.fx.Fx;
import net.chaoshearts.fx.Scheduler;
import net.chaoshearts.heart.HeartType;
import net.chaoshearts.mastery.Mastery;
import net.chaoshearts.skill.SkillTree;
import net.minecraft.core.particles.ParticleTypes;
import net.minecraft.resources.Identifier;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.tags.DamageTypeTags;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.effect.MobEffects;
import net.minecraft.world.entity.EntitySpawnReason;
import net.minecraft.world.entity.EntityType;
import net.minecraft.world.entity.LightningBolt;
import net.minecraft.world.entity.LivingEntity;
import net.minecraft.world.entity.ai.attributes.AttributeModifier;
import net.minecraft.world.entity.ai.attributes.Attributes;
import net.minecraft.world.entity.projectile.Projectile;
import net.minecraft.world.phys.AABB;
import net.minecraft.world.phys.Vec3;

/** Storm: lightning, wind, chains of electricity, and becoming the storm. */
public final class StormKit extends HeartKit {
	private static final int BLUE = 0x4FA8FF, WHITE = 0xE8F6FF, GREY = 0x3A4250;

	private final SkillTree tree;
	private final Identifier rainSpeed = modifierId("rain_speed");
	/** target -> ionized until gametime */
	private final Map<UUID, Long> ionized = new HashMap<>();

	public StormKit() {
		super(HeartType.STORM);
		ability(0, "Lightning Strike", "Call down a bolt of lightning on your target.", 10, this::strike);
		ability(1, "Gale Burst", "Blast every enemy away and ride the updraft into the sky.", 18, this::gale);
		ability(2, "Chain Lightning", "A bolt that leaps from enemy to enemy.", 24, this::chain);
		ability(3, "Tempest", "Become the storm. Lightning rains on every enemy near you.", 130, this::tempest);

		feat("skyfall", "Skyfall", "Hit an airborne enemy with Lightning Strike", 300);
		feat("chain5", "Overcharge", "Hit 5 enemies with one Chain Lightning", 500);
		feat("gale4", "Blown Away", "Knock back 4 enemies with one Gale Burst", 400);
		feat("tempest15", "Eye of the Storm", "Land 15 Tempest bolts in one Tempest", 600);

		SkillTree t = new SkillTree("storm");
		t.branch("Conduit", "More voltage", BLUE,
				t.node(0, "high_voltage", "High Voltage", "+20% Lightning Strike damage").mod("a1.damage", 0.2),
				t.node(1, "forked_bolt", "Forked Bolt", "Lightning Strike also hits the nearest other enemy").flag("storm.fork"),
				t.node(2, "conductor", "Conductor", "Chain Lightning bounces 2 more times").mod("a3.bounces", 0.4),
				t.node(3, "overload", "Overload", "Static triggers on every 3rd hit").flag("storm.static3"),
				t.node(4, "thunderstorm", "Thunderstorm", "CAPSTONE: Lightning Strike calls three bolts marching forward").flag("storm.triple"));
		t.branch("Windcaller", "The air obeys", WHITE,
				t.node(0, "strong_gust", "Strong Gust", "+30% Gale Burst knockback").mod("a2.power", 0.3),
				t.node(1, "updraft", "Updraft", "Gale Burst lifts you higher and you float down longer").flag("storm.updraft"),
				t.node(2, "wind_wall", "Wind Wall", "After Gale Burst, a ring of wind deflects projectiles for 3 seconds").flag("storm.windwall"),
				t.node(3, "tailwind", "Tailwind", "Your rain speed bonus applies in any weather").flag("storm.tailwind"),
				t.node(4, "cyclone", "Cyclone", "CAPSTONE: Gale Burst becomes a cyclone that lifts enemies, spins them, then flings them").flag("storm.cyclone"));
		t.branch("Tempest", "Be the weather", GREY,
				t.node(0, "rolling_thunder", "Rolling Thunder", "+30% Tempest duration").mod("a4.duration", 0.3),
				t.node(1, "wide_storm", "Wide Storm", "+25% Tempest radius").mod("a4.radius", 0.25),
				t.node(2, "static_field", "Static Field", "During Tempest, enemies that hit you are shocked").flag("storm.field"),
				t.node(3, "ionized", "Ionized", "Your lightning ionizes targets: +15% ability damage against them for 4s").flag("storm.ionize"),
				t.node(4, "ride_lightning", "Ride the Lightning", "CAPSTONE: you can fly while Tempest lasts").flag("storm.flight"));
		tree = t;
	}

	@Override public String passive1Name() { return "Stormborn"; }
	@Override public String passive1Description() { return "Immune to lightning. You move 20% faster in the rain."; }
	@Override public String passive2Name() { return "Static"; }
	@Override public String passive2Description() { return "Every 4th melee hit arcs a spark to another enemy."; }
	@Override public String awakenedName() { return "Thunder God"; }
	@Override public String awakenedDescription() { return "Lightning Strike leaves charged ground that shocks and slows."; }
	@Override public SkillTree tree() { return tree; }

	private void zap(Ctx c, LivingEntity e, float dmg) {
		if (c.hit(e, dmg) && c.flag("storm.ionize")) ionized.put(e.getUUID(), c.level.getGameTime() + 80);
		Fx.at(c.level, ParticleTypes.ELECTRIC_SPARK, e.position().add(0, e.getBbHeight() / 2, 0), 12, 0.3, 0.3);
	}

	private void bolt(ServerLevel level, Vec3 at) {
		LightningBolt b = EntityType.LIGHTNING_BOLT.create(level, EntitySpawnReason.TRIGGERED);
		if (b == null) return;
		b.snapTo(at.x, at.y, at.z, 0, 0);
		b.setVisualOnly(true);
		level.addFreshEntity(b);
	}

	@Override
	public void tick(Ctx c, long t) {
		ServerPlayer p = c.player;
		long now = c.level.getGameTime();
		if (t % 20 == 0) {
			boolean fast = c.flag("storm.tailwind") || c.level.isRainingAt(p.blockPosition());
			keepModifier(p, Attributes.MOVEMENT_SPEED, rainSpeed, fast ? 0.2 : 0, AttributeModifier.Operation.ADD_MULTIPLIED_TOTAL);
			if (ionized.size() > 128) ionized.values().removeIf(v -> v < now);
		}
		if (c.state.timer("tempest", now)) tempestTick(c, t);
		else if (c.state.var("tempestActive") == 1) endTempest(c);
	}

	@Override
	public void aura(Ctx c, long t) {
		if (c.level.random.nextInt(3) == 0) Fx.at(c.level, ParticleTypes.ELECTRIC_SPARK, c.center(), 1, 0.4, 0.6, 0.4, 0.05);
		if (c.awakened && t % 12 == 0) Fx.bolt(c.level, Fx.dust(BLUE, 0.6f), c.center().add(0, 0.8, 0), c.center().add(Fx.randomDir(c.level).scale(1.2)), 0.2);
	}

	@Override
	public float outgoing(Ctx c, LivingEntity target, DamageSource s, float amount) {
		Long ion = ionized.get(target.getUUID());
		if (Combat.inAbilityDamage() && ion != null && ion > c.level.getGameTime()) amount *= 1.15f;
		return amount;
	}

	@Override
	public float incoming(Ctx c, DamageSource s, float amount) {
		if (s.is(DamageTypeTags.IS_LIGHTNING)) return 0;
		return amount;
	}

	@Override
	public void afterHit(Ctx c, LivingEntity target, float amount, boolean ability) {
		if (ability || !c.unlocked(Mastery.LVL_PASSIVE2)) return;
		int every = c.flag("storm.static3") ? 3 : 4;
		if (c.state.addVar("static", 1) % every != 0) return;
		for (LivingEntity e : c.enemies(target.position(), 6)) {
			if (e == target) continue;
			Fx.bolt(c.level, ParticleTypes.ELECTRIC_SPARK, target.position().add(0, 1, 0), e.position().add(0, 1, 0), 0.4);
			Fx.sound(c.level, e.position(), SoundEvents.LIGHTNING_BOLT_IMPACT, 0.4f, 1.8f);
			zap(c, e, c.dmg("p.static", 3.0));
			break;
		}
	}

	@Override
	public void afterHurt(Ctx c, DamageSource s, float amount) {
		if (c.flag("storm.field") && c.state.timer("tempest", c.level.getGameTime()) && s.getEntity() instanceof LivingEntity le && le != c.player) {
			Fx.bolt(c.level, ParticleTypes.ELECTRIC_SPARK, c.center(), le.position().add(0, 1, 0), 0.3);
			zap(c, le, 2);
		}
	}

	@Override
	public String hud(Ctx c, long t) {
		long now = c.level.getGameTime();
		if (c.state.timer("tempest", now)) return "⛈ TEMPEST " + (c.state.timerLeft("tempest", now) / 20 + 1) + "s";
		return null;
	}

	@Override
	public void deactivate(ServerPlayer p) {
		super.deactivate(p);
		Ctx c = AbilityManager.ctx(p);
		if (c != null && c.state.var("tempestActive") == 1) endTempest(c);
	}

	// ---------------------------------------------------------------- abilities

	private void strikeAt(Ctx c, Vec3 at, float dmg) {
		bolt(c.level, at);
		Fx.at(c.level, ParticleTypes.ELECTRIC_SPARK, at.add(0, 0.5, 0), 40, 0.6, 0.6);
		Fx.at(c.level, Fx.dust(WHITE, 2f), at.add(0, 0.2, 0), 20, 0.5, 0);
		Fx.shockRing(c.level, Fx.dust(BLUE, 1.6f), at.add(0, 0.1, 0), 0.3, 24, 0.25);
		Fx.custom(c.level, at, "storm_strike", 1.5f, 1f);
		for (LivingEntity e : c.enemies(at.add(0, 1, 0), 2.2)) {
			if (!e.onGround()) Mastery.feat(c.player, c.type, "skyfall");
			zap(c, e, dmg);
		}
		if (c.awakened) chargedGround(c, at);
	}

	private void chargedGround(Ctx c, Vec3 at) {
		ServerPlayer p = c.player;
		ServerLevel level = c.level;
		Scheduler.repeat(5, 10, 8, i -> {
			Ctx cc = AbilityManager.ctx(p);
			if (cc == null) return false;
			Fx.disc(level, ParticleTypes.ELECTRIC_SPARK, at.add(0, 0.1, 0), 2.5, 14);
			Fx.ring(level, Fx.dust(BLUE, 1f), at.add(0, 0.05, 0), 2.5, 18, i * 0.4);
			for (LivingEntity e : cc.enemies(at.add(0, 0.5, 0), 2.5)) {
				cc.hit(e, 1f);
				Combat.debuff(e, MobEffects.SLOWNESS, 20, 0, p);
			}
			return true;
		});
	}

	private boolean strike(Ctx c) {
		double range = c.num("a1.range", 30.0);
		LivingEntity target = c.aimEntity(range, 1.2);
		Vec3 at = target != null ? target.position() : c.aimPoint(range);
		float dmg = c.dmg("a1.damage", 7.0);
		Fx.sound(c.level, c.pos(), SoundEvents.TRIDENT_THUNDER.value(), 0.6f, 1.4f);
		// Wind-up: charge crackles at the target for a moment.
		Fx.pillar(c.level, ParticleTypes.ELECTRIC_SPARK, at, 8, 16, 0.1);
		Scheduler.later(4, () -> {
			Ctx cc = AbilityManager.ctx(c.player);
			if (cc == null) return;
			Vec3 hitAt = target != null && target.isAlive() ? target.position() : at;
			strikeAt(cc, hitAt, dmg);
			if (cc.flag("storm.fork")) {
				for (LivingEntity e : cc.enemies(hitAt, 8)) {
					if (e == target) continue;
					strikeAt(cc, e.position(), dmg * 0.6f);
					break;
				}
			}
			if (cc.flag("storm.triple")) {
				Vec3 step = cc.flatLook().scale(3.5);
				for (int k = 1; k <= 2; k++) {
					Vec3 next = hitAt.add(step.scale(k));
					Vec3 g = KitUtil.groundBelow(cc.level, next.add(0, 3, 0), 8);
					Vec3 spot = g == null ? next : g;
					Scheduler.later(k * 5, () -> {
						Ctx c3 = AbilityManager.ctx(c.player);
						if (c3 != null) strikeAt(c3, spot, dmg * 0.7f);
					});
				}
			}
		});
		return true;
	}

	private boolean gale(Ctx c) {
		ServerPlayer p = c.player;
		ServerLevel level = c.level;
		double r = c.num("a2.radius", 6.0);
		double power = c.num("a2.power", 1.6);
		Vec3 at = c.pos();
		Fx.at(level, ParticleTypes.GUST_EMITTER_LARGE, at.add(0, 0.5, 0), 1, 0, 0);
		Fx.shockRing(level, ParticleTypes.CLOUD, at.add(0, 0.3, 0), 0.5, 40, 0.6);
		Fx.shockRing(level, Fx.dust(WHITE, 1.4f), at.add(0, 1, 0), 0.5, 30, 0.5);
		Fx.sound(level, at, SoundEvents.WIND_CHARGE_BURST.value(), 1.2f, 0.7f);
		Fx.sound(level, at, SoundEvents.BREEZE_SHOOT, 1f, 0.8f);
		Fx.custom(level, at, "storm_gale", 1.3f, 1f);
		List<LivingEntity> hit = c.enemies(at, r);
		if (c.flag("storm.cyclone")) {
			cyclone(c, at, hit);
		} else {
			for (LivingEntity e : hit) {
				Ctx.knockFrom(e, at, power, 0.5);
				c.rewardHit(e);
			}
		}
		if (hit.size() >= 4) Mastery.feat(p, c.type, "gale4");
		boolean up = c.flag("storm.updraft");
		Ctx.setVelocity(p, p.getDeltaMovement().multiply(1, 0, 1).add(0, up ? 1.6 : 1.15, 0));
		Combat.buff(p, MobEffects.SLOW_FALLING, up ? 120 : 60, 0);
		if (c.flag("storm.windwall")) {
			Scheduler.repeat(0, 1, 60, i -> {
				Vec3 center = p.position();
				if (i % 3 == 0) Fx.ring(level, ParticleTypes.CLOUD, center.add(0, 1, 0), 2.5, 16, i * 0.5);
				for (Projectile pr : level.getEntitiesOfClass(Projectile.class, new AABB(center, center).inflate(3), pr -> pr.getOwner() != p)) {
					Vec3 away = pr.position().subtract(center).normalize();
					pr.setDeltaMovement(away.scale(1.2));
					pr.hurtMarked = true;
				}
				return p.isAlive();
			});
		}
		return true;
	}

	private void cyclone(Ctx c, Vec3 at, List<LivingEntity> hit) {
		ServerPlayer p = c.player;
		ServerLevel level = c.level;
		double power = c.num("a2.power", 1.6);
		Scheduler.repeat(0, 1, 40, i -> {
			Fx.helix(level, ParticleTypes.CLOUD, at, 1 + i * 0.05, 5, 2, 16, i * 0.5);
			for (LivingEntity e : hit) {
				if (!e.isAlive()) continue;
				Vec3 rel = e.position().subtract(at);
				Vec3 tangent = new Vec3(-rel.z, 0, rel.x).normalize();
				if (i < 30) Ctx.setVelocity(e, tangent.scale(0.35).add(rel.normalize().scale(-0.12)).add(0, 0.12, 0));
				else if (i == 30) {
					Ctx.knockFrom(e, at, power * 1.3, 0.6);
					Ctx cc = AbilityManager.ctx(p);
					if (cc != null) cc.hit(e, cc.dmg("a2.damage", 4.0));
				}
			}
			if (i % 10 == 0) Fx.sound(level, at, SoundEvents.BREEZE_IDLE_AIR, 1.5f, 0.6f);
			return true;
		});
	}

	private boolean chain(Ctx c) {
		LivingEntity first = c.aimEntity(c.num("a3.range", 20.0), 1.2);
		if (first == null) {
			List<LivingEntity> near = c.enemies(c.center(), 8);
			if (near.isEmpty()) {
				Fx.actionBar(c.player, net.minecraft.network.chat.Component.literal("No target for the lightning.").withStyle(net.minecraft.ChatFormatting.GRAY));
				return false;
			}
			first = near.get(0);
		}
		int bounces = (int) Math.round(c.num("a3.bounces", 5.0));
		float dmg = c.dmg("a3.damage", 5.0);
		List<LivingEntity> chainList = new ArrayList<>();
		Set<UUID> used = new HashSet<>();
		LivingEntity cur = first;
		while (cur != null && chainList.size() < bounces) {
			chainList.add(cur);
			used.add(cur.getUUID());
			LivingEntity next = null;
			for (LivingEntity e : c.enemies(cur.position(), 7)) {
				if (!used.contains(e.getUUID())) {
					next = e;
					break;
				}
			}
			cur = next;
		}
		ServerPlayer p = c.player;
		Vec3 from = c.eye().add(c.look().scale(0.5)).subtract(0, 0.3, 0);
		Fx.sound(c.level, c.pos(), SoundEvents.TRIDENT_THUNDER.value(), 0.5f, 1.8f);
		Fx.custom(c.level, c.pos(), "storm_chain", 1f, 1f);
		Vec3[] prev = {from};
		for (int i = 0; i < chainList.size(); i++) {
			final int k = i;
			LivingEntity e = chainList.get(i);
			Scheduler.later(1 + i * 2, () -> {
				Ctx cc = AbilityManager.ctx(p);
				if (cc == null || !e.isAlive()) return;
				Vec3 to = e.position().add(0, e.getBbHeight() / 2, 0);
				Fx.bolt(cc.level, ParticleTypes.ELECTRIC_SPARK, prev[0], to, 0.5);
				Fx.bolt(cc.level, Fx.dust(WHITE, 0.8f), prev[0], to, 0.3);
				Fx.sound(cc.level, to, SoundEvents.LIGHTNING_BOLT_IMPACT, 0.6f, 1.2f + k * 0.1f);
				zap(cc, e, dmg * (float) Math.pow(0.9, k));
				prev[0] = to;
			});
		}
		if (chainList.size() >= 5) Mastery.feat(p, c.type, "chain5");
		return true;
	}

	private boolean tempest(Ctx c) {
		long now = c.level.getGameTime();
		ServerPlayer p = c.player;
		int dur = c.ticks("a4.duration", 10.0);
		c.state.startTimer("tempest", now + dur);
		c.state.var("tempestActive", 1);
		c.state.var("tempestHits", 0);
		Combat.buff(p, MobEffects.SPEED, dur, 1);
		if (c.flag("storm.flight") && !p.isCreative()) {
			p.getAbilities().mayfly = true;
			p.onUpdateAbilities();
		} else {
			Combat.buff(p, MobEffects.SLOW_FALLING, dur, 0);
		}
		Ctx.setVelocity(p, p.getDeltaMovement().add(0, 0.7, 0));
		bolt(c.level, c.pos());
		Fx.far(c.level, ParticleTypes.EXPLOSION_EMITTER, c.center(), 1, 0, 0);
		Fx.sound(c.level, c.pos(), SoundEvents.LIGHTNING_BOLT_THUNDER, 2f, 0.7f);
		Fx.custom(c.level, c.pos(), "storm_tempest", 2f, 1f);
		Fx.title(p, net.minecraft.network.chat.Component.empty(), net.minecraft.network.chat.Component.literal("⛈ Tempest").withStyle(c.type.style().withBold(true)), 2, 30, 10);
		return true;
	}

	private void tempestTick(Ctx c, long t) {
		ServerLevel level = c.level;
		Vec3 cloud = c.pos().add(0, 6, 0);
		if (t % 2 == 0) {
			Fx.disc(level, Fx.dust(GREY, 3f), cloud, 4.5, 12);
			Fx.disc(level, ParticleTypes.CLOUD, cloud.add(0, 0.3, 0), 4, 6);
			if (level.random.nextInt(4) == 0) Fx.bolt(level, Fx.dust(WHITE, 0.7f), cloud, cloud.add(Fx.randomDir(level).multiply(3, 0.5, 3)), 0.4);
			Fx.at(level, ParticleTypes.FALLING_WATER, cloud.subtract(0, 0.5, 0), 6, 3, 0.1, 3, 0);
		}
		if (t % 20 == 0) {
			double r = c.num("a4.radius", 14.0);
			List<LivingEntity> targets = c.enemies(c.pos(), r);
			for (int i = 0; i < Math.min(3, targets.size()); i++) {
				LivingEntity e = targets.get(i);
				bolt(level, e.position());
				Fx.at(level, ParticleTypes.ELECTRIC_SPARK, e.position().add(0, 1, 0), 20, 0.4, 0.4);
				zap(c, e, c.dmg("a4.damage", 6.0));
				if (c.state.addVar("tempestHits", 1) >= 15) Mastery.feat(c.player, c.type, "tempest15");
			}
		}
	}

	private void endTempest(Ctx c) {
		c.state.var("tempestActive", 0);
		ServerPlayer p = c.player;
		if (!p.isCreative() && !p.isSpectator() && p.getAbilities().mayfly && !net.chaoshearts.eye.EyeManager.isEye(p)) {
			p.getAbilities().mayfly = false;
			p.getAbilities().flying = false;
			p.onUpdateAbilities();
			Combat.buff(p, MobEffects.SLOW_FALLING, 80, 0);
		}
		Fx.sound(c.level, c.pos(), SoundEvents.LIGHTNING_BOLT_THUNDER, 0.8f, 1.5f);
	}
}
