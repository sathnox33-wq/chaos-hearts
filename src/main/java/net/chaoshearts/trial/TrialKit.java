package net.chaoshearts.trial;

import java.util.function.Consumer;

import net.chaoshearts.ability.Ctx;
import net.chaoshearts.config.ChaosConfig;
import net.chaoshearts.fx.Displays;
import net.chaoshearts.fx.Fx;
import net.chaoshearts.fx.Scheduler;
import net.chaoshearts.fx.SimProjectile;
import net.minecraft.core.BlockPos;
import net.minecraft.core.Holder;
import net.minecraft.core.particles.ParticleOptions;
import net.minecraft.core.particles.ParticleTypes;
import net.minecraft.network.chat.Component;
import net.minecraft.network.chat.Style;
import net.minecraft.network.chat.TextColor;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.world.effect.MobEffect;
import net.minecraft.world.effect.MobEffectInstance;
import net.minecraft.world.entity.Display;
import net.minecraft.world.entity.EntitySpawnReason;
import net.minecraft.world.entity.EntityType;
import net.minecraft.world.entity.EquipmentSlot;
import net.minecraft.world.entity.LivingEntity;
import net.minecraft.world.entity.Mob;
import net.minecraft.world.entity.ai.attributes.AttributeInstance;
import net.minecraft.world.entity.ai.attributes.Attributes;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.level.ClipContext;
import net.minecraft.world.level.block.state.BlockState;
import net.minecraft.world.phys.HitResult;
import net.minecraft.world.phys.Vec3;

/** Building blocks for trial scripts: mobs, telegraphed attacks, zones and projectiles. */
public final class TrialKit {
	private TrialKit() {}

	public static double difficulty() {
		return Math.max(0.25, ChaosConfig.get().trialDifficulty);
	}

	// ---------------------------------------------------------------- mobs

	/** Spawns a trial mob that only fights this session's player. Adds count towards the wave. */
	public static <T extends Mob> T mob(TrialSession s, EntityType<T> type, Vec3 pos, boolean countsForWave, Consumer<T> setup) {
		ServerLevel level = s.level;
		T m = type.create(level, EntitySpawnReason.EVENT);
		if (m == null) return null;
		ServerPlayer p = s.player();
		float yaw = p == null ? 0 : net.chaoshearts.trial.Cinematic.lookAngles(pos, p.position())[0];
		m.snapTo(pos.x, pos.y, pos.z, yaw, 0);
		m.finalizeSpawn(level, level.getCurrentDifficultyAt(BlockPos.containing(pos)), EntitySpawnReason.EVENT, null);
		m.setPersistenceRequired();
		m.addTag(TrialManager.TAG);
		m.addTag(s.tag());
		if (setup != null) setup.accept(m);
		level.addFreshEntity(m);
		if (p != null) m.setTarget(p);
		if (countsForWave) s.adds.add(m.getUUID());
		Fx.at(level, ParticleTypes.LARGE_SMOKE, pos.add(0, 0.6, 0), 12, 0.3, 0.02);
		Fx.at(level, ParticleTypes.REVERSE_PORTAL, pos.add(0, 1, 0), 20, 0.3, 0.1);
		return m;
	}

	public static void attr(Mob m, Holder<net.minecraft.world.entity.ai.attributes.Attribute> a, double value) {
		AttributeInstance i = m.getAttribute(a);
		if (i != null) i.setBaseValue(value);
	}

	/** Health and damage scale with the configured difficulty. */
	public static void stats(Mob m, double health, double damage, double speed, double scale, double armor) {
		double d = difficulty();
		attr(m, Attributes.MAX_HEALTH, Math.min(1024, health * d));
		m.setHealth(m.getMaxHealth());
		if (damage > 0) attr(m, Attributes.ATTACK_DAMAGE, damage * (0.6 + 0.4 * d));
		if (speed > 0) attr(m, Attributes.MOVEMENT_SPEED, speed);
		if (scale > 0) attr(m, Attributes.SCALE, scale);
		if (armor > 0) attr(m, Attributes.ARMOR, armor);
		attr(m, Attributes.FOLLOW_RANGE, 64);
	}

	public static void boss(Mob m, String name, int rgb) {
		m.setCustomName(Component.literal(name).withStyle(Style.EMPTY.withColor(TextColor.fromRgb(rgb)).withBold(true)));
		m.setCustomNameVisible(true);
		attr(m, Attributes.KNOCKBACK_RESISTANCE, 0.85);
		m.setGlowingTag(true);
	}

	public static void name(Mob m, String name, int rgb) {
		m.setCustomName(Component.literal(name).withStyle(Style.EMPTY.withColor(TextColor.fromRgb(rgb))));
	}

