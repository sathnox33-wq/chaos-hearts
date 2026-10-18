package net.chaoshearts.trial.trials;

import net.chaoshearts.fx.Fx;
import net.chaoshearts.fx.Scheduler;
import net.chaoshearts.fx.TempBlocks;
import net.chaoshearts.heart.HeartType;
import net.chaoshearts.trial.Arena;
import net.chaoshearts.trial.Palette;
import net.chaoshearts.trial.Trial;
import net.chaoshearts.trial.TrialKit;
import net.chaoshearts.trial.TrialSession;
import net.minecraft.core.BlockPos;
import net.minecraft.core.particles.BlockParticleOption;
import net.minecraft.core.particles.ParticleTypes;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.world.BossEvent;
import net.minecraft.world.effect.MobEffectInstance;
import net.minecraft.world.effect.MobEffects;
import net.minecraft.world.entity.EntityType;
import net.minecraft.world.entity.EquipmentSlot;
import net.minecraft.world.entity.Mob;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.Items;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.world.level.block.state.BlockState;
import net.minecraft.world.phys.Vec3;

/** Hrimvald erupts ice under your feet, calls blizzards that freeze the still and imprisons the slow. */
public final class FrozenTrial extends Trial {
	private static final int ICE = 0x9BE7FF;
	private static final int DEEP = 0x2F6FA8;

	public FrozenTrial() {
		super(HeartType.FROZEN);
	}

	@Override
	public String title() {
		return "The Last Winter";
	}

	@Override
	public String tagline() {
		return "Keep moving. The cold only kills the still.";
	}

	@Override
	public String bossName() {
		return "Hrimvald, the Last Winter";
	}

	@Override
	public BossEvent.BossBarColor barColor() {
		return BossEvent.BossBarColor.BLUE;
	}

	@Override
	public Palette palette() {
		// No plain ice or snow layers: the arena's light would melt them.
		return new Palette(
				Palette.of(Blocks.PACKED_ICE, 3, Blocks.SNOW_BLOCK, 3, Blocks.BLUE_ICE, 1),
				Palette.of(Blocks.PACKED_ICE, 2, Blocks.SNOW_BLOCK, 1),
				Blocks.BLUE_ICE.defaultBlockState(),
				Blocks.SNOW_BLOCK.defaultBlockState(),
				Blocks.PACKED_ICE.defaultBlockState(),
				Blocks.BLUE_ICE.defaultBlockState(),
				Blocks.SEA_LANTERN.defaultBlockState());
	}

	@Override
	public void decorate(Arena a) {
		int r = a.radius;
		// Ice spikes beyond the wall.
		for (int i = 0; i < 12; i++) {
			double ang = Math.PI * 2 * i / 12 + a.random.nextDouble() * 0.3;
			int d = r + 5 + a.random.nextInt(8);
			int x = (int) (Math.cos(ang) * d), z = (int) (Math.sin(ang) * d);
			int h = 6 + a.random.nextInt(9);
			for (int y = -6; y <= h; y++) {
				int w = y < h / 3 ? 1 : 0;
				for (int ox = -w; ox <= w; ox++) for (int oz = -w; oz <= w; oz++) a.set(x + ox, y, z + oz, Blocks.PACKED_ICE.defaultBlockState());
			}
			a.set(x, h + 1, z, Blocks.BLUE_ICE.defaultBlockState());
		}
		Palette.Weighted top = Palette.of(Blocks.SNOW_BLOCK, 3, Blocks.PACKED_ICE, 1);
		for (int i = 0; i < 6; i++) {
			double ang = a.random.nextDouble() * Math.PI * 2;
			int d = r + 14 + a.random.nextInt(10);
			a.island((int) (Math.cos(ang) * d), -6 + a.random.nextInt(14), (int) (Math.sin(ang) * d), 3, top, Blocks.PACKED_ICE.defaultBlockState(), Blocks.SEA_LANTERN.defaultBlockState());
		}
		// Frozen lake in the middle.
		for (int dx = -4; dx <= 4; dx++) for (int dz = -4; dz <= 4; dz++) {
			if (dx * dx + dz * dz <= 16 && dx * dx + dz * dz > 2) a.set(dx, 0, dz, Blocks.BLUE_ICE.defaultBlockState());
		}
	}

	@Override
	public void spawnWave(TrialSession s, int wave) {
		int strays = wave == 0 ? 4 : wave == 1 ? 3 : 0;
		int bears = wave == 0 ? 1 : 2;
		for (int i = 0; i < strays; i++) {
			TrialKit.mob(s, EntityType.STRAY, TrialKit.spawnRing(s, i, strays, 16), true, m -> {
				TrialKit.stats(m, 26, 4, 0.27, 1.0, 2);
				TrialKit.name(m, "Frostbound", ICE);
				TrialKit.equip(m, EquipmentSlot.MAINHAND, new ItemStack(Items.BOW));
			});
		}
		for (int i = 0; i < bears; i++) {
			TrialKit.mob(s, EntityType.POLAR_BEAR, TrialKit.spawnRing(s, i, bears, 12), true, m -> {
				TrialKit.stats(m, 42, 7, 0.3, 1.1, 4);
				TrialKit.name(m, "Rimeclaw", ICE);
			});
		}
	}

	@Override
	public Mob spawnBoss(TrialSession s, Vec3 at) {
		return TrialKit.mob(s, EntityType.STRAY, at, false, m -> {
			TrialKit.stats(m, 380, 10, 0.27, 2.2, 10);
			TrialKit.boss(m, bossName(), ICE);
			TrialKit.equip(m, EquipmentSlot.MAINHAND, new ItemStack(Items.BOW));
			TrialKit.equip(m, EquipmentSlot.HEAD, new ItemStack(Items.DIAMOND_HELMET));
		});
	}

