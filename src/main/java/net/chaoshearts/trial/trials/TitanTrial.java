package net.chaoshearts.trial.trials;

import net.chaoshearts.fx.Displays;
import net.chaoshearts.fx.Fx;
import net.chaoshearts.fx.Scheduler;
import net.chaoshearts.heart.HeartType;
import net.chaoshearts.trial.Arena;
import net.chaoshearts.trial.Palette;
import net.chaoshearts.trial.Trial;
import net.chaoshearts.trial.TrialKit;
import net.chaoshearts.trial.TrialSession;
import net.minecraft.core.particles.BlockParticleOption;
import net.minecraft.core.particles.ParticleTypes;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.world.BossEvent;
import net.minecraft.world.entity.EntityType;
import net.minecraft.world.entity.EquipmentSlot;
import net.minecraft.world.entity.Mob;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.Items;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.world.level.block.state.BlockState;
import net.minecraft.world.phys.Vec3;

/** Golgoth splits the ground, hurls boulders and hardens its skin. In the end the sky falls. */
public final class TitanTrial extends Trial {
	private static final int SAND = 0xC9A45C;
	private static final int STONE = 0x5B5348;

	public TitanTrial() {
		super(HeartType.TITAN);
	}

	@Override
	public String title() {
		return "The Mountain That Walks";
	}

	@Override
	public String tagline() {
		return "You cannot outlast a mountain. You can only break it.";
	}

	@Override
	public String bossName() {
		return "Golgoth, the Mountain That Walks";
	}

	@Override
	public BossEvent.BossBarColor barColor() {
		return BossEvent.BossBarColor.WHITE;
	}

	@Override
	public int pillars() {
		return 8;
	}

	@Override
	public Palette palette() {
		return new Palette(
				Palette.of(Blocks.STONE_BRICKS, 3, Blocks.CRACKED_STONE_BRICKS, 2, Blocks.MOSSY_STONE_BRICKS, 1, Blocks.COBBLESTONE, 1, Blocks.ANDESITE, 1),
				Palette.of(Blocks.STONE, 2, Blocks.ANDESITE, 1),
				Blocks.CHISELED_STONE_BRICKS.defaultBlockState(),
				Blocks.STONE_BRICKS.defaultBlockState(),
				Blocks.POLISHED_GRANITE.defaultBlockState(),
				Blocks.RAW_GOLD_BLOCK.defaultBlockState(),
				Blocks.GLOWSTONE.defaultBlockState());
	}

	@Override
	public void decorate(Arena a) {
		int r = a.radius;
		// Broken colossal columns.
		for (int i = 0; i < 8; i++) {
			double ang = Math.PI * 2 * i / 8 + 0.2;
			int x = (int) Math.round(Math.cos(ang) * (r + 8)), z = (int) Math.round(Math.sin(ang) * (r + 8));
			int h = 4 + a.random.nextInt(14);
			for (int y = -12; y <= h; y++) {
				for (int ox = -2; ox <= 2; ox++) for (int oz = -2; oz <= 2; oz++) {
					if (ox * ox + oz * oz > 5) continue;
					if (y == h && a.random.nextFloat() < 0.4f) continue;
					a.set(x + ox, y, z + oz, y % 6 == 0 ? Blocks.CHISELED_STONE_BRICKS.defaultBlockState() : Blocks.POLISHED_GRANITE.defaultBlockState());
				}
			}
		}
		// Boulders hanging in the void.
		for (int i = 0; i < 7; i++) {
			double ang = a.random.nextDouble() * Math.PI * 2;
			int d = r + 14 + a.random.nextInt(12);
			int cx = (int) (Math.cos(ang) * d), cz = (int) (Math.sin(ang) * d), cy = -4 + a.random.nextInt(18);
			int br = 2 + a.random.nextInt(2);
			for (int ox = -br; ox <= br; ox++) for (int oy = -br; oy <= br; oy++) for (int oz = -br; oz <= br; oz++) {
				if (ox * ox + oy * oy + oz * oz <= br * br + a.random.nextInt(2)) a.set(cx + ox, cy + oy, cz + oz, a.random.nextBoolean() ? Blocks.COBBLESTONE.defaultBlockState() : Blocks.ANDESITE.defaultBlockState());
			}
		}
		// Footprints pressed into the floor.
		for (int i = 0; i < 4; i++) {
			int fx = -8 + i * 5, fz = 9 - (i % 2) * 4;
			for (int ox = -1; ox <= 1; ox++) for (int oz = -2; oz <= 2; oz++) a.set(fx + ox, 0, fz + oz, Blocks.COARSE_DIRT.defaultBlockState());
		}
	}

