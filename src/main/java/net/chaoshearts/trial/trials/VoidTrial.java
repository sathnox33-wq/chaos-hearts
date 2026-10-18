package net.chaoshearts.trial.trials;

import net.chaoshearts.ability.Ctx;
import net.chaoshearts.fx.Fx;
import net.chaoshearts.fx.Scheduler;
import net.chaoshearts.heart.HeartType;
import net.chaoshearts.trial.Arena;
import net.chaoshearts.trial.Palette;
import net.chaoshearts.trial.Trial;
import net.chaoshearts.trial.TrialKit;
import net.chaoshearts.trial.TrialSession;
import net.minecraft.core.particles.ParticleTypes;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.world.BossEvent;
import net.minecraft.world.effect.MobEffects;
import net.minecraft.world.entity.EntityType;
import net.minecraft.world.entity.Mob;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.world.phys.Vec3;

/** The Hollow Sovereign pulls you into rifts, steps out of your shadow and finally swallows the centre. */
public final class VoidTrial extends Trial {
	private static final int PURPLE = 0x8A3CFF;
	private static final int DARK = 0x14002B;

	public VoidTrial() {
		super(HeartType.VOID);
	}

	@Override
	public String title() {
		return "The Hollow Beneath";
	}

	@Override
	public String tagline() {
		return "Stare into nothing long enough and it learns your name.";
	}

	@Override
	public String bossName() {
		return "The Hollow Sovereign";
	}

	@Override
	public BossEvent.BossBarColor barColor() {
		return BossEvent.BossBarColor.PURPLE;
	}

	@Override
	public Palette palette() {
		return new Palette(
				Palette.of(Blocks.END_STONE_BRICKS, 3, Blocks.END_STONE, 2, Blocks.OBSIDIAN, 2, Blocks.CRYING_OBSIDIAN, 1),
				Palette.of(Blocks.OBSIDIAN, 1),
				Blocks.PURPUR_BLOCK.defaultBlockState(),
				Blocks.PURPUR_PILLAR.defaultBlockState(),
				Blocks.OBSIDIAN.defaultBlockState(),
				Blocks.CRYING_OBSIDIAN.defaultBlockState(),
				Blocks.PEARLESCENT_FROGLIGHT.defaultBlockState());
	}

	@Override
	public void decorate(Arena a) {
		int r = a.radius;
		// Floating obsidian shards around the arena, points down.
		for (int i = 0; i < 14; i++) {
			double ang = a.random.nextDouble() * Math.PI * 2;
			int d = r + 6 + a.random.nextInt(18);
			int x = (int) (Math.cos(ang) * d), z = (int) (Math.sin(ang) * d);
			int y0 = -4 + a.random.nextInt(20);
			int len = 4 + a.random.nextInt(6);
			for (int k = 0; k < len; k++) {
				a.set(x, y0 - k, z, k == 0 ? Blocks.CRYING_OBSIDIAN.defaultBlockState() : Blocks.OBSIDIAN.defaultBlockState());
				if (k < len / 2) {
					a.set(x + 1, y0 - k, z, Blocks.OBSIDIAN.defaultBlockState());
					a.set(x, y0 - k, z + 1, Blocks.OBSIDIAN.defaultBlockState());
				}
			}
			a.set(x, y0 + 1, z, Blocks.END_ROD.defaultBlockState());
		}
		// End rods along the wall like candles.
		for (int i = 0; i < 20; i++) {
			double ang = Math.PI * 2 * i / 20;
			a.set((int) Math.round(Math.cos(ang) * r), 3, (int) Math.round(Math.sin(ang) * r), Blocks.END_ROD.defaultBlockState());
		}
		Palette.Weighted top = Palette.of(Blocks.END_STONE, 3, Blocks.PURPUR_BLOCK, 1);
		for (int i = 0; i < 5; i++) {
			double ang = a.random.nextDouble() * Math.PI * 2;
			int d = r + 14 + a.random.nextInt(10);
			a.island((int) (Math.cos(ang) * d), -8 + a.random.nextInt(14), (int) (Math.sin(ang) * d), 3, top, Blocks.END_STONE.defaultBlockState(), Blocks.PEARLESCENT_FROGLIGHT.defaultBlockState());
		}
	}

	@Override
	public void spawnWave(TrialSession s, int wave) {
		int mites = wave == 0 ? 6 : wave == 1 ? 3 : 0;
		int men = wave == 0 ? 0 : wave == 1 ? 3 : 2;
		for (int i = 0; i < mites; i++) {
			TrialKit.mob(s, EntityType.ENDERMITE, TrialKit.spawnRing(s, i, mites, 13), true, m -> {
				TrialKit.stats(m, 14, 4, 0.3, 1.4, 0);
				TrialKit.name(m, "Voidling", PURPLE);
			});
		}
		for (int i = 0; i < men; i++) {
			TrialKit.mob(s, EntityType.ENDERMAN, TrialKit.spawnRing(s, i, men, 16), true, m -> {
				TrialKit.stats(m, 44, 7, 0.32, 1.0, 2);
				TrialKit.name(m, "Hollow Watcher", PURPLE);
			});
		}
	}

	@Override
	public Mob spawnBoss(TrialSession s, Vec3 at) {
		return TrialKit.mob(s, EntityType.ENDERMAN, at, false, m -> {
			TrialKit.stats(m, 400, 11, 0.33, 1.45, 8);
			TrialKit.boss(m, bossName(), PURPLE);
		});
	}

