package net.chaoshearts.trial.trials;

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
import net.minecraft.world.effect.MobEffectInstance;
import net.minecraft.world.effect.MobEffects;
import net.minecraft.world.entity.EntityType;
import net.minecraft.world.entity.EquipmentSlot;
import net.minecraft.world.entity.Mob;
import net.minecraft.world.entity.monster.zombie.Zombie;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.Items;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.world.phys.Vec3;

/** Vael blinks behind you and leaves afterimages that detonate. Then it starts stealing time. */
public final class SpeedTrial extends Trial {
	private static final int GOLD = 0xF5E142;
	private static final int CYAN = 0x29D3F2;

	public SpeedTrial() {
		super(HeartType.SPEED);
	}

	@Override
	public String title() {
		return "The Racing Hour";
	}

	@Override
	public String tagline() {
		return "Every second you waste is a second it steals.";
	}

	@Override
	public String bossName() {
		return "Vael, the Stolen Second";
	}

	@Override
	public BossEvent.BossBarColor barColor() {
		return BossEvent.BossBarColor.YELLOW;
	}

	@Override
	public Palette palette() {
		return new Palette(
				Palette.of(Blocks.SMOOTH_QUARTZ, 4, Blocks.WHITE_CONCRETE, 3, Blocks.QUARTZ_BRICKS, 1),
				Palette.of(Blocks.QUARTZ_BLOCK, 1),
				Blocks.YELLOW_CONCRETE.defaultBlockState(),
				Blocks.WHITE_CONCRETE.defaultBlockState(),
				Blocks.QUARTZ_PILLAR.defaultBlockState(),
				Blocks.LIGHT_BLUE_CONCRETE.defaultBlockState(),
				Blocks.GLOWSTONE.defaultBlockState());
	}

	@Override
	public void decorate(Arena a) {
		int r = a.radius;
		// A racetrack ring with lane markings.
		for (int i = 0; i < 160; i++) {
			double ang = Math.PI * 2 * i / 160;
			a.set((int) Math.round(Math.cos(ang) * 13), 0, (int) Math.round(Math.sin(ang) * 13), Blocks.YELLOW_CONCRETE.defaultBlockState());
			a.set((int) Math.round(Math.cos(ang) * 15), 0, (int) Math.round(Math.sin(ang) * 15), Blocks.LIGHT_BLUE_CONCRETE.defaultBlockState());
			if (i % 10 < 5) a.set((int) Math.round(Math.cos(ang) * 14), 0, (int) Math.round(Math.sin(ang) * 14), Blocks.GOLD_BLOCK.defaultBlockState());
		}
		// Clock face: twelve hour marks around the sigil.
		for (int h = 0; h < 12; h++) {
			double ang = Math.PI * 2 * h / 12;
			a.set((int) Math.round(Math.cos(ang) * 9), 0, (int) Math.round(Math.sin(ang) * 9), Blocks.GOLD_BLOCK.defaultBlockState());
		}
		// Speed fins outside the wall.
		for (int i = 0; i < 16; i++) {
			double ang = Math.PI * 2 * i / 16;
			for (int k = 0; k < 6; k++) {
				int x = (int) Math.round(Math.cos(ang) * (r + 4 + k)), z = (int) Math.round(Math.sin(ang) * (r + 4 + k));
				for (int y = -2 + k / 2; y <= 3 - k / 2; y++) a.set(x, y, z, (k + y) % 3 == 0 ? Blocks.YELLOW_STAINED_GLASS.defaultBlockState() : Blocks.WHITE_STAINED_GLASS.defaultBlockState());
			}
		}
		Palette.Weighted top = Palette.of(Blocks.SMOOTH_QUARTZ, 2, Blocks.GOLD_BLOCK, 1);
		for (int i = 0; i < 6; i++) {
			double ang = a.random.nextDouble() * Math.PI * 2;
			int d = r + 12 + a.random.nextInt(12);
			a.island((int) (Math.cos(ang) * d), -4 + a.random.nextInt(16), (int) (Math.sin(ang) * d), 2, top, Blocks.QUARTZ_BLOCK.defaultBlockState(), Blocks.GLOWSTONE.defaultBlockState());
		}
	}

