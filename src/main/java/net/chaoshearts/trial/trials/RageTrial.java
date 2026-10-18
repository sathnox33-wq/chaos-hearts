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
import net.minecraft.world.entity.ai.attributes.Attributes;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.Items;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.world.phys.Vec3;

/** Gorrath, a ravager that charges and roars. Fury grows as it bleeds. */
public final class RageTrial extends Trial {
	private static final int RED = 0xE0262B;

	public RageTrial() {
		super(HeartType.RAGE);
	}

	@Override
	public String title() {
		return "The Crucible of Fury";
	}

	@Override
	public String tagline() {
		return "Rage is a fire. Learn to hold it without burning.";
	}

	@Override
	public String bossName() {
		return "Gorrath, the Unbroken";
	}

	@Override
	public BossEvent.BossBarColor barColor() {
		return BossEvent.BossBarColor.RED;
	}

	@Override
	public Palette palette() {
		return new Palette(
				Palette.of(Blocks.BLACKSTONE, 4, Blocks.POLISHED_BLACKSTONE, 3, Blocks.CRACKED_POLISHED_BLACKSTONE_BRICKS, 2, Blocks.NETHERRACK, 1, Blocks.MAGMA_BLOCK, 1),
				Palette.of(Blocks.BLACKSTONE, 3, Blocks.BASALT, 1),
				Blocks.POLISHED_BLACKSTONE_BRICKS.defaultBlockState(),
				Blocks.RED_NETHER_BRICKS.defaultBlockState(),
				Blocks.POLISHED_BLACKSTONE_BRICKS.defaultBlockState(),
				Blocks.RED_NETHER_BRICKS.defaultBlockState(),
				Blocks.SHROOMLIGHT.defaultBlockState());
	}

	@Override
	public void decorate(Arena a) {
		int r = a.radius;
		// Four blood-red channels cut into the floor.
		for (int arm = 0; arm < 4; arm++) {
			double ang = Math.PI / 4 + arm * Math.PI / 2;
			for (int d = 7; d < r - 1; d++) a.set((int) Math.round(Math.cos(ang) * d), 0, (int) Math.round(Math.sin(ang) * d), Blocks.RED_NETHER_BRICKS.defaultBlockState());
		}
		// Weapon racks: iron spikes and chains beyond the wall.
		for (int i = 0; i < 24; i++) {
			double ang = Math.PI * 2 * i / 24;
			int x = (int) Math.round(Math.cos(ang) * (r + 5)), z = (int) Math.round(Math.sin(ang) * (r + 5));
			int h = 3 + a.random.nextInt(4);
			for (int y = -3; y <= h; y++) a.set(x, y, z, Blocks.IRON_BARS.defaultBlockState());
			a.set(x, -4, z, Blocks.POLISHED_BLACKSTONE.defaultBlockState());
		}
		Palette.Weighted top = Palette.of(Blocks.CRIMSON_NYLIUM, 3, Blocks.NETHERRACK, 1);
		for (int i = 0; i < 7; i++) {
			double ang = a.random.nextDouble() * Math.PI * 2;
			int d = r + 10 + a.random.nextInt(14);
			a.island((int) (Math.cos(ang) * d), -6 + a.random.nextInt(18), (int) (Math.sin(ang) * d), 2 + a.random.nextInt(3), top, Blocks.NETHERRACK.defaultBlockState(), Blocks.SHROOMLIGHT.defaultBlockState());
		}
	}

	@Override
	public void spawnWave(TrialSession s, int wave) {
		int vind = wave == 0 ? 4 : wave == 1 ? 3 : 2;
		int husk = wave == 0 ? 0 : wave == 1 ? 3 : 2;
		for (int i = 0; i < vind; i++) {
			TrialKit.mob(s, EntityType.VINDICATOR, TrialKit.spawnRing(s, i, vind, 14), true, m -> {
				TrialKit.stats(m, wave == 2 ? 40 : 30, 7, 0.36, 1.05, 4);
				TrialKit.name(m, wave == 2 ? "Gorrath's Chosen" : "Fury Thrall", RED);
				TrialKit.equip(m, EquipmentSlot.MAINHAND, new ItemStack(Items.IRON_AXE));
			});
		}
		for (int i = 0; i < husk; i++) {
			TrialKit.mob(s, EntityType.HUSK, TrialKit.spawnRing(s, i, husk, 17), true, m -> {
				TrialKit.stats(m, 32, 6, 0.3, 1.15, 6);
				TrialKit.name(m, "Berserker", RED);
				TrialKit.equip(m, EquipmentSlot.MAINHAND, new ItemStack(Items.STONE_AXE));
				m.addEffect(new MobEffectInstance(MobEffects.STRENGTH, 20 * 600, 0));
			});
		}
	}

	@Override
	public Mob spawnBoss(TrialSession s, Vec3 at) {
		return TrialKit.mob(s, EntityType.RAVAGER, at, false, m -> {
			TrialKit.stats(m, 420, 12, 0.32, 1.5, 8);
			TrialKit.boss(m, bossName(), RED);
		});
	}

	@Override
	public void bossEntrance(TrialSession s, Mob boss) {
		Vec3 c = boss.position();
		Fx.far(s.level, Fx.dust(RED, 3f), c.add(0, 1.5, 0), 120, 1.5, 0);
		Fx.far(s.level, ParticleTypes.LAVA, c, 40, 1.2, 0.2);
		Fx.shockRing(s.level, ParticleTypes.CAMPFIRE_COSY_SMOKE, c.add(0, 0.2, 0), 1.5, 40, 0.3);
		Fx.sound(s.level, c, SoundEvents.RAVAGER_ROAR, 3f, 0.6f);
	}