	@Override
	public void bossEntrance(TrialSession s, Mob boss) {
		Vec3 c = boss.position().add(0, 1.5, 0);
		Fx.implode(s.level, Fx.dust(PURPLE, 2f), c, 6, 120, 0.6);
		Fx.far(s.level, ParticleTypes.REVERSE_PORTAL, c, 150, 1.5, 0.3);
		Fx.sound(s.level, c, SoundEvents.ENDERMAN_SCREAM, 2f, 0.5f);
		Fx.custom(s.level, c, "void_rift", 2f, 0.6f);
	}

	@Override
	public void bossTick(TrialSession s, Mob boss) {
		if (s.fightAge % 3 == 0) Fx.at(s.level, ParticleTypes.PORTAL, boss.position().add(0, 1.5, 0), 6, 0.6, 0.3);
		if (s.ready("rift", 170)) rift(s, boss);
		else if (s.ready("step", s.phase >= 3 ? 90 : 120)) shadowStep(s, boss);
		if (s.phase >= 3 && s.ready("cracks", 220)) cracks(s);
		if (s.phase >= 3 && s.ready("dark", 260)) TrialKit.effect(s, MobEffects.DARKNESS, 80, 0);
		if (s.phase >= 4) horizon(s, boss);
	}

	private void rift(TrialSession s, Mob boss) {
		TrialKit.callout(s, "A rift opens! Pull away from it!", PURPLE);
		Vec3 p = TrialKit.playerPos(s);
		Vec3 b = boss.position();
		Vec3 c = new Vec3((p.x + b.x) / 2, Arena.FLOOR_Y + 2, (p.z + b.z) / 2);
		var orb = TrialKit.blockDisplay(s, c, Blocks.CRYING_OBSIDIAN.defaultBlockState(), 0.8f);
		Fx.sound(s.level, c, SoundEvents.PORTAL_TRIGGER, 1f, 1.6f);
		Scheduler.repeat(0, 1, 50, i -> {
			if (!s.active() || !s.fighting()) {
				if (orb != null) orb.discard();
				return false;
			}
			Fx.implode(s.level, Fx.dust(PURPLE, 1.2f), c, 4, 8, 0.25);
			var pl = s.player();
			if (pl != null && pl.position().distanceTo(c) < 11) {
				Vec3 pull = c.subtract(pl.position()).normalize().scale(0.055);
				Ctx.push(pl, new Vec3(pull.x, 0, pull.z));
			}
			if (i == 49) {
				if (orb != null) orb.discard();
				Fx.far(s.level, ParticleTypes.REVERSE_PORTAL, c, 80, 0.5, 0.6);
				Fx.flash(s.level, c);
				Fx.sound(s.level, c, SoundEvents.ENDER_DRAGON_FLAP, 2f, 0.6f);
				TrialKit.blast(s, boss, c, 3.2, 9, 1.0, 0.4);
			}
			return true;
		});
	}

	private void shadowStep(TrialSession s, Mob boss) {
		var p = s.player();
		if (p == null) return;
		Fx.at(s.level, ParticleTypes.REVERSE_PORTAL, boss.position().add(0, 1.5, 0), 40, 0.4, 0.2);
		Vec3 behind = p.position().subtract(p.getLookAngle().multiply(1, 0, 1).normalize().scale(2.2));
		if (!s.arena.inside(behind, -1)) behind = p.position();
		Vec3 at = behind;
		Scheduler.later(8, () -> {
			if (!s.active() || !boss.isAlive()) return;
			boss.teleportTo(at.x, Arena.FLOOR_Y + 1, at.z);
			Fx.sound(s.level, at, SoundEvents.ENDERMAN_TELEPORT, 1.5f, 0.6f);
			Fx.far(s.level, Fx.dust(DARK, 2f), at.add(0, 1, 0), 40, 0.5, 0);
			TrialKit.effect(s, MobEffects.DARKNESS, 50, 0);
			TrialKit.telegraph(s, at, 2.5, 10, PURPLE, () -> TrialKit.blast(s, boss, boss.position().add(0, 1, 0), 2.8, 9, 0.7, 0.2));
		});
	}

	private void cracks(TrialSession s) {
		TrialKit.callout(s, "The floor cracks into nothing!", PURPLE);
		for (int i = 0; i < 4; i++) {
			Vec3 c = i == 0 ? TrialKit.predict(s, 10) : s.arena.floorPoint(3, s.arena.radius - 3);
			Vec3 g = new Vec3(c.x, Arena.FLOOR_Y + 1, c.z);
			TrialKit.telegraph(s, g, 3, 25, DARK, () -> TrialKit.zone(s, g, 3, 200, 5, DARK));
		}
	}

	private void horizon(TrialSession s, Mob boss) {
		Vec3 c = s.arena.centerTop();
		if (s.var("horizon") == 0) {
			s.var("horizon", 1);
			TrialKit.callout(s, "EVENT HORIZON: resist the pull!", PURPLE);
			TrialKit.zone(s, c, 4, 20 * 900, 8, PURPLE);
			Fx.sound(s.level, c, SoundEvents.END_PORTAL_SPAWN, 1.5f, 0.6f);
		}
		var p = s.player();
		if (p != null && p.position().distanceTo(c) > 3) {
			Vec3 pull = c.subtract(p.position()).normalize().scale(0.035);
			Ctx.push(p, new Vec3(pull.x, 0, pull.z));
		}
		if (s.fightAge % 4 == 0) Fx.implode(s.level, Fx.dust(PURPLE, DARK, 1.5f), c.add(0, 1, 0), 9, 20, 0.5);
	}

	@Override
	public void ambient(TrialSession s) {
		Vec3 p = TrialKit.playerPos(s);
		Fx.at(s.level, ParticleTypes.PORTAL, p.add(0, 1, 0), 20, 8, 0.2);
		Fx.at(s.level, ParticleTypes.WHITE_ASH, p.add(0, 3, 0), 15, 8, 0);
	}
}
