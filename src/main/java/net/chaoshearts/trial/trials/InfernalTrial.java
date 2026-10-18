package net.chaoshearts.trial.trials;

import net.chaoshearts.fx.Fx;
import net.chaoshearts.fx.Scheduler;
import net.chaoshearts.fx.SimProjectile;
import net.chaoshearts.heart.HeartType;
import net.chaoshearts.trial.Arena;
import net.chaoshearts.trial.Palette;
import net.chaoshearts.trial.Trial;
import net.chaoshearts.trial.TrialKit;
import net.chaoshearts.trial.TrialSession;
import net.minecraft.core.particles.ParticleTypes;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.world.BossEvent;
import net.minecraft.world.entity.EntityType;
import net.minecraft.world.entity.Mob;
import net.minecraft.world.entity.monster.MagmaCube;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.Items;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.world.level.block.CampfireBlock;
import net.minecraft.world.phys.Vec3;

/** Ignaroth rains meteors, sends flame waves to jump over and finally hunts with seeking fire. */
public final class InfernalTrial extends Trial {
	private static final int ORANGE = 0xFF7A1A;
	private static final int EMBER = 0x8C1C00;

	public InfernalTrial() {
		super(HeartType.INFERNAL);
	}

	@Override
	public String title() {
		return "The Cinder Throne";
	}

	@Override
	public String tagline() {
		return "Walk through fire, or become its fuel.";
	}

	@Override
	public String bossName() {
		return "Ignaroth, Lord of Cinders";
	}

	@Override
	public BossEvent.BossBarColor barColor() {
		return BossEvent.BossBarColor.YELLOW;
	}

	@Override
	public Palette palette() {
		return new Palette(
				Palette.of(Blocks.POLISHED_BASALT, 3, Blocks.BLACKSTONE, 3, Blocks.MAGMA_BLOCK, 1, Blocks.NETHERRACK, 1),
				Palette.of(Blocks.BASALT, 2, Blocks.BLACKSTONE, 1),
				Blocks.POLISHED_BLACKSTONE_BRICKS.defaultBlockState(),
				Blocks.NETHER_BRICKS.defaultBlockState(),
				Blocks.BASALT.defaultBlockState(),
				Blocks.MAGMA_BLOCK.defaultBlockState(),
				Blocks.OCHRE_FROGLIGHT.defaultBlockState());
	}

	@Override
	public void decorate(Arena a) {
		int r = a.radius;
		// Braziers on the wall.
		for (int i = 0; i < 12; i++) {
			double ang = Math.PI * 2 * i / 12;
			int x = (int) Math.round(Math.cos(ang) * r), z = (int) Math.round(Math.sin(ang) * r);
			a.set(x, 2, z, Blocks.NETHER_BRICKS.defaultBlockState());
			a.set(x, 3, z, Blocks.CAMPFIRE.defaultBlockState().setValue(CampfireBlock.LIT, true));
		}
		// Fire pits beyond the cage: netherrack burns forever.
		for (int i = 0; i < 10; i++) {
			double ang = Math.PI * 2 * i / 10 + 0.3;
			int x = (int) Math.round(Math.cos(ang) * (r + 6)), z = (int) Math.round(Math.sin(ang) * (r + 6));
			for (int ox = -1; ox <= 1; ox++) for (int oz = -1; oz <= 1; oz++) {
				a.set(x + ox, -1, z + oz, Blocks.NETHERRACK.defaultBlockState());
				a.set(x + ox, -2, z + oz, Blocks.MAGMA_BLOCK.defaultBlockState());
				a.set(x + ox, 0, z + oz, Blocks.FIRE.defaultBlockState());
			}
		}
		// Basalt spires rising from below.
		Palette.Weighted top = Palette.of(Blocks.BLACKSTONE, 2, Blocks.MAGMA_BLOCK, 1);
		for (int i = 0; i < 8; i++) {
			double ang = a.random.nextDouble() * Math.PI * 2;
			int d = r + 9 + a.random.nextInt(14);
			int x = (int) (Math.cos(ang) * d), z = (int) (Math.sin(ang) * d);
			int h = 4 + a.random.nextInt(10);
			for (int y = -20; y <= h; y++) a.set(x, y, z, y % 5 == 0 ? Blocks.MAGMA_BLOCK.defaultBlockState() : Blocks.BASALT.defaultBlockState());
			a.island(x, -14 + a.random.nextInt(6), z, 2, top, Blocks.BASALT.defaultBlockState(), Blocks.OCHRE_FROGLIGHT.defaultBlockState());
		}
	}