	public static void equip(Mob m, EquipmentSlot slot, ItemStack stack) {
		m.setItemSlot(slot, stack);
	}

	public static int aliveAdds(TrialSession s) {
		s.adds.removeIf(id -> !(s.level.getEntity(id) instanceof LivingEntity e) || !e.isAlive());
		return s.adds.size();
	}

	/** Ring of positions around the arena for a wave. */
	public static Vec3 spawnRing(TrialSession s, int i, int n, double radius) {
		double a = Math.PI * 2 * i / n + s.arena.random.nextDouble() * 0.3;
		Vec3 c = s.arena.centerTop();
		return new Vec3(c.x + Math.cos(a) * radius, c.y, c.z + Math.sin(a) * radius);
	}

	// ---------------------------------------------------------------- hitting the player

	public static boolean hit(TrialSession s, Mob src, float amount) {
		ServerPlayer p = s.player();
		if (p == null || !p.isAlive() || p.isSpectator() || !s.fighting()) return false;
		int saved = p.invulnerableTime;
		p.invulnerableTime = 0;
		boolean hurt = p.hurtServer(s.level, src != null ? s.level.damageSources().mobAttack(src) : s.level.damageSources().magic(), amount);
		if (!hurt) p.invulnerableTime = saved;
		return hurt;
	}

	public static boolean near(TrialSession s, Vec3 c, double radius) {
		ServerPlayer p = s.player();
		return p != null && !p.isSpectator() && p.position().add(0, 0.9, 0).distanceTo(c) <= radius + 0.5;
	}

	/** Damage and knockback if the player is inside the radius. */
	public static boolean blast(TrialSession s, Mob src, Vec3 c, double radius, float amount, double knock, double up) {
		if (!near(s, c, radius)) return false;
		ServerPlayer p = s.player();
		hit(s, src, amount);
		if (knock > 0 || up > 0) Ctx.knockFrom(p, c, knock, up);
		return true;
	}

	public static void effect(TrialSession s, Holder<MobEffect> e, int ticks, int amp) {
		ServerPlayer p = s.player();
		if (p != null && !p.isSpectator()) p.addEffect(new MobEffectInstance(e, ticks, amp, false, true, true));
	}

	/**
	 * Marks the ground for delay ticks, then runs the attack. Every big attack is telegraphed so
	 * players can react: a filling ring in the heart's colour and a rising tone.
	 */
	public static void telegraph(TrialSession s, Vec3 c, double radius, int delay, int rgb, Runnable then) {
		ServerLevel level = s.level;
		Fx.sound(level, c, net.minecraft.sounds.SoundEvents.NOTE_BLOCK_BELL.value(), 0.6f, 0.6f);
		Fx.custom(level, c, "trial_telegraph", 1f, 1f);
		Scheduler.repeat(0, 2, Math.max(1, delay / 2), i -> {
			if (!s.active()) return false;
			double f = (i * 2.0) / Math.max(1, delay);
			Fx.ring(level, Fx.dust(rgb, 1.3f), c.add(0, 0.15, 0), radius, (int) (12 + radius * 6), i * 0.1);
			Fx.ring(level, Fx.dust(0xFFFFFF, 0.8f), c.add(0, 0.12, 0), radius * f, (int) (6 + radius * 4 * f), -i * 0.1);
			if (i % 4 == 0) Fx.sound(level, c, net.minecraft.sounds.SoundEvents.NOTE_BLOCK_PLING.value(), 0.4f, 0.6f + (float) f);
			return true;
		});
		Scheduler.later(delay, () -> {
			if (s.active() && s.fighting()) then.run();
		});
	}

	/** A lingering area that hurts the player while they stand in it. */
	public static TrialSession.Zone zone(TrialSession s, Vec3 c, double radius, int ticks, float dps, int rgb) {
		TrialSession.Zone z = new TrialSession.Zone(c, radius, ticks, dps, rgb);
		s.zones.add(z);
		return z;
	}

	/** A projectile that only collides with the session player. */
	public static SimProjectile shoot(TrialSession s, Mob src, Vec3 from, Vec3 velocity, ParticleOptions trail, Display display, float damage, double radius, Consumer<Vec3> onEnd) {
		ServerPlayer p = s.player();
		SimProjectile proj = new SimProjectile(s.level, from, velocity);
		proj.radius = radius;
		proj.maxTicks = 80;
		proj.owner = src;
		proj.display = display;
		proj.canHit(e -> p != null && e == p && !p.isSpectator());
		proj.onTick(pr -> {
			if (!s.active()) {
				pr.stop();
				return;
			}
			if (trail != null) Fx.at(s.level, trail, pr.pos, 2, 0.05, 0.01);
		});
		proj.onEntity((pr, e) -> hit(s, src, damage));
		proj.onEnd((pr, at) -> {
			if (pr.display != null) pr.display.discard();
			if (onEnd != null && s.active()) onEnd.accept(at);
		});
		return proj.launch();
	}