	@Override
	public void spawnWave(TrialSession s, int wave) {
		int mites = wave == 0 ? 8 : 6;
		int brutes = wave == 0 ? 2 : wave == 1 ? 3 : 0;
		for (int i = 0; i < mites; i++) {
			TrialKit.mob(s, EntityType.SILVERFISH, TrialKit.spawnRing(s, i, mites, 12), true, m -> {
				TrialKit.stats(m, 12, 3, 0.3, 1.2, 4);
				TrialKit.name(m, "Stonemite", SAND);
			});
		}
		for (int i = 0; i < brutes; i++) {
			TrialKit.mob(s, EntityType.ZOMBIE, TrialKit.spawnRing(s, i, brutes, 17), true, m -> {
				m.setBaby(false);
				TrialKit.stats(m, 36, 7, 0.24, 1.3, 8);
				TrialKit.name(m, "Quarry Brute", SAND);
				TrialKit.equip(m, EquipmentSlot.MAINHAND, new ItemStack(Items.IRON_PICKAXE));
				TrialKit.equip(m, EquipmentSlot.HEAD, new ItemStack(Items.IRON_HELMET));
			});
		}
	}

	@Override
	public Mob spawnBoss(TrialSession s, Vec3 at) {
		return TrialKit.mob(s, EntityType.IRON_GOLEM, at, false, m -> {
			TrialKit.stats(m, 460, 14, 0.28, 2.2, 12);
			TrialKit.boss(m, bossName(), SAND);
		});
	}

	@Override
	public void bossEntrance(TrialSession s, Mob boss) {
		Vec3 c = boss.position();
		BlockState stone = Blocks.STONE.defaultBlockState();
		Fx.far(s.level, new BlockParticleOption(ParticleTypes.BLOCK, stone), c.add(0, 1, 0), 200, 2, 0.3);
		Fx.shockRing(s.level, Fx.dust(SAND, 2f), c.add(0, 0.3, 0), 2, 50, 0.6);
		Fx.sound(s.level, c, SoundEvents.IRON_GOLEM_REPAIR, 3f, 0.4f);
		Fx.custom(s.level, c, "titan_quake", 2f, 0.6f);
	}

	@Override
	public float bossIncoming(TrialSession s, Mob boss, float amount) {
		if (s.var("skinUntil") > s.fightAge) {
			Fx.at(s.level, new BlockParticleOption(ParticleTypes.BLOCK, Blocks.STONE.defaultBlockState()), boss.position().add(0, 2, 0), 12, 0.8, 0.1);
			Fx.sound(s.level, boss.position(), SoundEvents.STONE_HIT, 1.5f, 0.6f);
			return amount * 0.35f;
		}
		return amount;
	}

	@Override
	public void bossTick(TrialSession s, Mob boss) {
		if (s.var("skinUntil") > s.fightAge && s.fightAge % 4 == 0) Fx.sphere(s.level, Fx.dust(STONE, 1.4f), boss.position().add(0, 2, 0), 2.6, 30);
		if (s.ready("shatter", 140)) earthshatter(s, boss);
		else if (s.ready("boulder", 170)) boulder(s, boss);
		if (s.phase >= 3 && s.ready("skin", 400)) {
			s.var("skinUntil", s.fightAge + 160);
			TrialKit.callout(s, "Golgoth's skin turns to stone! Dodge until it cracks.", SAND);
			Fx.sound(s.level, boss.position(), SoundEvents.ANVIL_PLACE, 1.5f, 0.5f);
		}
		if (s.phase >= 4 && s.ready("avalanche", 25)) avalanche(s, boss);
	}