	@Override
	public void spawnWave(TrialSession s, int wave) {
		int blazes = wave == 0 ? 3 : wave == 1 ? 3 : 2;
		int cubes = wave == 0 ? 2 : wave == 1 ? 3 : 1;
		for (int i = 0; i < blazes; i++) {
			TrialKit.mob(s, EntityType.BLAZE, TrialKit.spawnRing(s, i, blazes, 15).add(0, 2, 0), true, m -> {
				TrialKit.stats(m, 22, 5, 0, 1.0, 0);
				TrialKit.name(m, "Cinderling", ORANGE);
			});
		}
		for (int i = 0; i < cubes; i++) {
			TrialKit.mob(s, EntityType.MAGMA_CUBE, TrialKit.spawnRing(s, i, cubes, 12), true, m -> {
				((MagmaCube) m).setSize(wave == 0 ? 2 : 3, true);
				TrialKit.name(m, "Molten Husk", ORANGE);
			});
		}
	}

	@Override
	public Mob spawnBoss(TrialSession s, Vec3 at) {
		return TrialKit.mob(s, EntityType.BLAZE, at.add(0, 1, 0), false, m -> {
			TrialKit.stats(m, 380, 9, 0, 2.6, 8);
			TrialKit.boss(m, bossName(), ORANGE);
		});
	}

	@Override
	public void bossEntrance(TrialSession s, Mob boss) {
		Vec3 c = boss.position();
		Fx.far(s.level, ParticleTypes.FLAME, c.add(0, 1, 0), 150, 1.5, 0.15);
		Fx.far(s.level, ParticleTypes.LAVA, c.add(0, 1, 0), 40, 1, 0.2);
		Fx.helix(s.level, Fx.dust(ORANGE, EMBER, 2f), c, 2, 6, 3, 90, 0);
		Fx.sound(s.level, c, SoundEvents.BLAZE_AMBIENT, 3f, 0.5f);
		Fx.custom(s.level, c, "infernal_burst", 2f, 0.7f);
	}

	@Override
	public void bossTick(TrialSession s, Mob boss) {
		if (s.fightAge % 3 == 0) Fx.at(s.level, ParticleTypes.FLAME, boss.position().add(0, 1.5, 0), 4, 0.8, 0.02);
		if (s.ready("meteors", s.phase >= 3 ? 130 : 180)) meteorRain(s, boss);
		else if (s.ready("wave", 150)) flameWave(s, boss);
		if (s.phase >= 3 && s.ready("hellgate", 320)) hellgates(s);
		if (s.phase >= 4 && s.ready("seekers", 45)) seekers(s, boss);
	}

	private void meteorRain(TrialSession s, Mob boss) {
		TrialKit.callout(s, "The sky splits... meteors!", ORANGE);
		int n = s.phase >= 3 ? 7 : 5;
		for (int i = 0; i < n; i++) {
			Vec3 at = i == 0 ? TrialKit.predict(s, 15) : TrialKit.playerPos(s).add((s.level.random.nextDouble() - 0.5) * 12, 0, (s.level.random.nextDouble() - 0.5) * 12);
			Vec3 ground = new Vec3(at.x, Arena.FLOOR_Y + 1, at.z);
			if (!s.arena.inside(ground, -1)) continue;
			Scheduler.later(i * 4, () -> TrialKit.telegraph(s, ground, 2.5, 32, ORANGE, () -> TrialKit.drop(s, ground, Blocks.MAGMA_BLOCK.defaultBlockState(), 1.4f, 8, () -> {
				Fx.far(s.level, ParticleTypes.LAVA, ground, 25, 0.8, 0.2);
				Fx.far(s.level, ParticleTypes.FLAME, ground, 40, 1, 0.1);
				Fx.sound(s.level, ground, SoundEvents.GENERIC_EXPLODE.value(), 1f, 1.1f);
				if (TrialKit.blast(s, boss, ground, 2.8, 8, 0.6, 0.5)) {
					var p = s.player();
					if (p != null) p.igniteForSeconds(3);
				}
			})));
		}
	}