	@Override
	public void bossEntrance(TrialSession s, Mob boss) {
		Vec3 c = boss.position();
		Fx.far(s.level, ParticleTypes.SNOWFLAKE, c.add(0, 2, 0), 200, 2, 0.15);
		Fx.shockRing(s.level, Fx.dust(ICE, 2f), c.add(0, 0.3, 0), 1, 40, 0.5);
		Fx.sound(s.level, c, SoundEvents.GLASS_BREAK, 2f, 0.5f);
		Fx.custom(s.level, c, "frozen_shatter", 2f, 0.6f);
	}

	@Override
	public void bossTick(TrialSession s, Mob boss) {
		if (s.fightAge % 3 == 0) Fx.at(s.level, ParticleTypes.SNOWFLAKE, boss.position().add(0, 2, 0), 5, 0.8, 0.02);
		if (s.ready("spikes", s.phase >= 4 ? 80 : 130)) spikes(s, boss);
		boolean blizzard = s.phase >= 4 || s.var("blizzardUntil") > s.fightAge;
		if (!blizzard && s.ready("blizzard", 260)) {
			s.var("blizzardUntil", s.fightAge + 120);
			TrialKit.callout(s, "BLIZZARD: keep moving or freeze!", ICE);
			Fx.sound(s.level, boss.position(), SoundEvents.POWDER_SNOW_STEP, 3f, 0.4f);
		}
		if (blizzard) blizzardTick(s, boss);
		if (s.phase >= 3 && s.ready("prison", 200)) prison(s, boss);
	}

	private void spikes(TrialSession s, Mob boss) {
		Vec3 from = new Vec3(boss.getX(), Arena.FLOOR_Y + 1, boss.getZ());
		Vec3 dir = TrialKit.flat(TrialKit.predict(s, 8).subtract(from));
		Fx.sound(s.level, from, SoundEvents.GLASS_PLACE, 1.5f, 0.5f);
		for (int i = 1; i <= 7; i++) {
			Vec3 at = from.add(dir.scale(i * 2.2));
			if (!s.arena.inside(at, -1)) break;
			Scheduler.later(i * 3, () -> TrialKit.telegraph(s, at, 1.6, 16, ICE, () -> {
				var d = TrialKit.blockDisplay(s, at.add(0, -0.6, 0), Blocks.PACKED_ICE.defaultBlockState(), 1.3f);
				if (d != null) {
					net.chaoshearts.fx.Displays.teleportDuration(d, 3);
					net.chaoshearts.fx.Displays.move(d, at.add(0, 0.7, 0));
					Scheduler.later(25, d::discard);
				}
				Fx.at(s.level, new BlockParticleOption(ParticleTypes.BLOCK, Blocks.PACKED_ICE.defaultBlockState()), at.add(0, 0.5, 0), 20, 0.4, 0.1);
				Fx.sound(s.level, at, SoundEvents.GLASS_BREAK, 1f, 1.4f);
				if (TrialKit.blast(s, boss, at, 1.9, 8, 0.2, 0.7)) {
					var p = s.player();
					if (p != null) p.addEffect(new MobEffectInstance(MobEffects.SLOWNESS, 40, 1));
				}
			}));
		}
	}

	private void blizzardTick(TrialSession s, Mob boss) {
		var p = s.player();
		if (p == null) return;
		if (s.fightAge % 2 == 0) Fx.at(s.level, ParticleTypes.SNOWFLAKE, p.position().add(0, 2, 0), 25, 5, 0.1);
		Vec3 v = p.getDeltaMovement();
		boolean moving = v.x * v.x + v.z * v.z > 0.006;
		int f = p.getTicksFrozen();
		int max = p.getTicksRequiredToFreeze();
		p.setTicksFrozen(Math.max(0, Math.min(max + 20, f + (moving ? -3 : 5))));
		if (p.getTicksFrozen() >= max && s.fightAge % 20 == 0) {
			TrialKit.hit(s, boss, 3);
			TrialKit.callout(s, "You are freezing! Move!", ICE);
		}
	}

	private void prison(TrialSession s, Mob boss) {
		var p = s.player();
		if (p == null) return;
		Vec3 at = new Vec3(p.getX(), Arena.FLOOR_Y + 1, p.getZ());
		TrialKit.callout(s, "The ice closes in! Step out!", DEEP);
		TrialKit.telegraph(s, at, 1.6, 30, DEEP, () -> {
			if (!TrialKit.near(s, at.add(0, 0.5, 0), 1.6)) return;
			BlockPos feet = BlockPos.containing(p.position());
			BlockState ice = Blocks.PACKED_ICE.defaultBlockState();
			int[][] ring = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}};
			for (int y = 0; y < 3; y++) for (int[] o : ring) TempBlocks.place(s.level, feet.offset(o[0], y, o[1]), ice, 50);
			TempBlocks.place(s.level, feet.above(2), ice, 50);
			Fx.sound(s.level, at, SoundEvents.GLASS_PLACE, 2f, 0.6f);
			Fx.frostScreen(p, 200);
			TrialKit.hit(s, boss, 6);
		});
	}

	@Override
	public void ambient(TrialSession s) {
		Vec3 p = TrialKit.playerPos(s);
		Fx.at(s.level, ParticleTypes.SNOWFLAKE, p.add(0, 4, 0), 30, 9, 0.02);
		Fx.at(s.level, ParticleTypes.WHITE_ASH, p.add(0, 3, 0), 10, 8, 0);
	}
}