	private void earthshatter(TrialSession s, Mob boss) {
		TrialKit.callout(s, "Golgoth raises its fists... the ground splits!", SAND);
		Vec3 from = new Vec3(boss.getX(), Arena.FLOOR_Y + 1, boss.getZ());
		Vec3 dir = TrialKit.flat(TrialKit.predict(s, 6).subtract(from));
		boss.getNavigation().stop();
		Fx.sound(s.level, from, SoundEvents.IRON_GOLEM_ATTACK, 2f, 0.5f);
		for (int i = 1; i <= 10; i++) {
			Vec3 at = from.add(dir.scale(i * 1.6));
			if (!s.arena.inside(at, -1)) break;
			int k = i;
			Scheduler.later(12 + i * 2, () -> TrialKit.telegraph(s, at, 1.6, 12, SAND, () -> {
				BlockState state = s.level.getBlockState(net.minecraft.core.BlockPos.containing(at).below());
				if (state.isAir()) state = Blocks.STONE_BRICKS.defaultBlockState();
				var d = TrialKit.blockDisplay(s, at.add(0, -0.4, 0), state, 1.1f);
				if (d != null) {
					Displays.teleportDuration(d, 3);
					Displays.move(d, at.add(0, 0.9, 0));
					Scheduler.later(18, d::discard);
				}
				Fx.at(s.level, new BlockParticleOption(ParticleTypes.BLOCK, state), at.add(0, 0.4, 0), 25, 0.5, 0.1);
				if (k % 3 == 1) Fx.sound(s.level, at, SoundEvents.GENERIC_EXPLODE.value(), 0.8f, 0.6f);
				TrialKit.blast(s, boss, at, 1.9, 9, 0.3, 0.8);
			}));
		}
	}

	private void boulder(TrialSession s, Mob boss) {
		TrialKit.callout(s, "Golgoth tears up a boulder!", SAND);
		Vec3 hold = boss.position().add(0, boss.getBbHeight() + 1.5, 0);
		var rock = TrialKit.blockDisplay(s, hold, Blocks.COBBLESTONE.defaultBlockState(), 2f);
		Fx.sound(s.level, hold, SoundEvents.STONE_BREAK, 2f, 0.5f);
		Scheduler.repeat(0, 1, 22, i -> {
			if (!s.active() || !boss.isAlive()) {
				if (rock != null) rock.discard();
				return false;
			}
			Vec3 h = boss.position().add(0, boss.getBbHeight() + 1.5, 0);
			if (rock != null) Displays.move(rock, h);
			if (i == 21) {
				Vec3 target = TrialKit.predict(s, 14);
				Vec3 d = target.subtract(h);
				double flight = 18;
				Vec3 vel = new Vec3(d.x / flight, (d.y + 0.5 * 0.06 * flight * flight) / flight, d.z / flight);
				var proj = TrialKit.shoot(s, boss, h, vel, new BlockParticleOption(ParticleTypes.BLOCK, Blocks.COBBLESTONE.defaultBlockState()), rock, 12, 1.2, at -> {
					Fx.far(s.level, new BlockParticleOption(ParticleTypes.BLOCK, Blocks.COBBLESTONE.defaultBlockState()), at, 60, 1.2, 0.2);
					Fx.far(s.level, ParticleTypes.EXPLOSION, at, 2, 0.5, 0);
					Fx.sound(s.level, at, SoundEvents.GENERIC_EXPLODE.value(), 1.5f, 0.6f);
					TrialKit.blast(s, boss, at, 3.2, 9, 1.2, 0.5);
				});
				proj.gravity = 0.06;
				proj.maxTicks = 60;
				Fx.sound(s.level, h, SoundEvents.IRON_GOLEM_ATTACK, 2f, 0.7f);
			}
			return true;
		});
	}

	private void avalanche(TrialSession s, Mob boss) {
		Vec3 at = TrialKit.playerPos(s).add((s.level.random.nextDouble() - 0.5) * 10, 0, (s.level.random.nextDouble() - 0.5) * 10);
		Vec3 g = new Vec3(at.x, Arena.FLOOR_Y + 1, at.z);
		if (!s.arena.inside(g, -1)) return;
		TrialKit.telegraph(s, g, 2, 22, STONE, () -> TrialKit.drop(s, g, Blocks.COBBLESTONE.defaultBlockState(), 1.6f, 7, () -> {
			Fx.far(s.level, new BlockParticleOption(ParticleTypes.BLOCK, Blocks.COBBLESTONE.defaultBlockState()), g, 30, 0.8, 0.1);
			Fx.sound(s.level, g, SoundEvents.STONE_BREAK, 1.5f, 0.6f);
			TrialKit.blast(s, boss, g, 2.3, 8, 0.5, 0.4);
		}));
	}

	@Override
	public void ambient(TrialSession s) {
		Vec3 p = TrialKit.playerPos(s);
		Fx.at(s.level, ParticleTypes.WHITE_ASH, p.add(0, 3, 0), 20, 9, 0);
		Fx.at(s.level, new BlockParticleOption(ParticleTypes.FALLING_DUST, Blocks.GRAVEL.defaultBlockState()), p.add(0, 8, 0), 10, 9, 0);
	}
}