	private void flameWave(TrialSession s, Mob boss) {
		TrialKit.callout(s, "A wave of fire! Jump over it!", ORANGE);
		Vec3 c = new Vec3(boss.getX(), Arena.FLOOR_Y + 1, boss.getZ());
		Fx.sound(s.level, c, SoundEvents.BLAZE_SHOOT, 2f, 0.5f);
		boolean[] hit = {false};
		Scheduler.repeat(15, 1, s.arena.radius + 4, i -> {
			if (!s.active() || !s.fighting()) return false;
			double rad = 1 + i;
			Fx.ring(s.level, ParticleTypes.FLAME, c.add(0, 0.2, 0), rad, (int) (rad * 7), 0);
			if (i % 2 == 0) Fx.ring(s.level, Fx.dust(ORANGE, 1.5f), c.add(0, 0.6, 0), rad, (int) (rad * 4), 0.2);
			if (i % 4 == 0) Fx.sound(s.level, c, SoundEvents.FIRECHARGE_USE, 0.8f, 0.6f + i * 0.02f);
			var p = s.player();
			if (!hit[0] && p != null) {
				double d = Math.sqrt(Math.pow(p.getX() - c.x, 2) + Math.pow(p.getZ() - c.z, 2));
				boolean grounded = p.getY() - (Arena.FLOOR_Y + 1) < 0.6;
				if (Math.abs(d - rad) < 0.9 && grounded) {
					hit[0] = true;
					TrialKit.hit(s, boss, 7);
					p.igniteForSeconds(4);
				}
			}
			return true;
		});
	}

	private void hellgates(TrialSession s) {
		TrialKit.callout(s, "Hellgates open in the floor!", EMBER);
		for (int i = 0; i < 4; i++) {
			Vec3 c = s.arena.floorPoint(4, s.arena.radius - 4);
			TrialSession.Zone z = TrialKit.zone(s, c, 3, 300, 4, 0xFF4400);
			z.onTouch = p -> p.igniteForSeconds(2);
			Fx.far(s.level, ParticleTypes.LAVA, c, 20, 1, 0.2);
		}
	}

	private void seekers(TrialSession s, Mob boss) {
		var p = s.player();
		if (p == null) return;
		Vec3 from = boss.position().add(0, boss.getBbHeight() * 0.6, 0);
		Vec3 dir = p.position().add(0, 1, 0).subtract(from).normalize().scale(0.45);
		var disp = TrialKit.itemDisplay(s, from, new ItemStack(Items.FIRE_CHARGE), 0.9f);
		SimProjectile proj = TrialKit.shoot(s, boss, from, dir, ParticleTypes.FLAME, disp, 6, 0.6, at -> {
			Fx.far(s.level, ParticleTypes.FLAME, at, 20, 0.4, 0.08);
			Fx.sound(s.level, at, SoundEvents.FIRECHARGE_USE, 1f, 1.2f);
		});
		proj.homingTarget = p;
		proj.homingStrength = 0.07;
		proj.maxTicks = 100;
		Fx.sound(s.level, from, SoundEvents.BLAZE_SHOOT, 1.5f, 0.8f);
	}

	@Override
	public void ambient(TrialSession s) {
		Vec3 p = TrialKit.playerPos(s);
		Fx.at(s.level, ParticleTypes.LAVA, p.add(0, 1, 0), 2, 8, 0);
		Fx.at(s.level, ParticleTypes.SMALL_FLAME, p.add(0, 3, 0), 15, 9, 0.01);
		Fx.at(s.level, ParticleTypes.ASH, p.add(0, 3, 0), 20, 9, 0);
	}
}