	@Override
	public void spawnWave(TrialSession s, int wave) {
		int quick = wave == 0 ? 6 : wave == 1 ? 5 : 4;
		int ticks = wave == 1 ? 4 : 0;
		for (int i = 0; i < quick; i++) {
			TrialKit.mob(s, EntityType.ZOMBIE, TrialKit.spawnRing(s, i, quick, 15), true, m -> {
				((Zombie) m).setBaby(true);
				TrialKit.stats(m, 16, 4, 0.42, 0, 2);
				TrialKit.name(m, "Quickling", GOLD);
				TrialKit.equip(m, EquipmentSlot.HEAD, new ItemStack(Items.GOLDEN_HELMET));
			});
		}
		for (int i = 0; i < ticks; i++) {
			TrialKit.mob(s, EntityType.SILVERFISH, TrialKit.spawnRing(s, i, ticks, 10), true, m -> {
				TrialKit.stats(m, 12, 3, 0.35, 1.3, 0);
				TrialKit.name(m, "Tick", CYAN);
			});
		}
	}

	@Override
	public Mob spawnBoss(TrialSession s, Vec3 at) {
		return TrialKit.mob(s, EntityType.VINDICATOR, at, false, m -> {
			TrialKit.stats(m, 360, 9, 0.42, 1.25, 6);
			TrialKit.boss(m, bossName(), GOLD);
			TrialKit.equip(m, EquipmentSlot.MAINHAND, new ItemStack(Items.GOLDEN_AXE));
			TrialKit.equip(m, EquipmentSlot.HEAD, new ItemStack(Items.GOLDEN_HELMET));
		});
	}

	@Override
	public void bossEntrance(TrialSession s, Mob boss) {
		Vec3 c = boss.position();
		for (int i = 0; i < 6; i++) Fx.helix(s.level, Fx.dust(i % 2 == 0 ? GOLD : CYAN, 1.4f), c, 1.5 - i * 0.2, 3, 3, 50, i);
		Fx.flash(s.level, c.add(0, 1.5, 0));
		Fx.sound(s.level, c, SoundEvents.TRIDENT_RIPTIDE_3.value(), 2f, 1.4f);
		Fx.custom(s.level, c, "speed_dash", 2f, 0.8f);
	}

	@Override
	public void onPhase(TrialSession s, Mob boss, int phase) {
		if (phase == 3) boss.addEffect(new MobEffectInstance(MobEffects.SPEED, 20 * 900, 1));
	}

	@Override
	public void bossTick(TrialSession s, Mob boss) {
		if (s.fightAge % 2 == 0) Fx.at(s.level, Fx.dust(GOLD, CYAN, 1f), boss.position().add(0, 1, 0), 2, 0.3, 0);
		if (s.ready("blink", s.phase >= 4 ? 60 : 100)) blink(s, boss);
		else if (s.ready("dash", 170)) afterimages(s, boss);
		if (s.phase >= 3 && s.ready("theft", 240)) timeTheft(s);
		if (s.phase >= 4 && s.ready("tock", 110)) tickTock(s, boss);
	}

	private void blink(TrialSession s, Mob boss) {
		Vec3 from = boss.position();
		Fx.at(s.level, Fx.dust(GOLD, 1.5f), from.add(0, 1, 0), 30, 0.4, 0);
		Fx.sound(s.level, from, SoundEvents.ENDERMAN_TELEPORT, 1f, 1.8f);
		boss.setInvisible(true);
		for (int i = 0; i < 3; i++) {
			int k = i;
			Scheduler.later(4 * i, () -> {
				var p = s.player();
				if (p != null) net.chaoshearts.fx.Fx.soundTo(p, SoundEvents.NOTE_BLOCK_HAT.value(), 1f, 1.4f + k * 0.2f);
			});
		}
		Scheduler.later(12, () -> {
			if (!s.active() || !boss.isAlive()) return;
			boss.setInvisible(false);
			var p = s.player();
			if (p == null) return;
			Vec3 behind = p.position().subtract(p.getLookAngle().multiply(1, 0, 1).normalize().scale(2.4));
			if (!s.arena.inside(behind, -1)) behind = p.position().add(1.5, 0, 0);
			boss.teleportTo(behind.x, p.getY(), behind.z);
			Fx.flash(s.level, behind.add(0, 1, 0));
			Fx.sound(s.level, behind, SoundEvents.PLAYER_ATTACK_SWEEP, 1.5f, 1.3f);
			Fx.at(s.level, ParticleTypes.SWEEP_ATTACK, behind.add(0, 1, 0), 3, 0.5, 0);
			TrialKit.blast(s, boss, behind.add(0, 1, 0), 2.9, 8, 0.6, 0.2);
		});
	}