	public static Display.BlockDisplay blockDisplay(TrialSession s, Vec3 pos, BlockState state, float scale) {
		return Displays.block(s.level, pos, state, scale, true);
	}

	public static Display.ItemDisplay itemDisplay(TrialSession s, Vec3 pos, ItemStack stack, float scale) {
		Display.ItemDisplay d = Displays.item(s.level, pos, stack, scale, true);
		if (d != null) Displays.billboard(d, Display.BillboardConstraints.CENTER);
		return d;
	}

	/** Jump towards a point in an arc. */
	public static void leap(Mob m, Vec3 to, double height) {
		Vec3 d = to.subtract(m.position());
		double h = Math.sqrt(d.x * d.x + d.z * d.z);
		Ctx.setVelocity(m, new Vec3(d.x / Math.max(1, h) * Math.min(1.6, h / 10), height, d.z / Math.max(1, h) * Math.min(1.6, h / 10)));
	}

	/** True if nothing solid is between the two points (pillars give cover). */
	public static boolean clearLine(ServerLevel level, Vec3 a, Vec3 b, net.minecraft.world.entity.Entity ctx) {
		return level.clip(new ClipContext(a, b, ClipContext.Block.COLLIDER, ClipContext.Fluid.NONE, ctx)).getType() == HitResult.Type.MISS;
	}

	public static Vec3 playerPos(TrialSession s) {
		ServerPlayer p = s.player();
		return p == null ? s.arena.centerTop() : p.position();
	}

	/** Where the player will be in a moment, so attacks lead a running target a little. */
	public static Vec3 predict(TrialSession s, int ticks) {
		ServerPlayer p = s.player();
		if (p == null) return s.arena.centerTop();
		Vec3 v = p.getDeltaMovement();
		return p.position().add(v.x * ticks, 0, v.z * ticks);
	}

	/** Harmless lightning for the look and sound; damage is dealt separately. */
	public static void lightning(TrialSession s, Vec3 at) {
		net.minecraft.world.entity.LightningBolt b = EntityType.LIGHTNING_BOLT.create(s.level, EntitySpawnReason.TRIGGERED);
		if (b == null) return;
		b.snapTo(at.x, at.y, at.z, 0, 0);
		b.setVisualOnly(true);
		s.level.addFreshEntity(b);
	}

	/** A block that drops from the sky onto a point over the given ticks, then runs the impact. */
	public static void drop(TrialSession s, Vec3 ground, BlockState state, float scale, int ticks, Runnable impact) {
		Vec3 top = ground.add(0, 16, 0);
		Display.BlockDisplay d = blockDisplay(s, top, state, scale);
		if (d != null) Displays.teleportDuration(d, 2);
		Scheduler.repeat(0, 1, ticks, i -> {
			if (!s.active()) {
				if (d != null) d.discard();
				return false;
			}
			double f = (i + 1) / (double) ticks;
			Vec3 at = top.lerp(ground, f * f);
			if (d != null) Displays.move(d, at);
			if (i == ticks - 1) {
				if (d != null) d.discard();
				impact.run();
			}
			return true;
		});
	}

	/** Distance from a point to a segment. */
	public static double segmentDistance(Vec3 p, Vec3 a, Vec3 b) {
		Vec3 ab = b.subtract(a);
		double len = ab.lengthSqr();
		if (len < 1e-6) return p.distanceTo(a);
		double t = Math.max(0, Math.min(1, p.subtract(a).dot(ab) / len));
		return p.distanceTo(a.add(ab.scale(t)));
	}

	/** Damage over time to the player. */
	public static void bleed(TrialSession s, Mob src, float perTick, int pulses, int interval) {
		Scheduler.repeat(interval, interval, pulses, i -> {
			if (!s.active() || !s.fighting()) return false;
			hit(s, src, perTick);
			ServerPlayer p = s.player();
			if (p != null) Fx.at(s.level, Fx.dust(0x9E0B1F, 1f), p.position().add(0, 1, 0), 6, 0.3, 0);
			return true;
		});
	}

	public static Vec3 flat(Vec3 v) {
		Vec3 f = new Vec3(v.x, 0, v.z);
		return f.lengthSqr() < 1e-6 ? new Vec3(0, 0, 1) : f.normalize();
	}

	/** Announces a boss move in the action bar. */
	public static void callout(TrialSession s, String text, int rgb) {
		ServerPlayer p = s.player();
		if (p != null) Fx.actionBar(p, Component.literal(text).withStyle(Style.EMPTY.withColor(TextColor.fromRgb(rgb)).withBold(true)));
	}
}