	@Override
	public void onPhase(TrialSession s, Mob boss, int phase) {
		if (phase == 3) {
			// Bloodrage: faster and harder-hitting.
			TrialKit.attr(boss, Attributes.MOVEMENT_SPEED, 0.38);
			boss.addEffect(new MobEffectInstance(MobEffects.STRENGTH, 20 * 900, 1));
			Fx.far(s.level, Fx.dust(RED, 2.5f), boss.position().add(0, 1.5, 0), 80, 1.2, 0);
			Fx.sound(s.level, boss.position(), SoundEvents.RAVAGER_ROAR, 3f, 0.5f);
		}
	}

	@Override
	public void bossTick(TrialSession s, Mob boss) {
		if (s.fightAge % 5 == 0 && s.phase >= 3) Fx.at(s.level, Fx.dust(RED, 1.6f), boss.position().add(0, 1.5, 0), 6, 1, 0);
		if (s.ready("charge", s.phase >= 3 ? 110 : 150)) charge(s, boss, s.phase >= 3 ? 2 : 1);
		else if (s.ready("roar", 210)) roar(s, boss);
		if (s.phase >= 4 && s.ready("meteors", 70)) meteors(s, boss);
	}

	private void charge(TrialSession s, Mob boss, int times) {
		TrialKit.callout(s, "Gorrath lowers his horns!", RED);
		Vec3 from = boss.position();
		Vec3 dir = TrialKit.flat(TrialKit.predict(s, 6).subtract(from));
		// Telegraph the lane.
		Scheduler.repeat(0, 2, 10, i -> {
			if (!s.active()) return false;
			for (int k = 1; k < 16; k++) Fx.at(s.level, Fx.dust(RED, 1.3f), from.add(dir.scale(k)).add(0, 0.2, 0), 1, 0.15, 0);
			return true;
		});
		Fx.sound(s.level, from, SoundEvents.RAVAGER_STEP, 2f, 0.6f);
		boolean[] hit = {false};
		Scheduler.later(20, () -> {
			if (!s.active() || !boss.isAlive()) return;
			Fx.sound(s.level, boss.position(), SoundEvents.RAVAGER_ROAR, 2f, 1.2f);
			Scheduler.repeat(0, 1, 14, i -> {
				if (!s.active() || !boss.isAlive()) return false;
				boss.getNavigation().stop();
				net.chaoshearts.ability.Ctx.setVelocity(boss, dir.scale(1.15).add(0, boss.getDeltaMovement().y, 0));
				Fx.at(s.level, ParticleTypes.CAMPFIRE_COSY_SMOKE, boss.position().add(0, 0.3, 0), 3, 0.4, 0.02);
				if (!hit[0] && TrialKit.blast(s, boss, boss.position().add(0, 1, 0), 2.6, 11, 1.6, 0.6)) {
					hit[0] = true;
					Fx.sound(s.level, boss.position(), SoundEvents.RAVAGER_ATTACK, 2f, 0.8f);
				}
				if (i == 13 && times > 1) Scheduler.later(10, () -> {
					if (s.active() && boss.isAlive()) charge(s, boss, times - 1);
				});
				return true;
			});
		});
	}

	private void roar(TrialSession s, Mob boss) {
		TrialKit.callout(s, "Gorrath draws breath... get clear!", RED);
		Vec3 c = boss.position();
		TrialKit.telegraph(s, c, 7, 30, RED, () -> {
			Vec3 now = boss.position();
			Fx.sound(s.level, now, SoundEvents.RAVAGER_ROAR, 3f, 0.7f);
			Fx.custom(s.level, now, "rage_slam", 1.5f, 0.8f);
			for (int k = 1; k <= 3; k++) Fx.shockRing(s.level, Fx.dust(RED, 2f), now.add(0, 0.3, 0), k * 2, 30, 0.4);
			Fx.far(s.level, ParticleTypes.EXPLOSION, now.add(0, 0.5, 0), 6, 2, 0);
			TrialKit.blast(s, boss, now, 7.5, 9, 1.4, 0.55);
		});
	}

	private void meteors(TrialSession s, Mob boss) {
		for (int i = 0; i < 3; i++) {
			Vec3 at = i == 0 ? TrialKit.predict(s, 10) : TrialKit.playerPos(s).add((s.level.random.nextDouble() - 0.5) * 9, 0, (s.level.random.nextDouble() - 0.5) * 9);
			Vec3 ground = new Vec3(at.x, Arena.FLOOR_Y + 1, at.z);
			TrialKit.telegraph(s, ground, 2.5, 30, 0xFF5A1A, () -> TrialKit.drop(s, ground, Blocks.MAGMA_BLOCK.defaultBlockState(), 1.2f, 8, () -> {
				Fx.far(s.level, ParticleTypes.LAVA, ground, 20, 0.8, 0.2);
				Fx.far(s.level, ParticleTypes.EXPLOSION, ground, 2, 0.4, 0);
				Fx.sound(s.level, ground, SoundEvents.GENERIC_EXPLODE.value(), 1f, 1.2f);
				if (TrialKit.blast(s, boss, ground, 2.8, 8, 0.8, 0.5)) {
					var p = s.player();
					if (p != null) p.igniteForSeconds(3);
				}
			}));
		}
	}

	@Override
	public void ambient(TrialSession s) {
		Vec3 p = TrialKit.playerPos(s);
		Fx.at(s.level, ParticleTypes.ASH, p.add(0, 3, 0), 30, 8, 0);
		Fx.at(s.level, ParticleTypes.CRIMSON_SPORE, p.add(0, 2, 0), 12, 6, 0);
	}
}