	private void afterimages(TrialSession s, Mob boss) {
		TrialKit.callout(s, "Vael leaves afterimages... stay off the lines!", GOLD);
		Vec3 a = boss.position();
		Vec3[] pts = new Vec3[4];
		pts[0] = a;
		for (int i = 1; i < 4; i++) {
			Vec3 target = i == 3 ? TrialKit.predict(s, 10) : s.arena.floorPoint(3, s.arena.radius - 4);
			pts[i] = new Vec3(target.x, Arena.FLOOR_Y + 1, target.z);
		}
		for (int i = 1; i < 4; i++) {
			int seg = i;
			Scheduler.later(6 * i, () -> {
				if (!s.active() || !boss.isAlive()) return;
				boss.teleportTo(pts[seg].x, pts[seg].y, pts[seg].z);
				Fx.line(s.level, Fx.dust(GOLD, 1.4f), pts[seg - 1].add(0, 1, 0), pts[seg].add(0, 1, 0), 0.4);
				Fx.sound(s.level, pts[seg], SoundEvents.BREEZE_WIND_CHARGE_BURST.value(), 1f, 1.6f);
				// The trail detonates a moment later.
				Scheduler.repeat(0, 3, 6, k -> {
					if (!s.active()) return false;
					Fx.line(s.level, Fx.dust(0xFFFFFF, 1f), pts[seg - 1].add(0, 0.6, 0), pts[seg].add(0, 0.6, 0), 0.6);
					return true;
				});
				Scheduler.later(20, () -> {
					if (!s.active() || !s.fighting()) return;
					Fx.line(s.level, ParticleTypes.ELECTRIC_SPARK, pts[seg - 1].add(0, 1, 0), pts[seg].add(0, 1, 0), 0.3);
					Fx.sound(s.level, pts[seg], SoundEvents.FIREWORK_ROCKET_BLAST, 1.2f, 1.5f);
					var p = s.player();
					if (p != null && TrialKit.segmentDistance(p.position().add(0, 0.5, 0), pts[seg - 1].add(0, 0.5, 0), pts[seg].add(0, 0.5, 0)) < 1.4) TrialKit.hit(s, boss, 6);
				});
			});
		}
	}

	private void timeTheft(TrialSession s) {
		TrialKit.callout(s, "Time slows in the clock fields!", CYAN);
		for (int i = 0; i < 3; i++) {
			Vec3 c = i == 0 ? TrialKit.playerPos(s) : s.arena.floorPoint(4, s.arena.radius - 4);
			TrialSession.Zone z = TrialKit.zone(s, new Vec3(c.x, Arena.FLOOR_Y + 1, c.z), 4, 160, 0, CYAN);
			z.onTouch = p -> p.addEffect(new MobEffectInstance(MobEffects.SLOWNESS, 30, 2, false, true, true));
			Fx.sound(s.level, c, SoundEvents.BEACON_AMBIENT, 1f, 2f);
		}
	}

	private void tickTock(TrialSession s, Mob boss) {
		Vec3 c = TrialKit.playerPos(s);
		Vec3 ground = new Vec3(c.x, Arena.FLOOR_Y + 1, c.z);
		TrialKit.callout(s, "Tick... tock...", GOLD);
		TrialKit.telegraph(s, ground, 3, 28, GOLD, () -> {
			Fx.far(s.level, Fx.dust(GOLD, 2.5f), ground.add(0, 1, 0), 40, 1.2, 0);
			Fx.sound(s.level, ground, SoundEvents.BELL_BLOCK, 2f, 1.5f);
			TrialKit.blast(s, boss, ground, 3.2, 10, 0.8, 0.4);
		});
	}

	@Override
	public void ambient(TrialSession s) {
		Vec3 p = TrialKit.playerPos(s);
		Fx.at(s.level, ParticleTypes.END_ROD, p.add(0, 2, 0), 4, 7, 0.01);
		Fx.at(s.level, Fx.dust(GOLD, 0.8f), p.add(0, 2, 0), 10, 8, 0);
	}
}
