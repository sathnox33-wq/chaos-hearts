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
import net.minecraft.world.effect.MobEffectInstance;
import net.minecraft.world.effect.MobEffects;
import net.minecraft.world.entity.EntityType;
import net.minecraft.world.entity.EquipmentSlot;
import net.minecraft.world.entity.Mob;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.Items;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.world.level.block.state.properties.BlockStateProperties;
import net.minecraft.world.phys.Vec3;

/** Voltaris calls lightning on you, chains it through you and finally spins up a tempest. */
public final class StormTrial extends Trial {
	private static final int BLUE = 0x4FA8FF;
	private static final int WHITE = 0xE8F6FF;

	public StormTrial() {
		super(HeartType.STORM);
	}

	@Override
	public String title() {
		return "The Eye of the Storm";
	}

	@Override
	public String tagline() {
		return "Stand tall and the sky will find you.";
	}

	@Override
	public String bossName() {
		return "Voltaris, Crown of the Tempest";
	}

	@Override
	public BossEvent.BossBarColor barColor() {
		return BossEvent.BossBarColor.BLUE;
	}

	@Override
	public Palette palette() {
		return new Palette(
				Palette.of(Blocks.DEEPSLATE_TILES, 3, Blocks.POLISHED_DEEPSLATE, 2, Blocks.WAXED_OXIDIZED_CUT_COPPER, 1, Blocks.COBBLED_DEEPSLATE, 1),
				Palette.of(Blocks.COBBLED_DEEPSLATE, 1),
				Blocks.POLISHED_DEEPSLATE.defaultBlockState(),
				Blocks.DEEPSLATE_BRICKS.defaultBlockState(),
				Blocks.DEEPSLATE_TILES.defaultBlockState(),
				Blocks.WAXED_OXIDIZED_COPPER.defaultBlockState(),
				Blocks.WAXED_COPPER_BULB.defaultBlockState().setValue(BlockStateProperties.LIT, true));
	}

	@Override
	public void decorate(Arena a) {
		int r = a.radius;
		// Lightning rods on the wall.
		for (int i = 0; i < 16; i++) {
			double ang = Math.PI * 2 * i / 16;
			int x = (int) Math.round(Math.cos(ang) * r), z = (int) Math.round(Math.sin(ang) * r);
			a.set(x, 2, z, Blocks.DEEPSLATE_BRICKS.defaultBlockState());
			a.set(x, 3, z, Blocks.LIGHTNING_ROD.defaultBlockState());
		}
		// Storm clouds drifting around the arena.
		Palette.Weighted cloud = Palette.of(Blocks.WHITE_WOOL, 2, Blocks.LIGHT_GRAY_WOOL, 2, Blocks.GRAY_WOOL, 1);
		for (int i = 0; i < 10; i++) {
			double ang = a.random.nextDouble() * Math.PI * 2;
			int d = r + 8 + a.random.nextInt(16);
			int x = (int) (Math.cos(ang) * d), z = (int) (Math.sin(ang) * d);
			int y = 10 + a.random.nextInt(14);
			int w = 3 + a.random.nextInt(4);
			for (int ox = -w; ox <= w; ox++) for (int oz = -w / 2; oz <= w / 2; oz++) for (int oy = 0; oy <= 1; oy++) {
				if (a.random.nextFloat() < 0.75f) a.set(x + ox, y + oy, z + oz, cloud.pick(a.random));
			}
		}
		Palette.Weighted top = Palette.of(Blocks.DEEPSLATE_TILES, 2, Blocks.WAXED_OXIDIZED_COPPER, 1);
		for (int i = 0; i < 5; i++) {
			double ang = a.random.nextDouble() * Math.PI * 2;
			int d = r + 12 + a.random.nextInt(10);
			a.island((int) (Math.cos(ang) * d), -10 + a.random.nextInt(10), (int) (Math.sin(ang) * d), 2, top, Blocks.COBBLED_DEEPSLATE.defaultBlockState(), Blocks.SEA_LANTERN.defaultBlockState());
		}
	}

	@Override
	public void spawnWave(TrialSession s, int wave) {
		int wings = wave == 0 ? 3 : wave == 1 ? 4 : 3;
		int callers = wave == 2 ? 0 : 2;
		for (int i = 0; i < wings; i++) {
			TrialKit.mob(s, EntityType.PHANTOM, TrialKit.spawnRing(s, i, wings, 14).add(0, 8, 0), true, m -> {
				TrialKit.stats(m, 20, 5, 0, 1.2, 0);
				TrialKit.name(m, "Stormwing", BLUE);
			});
		}
		for (int i = 0; i < callers; i++) {
			TrialKit.mob(s, EntityType.SKELETON, TrialKit.spawnRing(s, i, callers, 17), true, m -> {
				TrialKit.stats(m, 26, 4, 0.27, 1.0, 2);
				TrialKit.name(m, "Stormcaller", BLUE);
				TrialKit.equip(m, EquipmentSlot.MAINHAND, new ItemStack(Items.BOW));
				TrialKit.equip(m, EquipmentSlot.HEAD, new ItemStack(Items.CHAINMAIL_HELMET));
			});
		}
	}

	@Override
	public Mob spawnBoss(TrialSession s, Vec3 at) {
		return TrialKit.mob(s, EntityType.SKELETON, at, false, m -> {
			TrialKit.stats(m, 360, 9, 0.28, 2.0, 8);
			TrialKit.boss(m, bossName(), BLUE);
			TrialKit.equip(m, EquipmentSlot.MAINHAND, new ItemStack(Items.TRIDENT));
			TrialKit.equip(m, EquipmentSlot.HEAD, new ItemStack(Items.GOLDEN_HELMET));
		});
	}

	@Override
	public void bossEntrance(TrialSession s, Mob boss) {
		Vec3 c = boss.position();
		TrialKit.lightning(s, c);
		Scheduler.later(4, () -> TrialKit.lightning(s, c.add(1.5, 0, 1)));
		Scheduler.later(8, () -> TrialKit.lightning(s, c.add(-1.5, 0, -1)));
		Fx.far(s.level, ParticleTypes.ELECTRIC_SPARK, c.add(0, 1.5, 0), 120, 1.2, 0.3);
		Fx.custom(s.level, c, "storm_thunder", 2f, 0.7f);
	}

	@Override
	public void bossTick(TrialSession s, Mob boss) {
		if (s.fightAge % 3 == 0) Fx.at(s.level, ParticleTypes.ELECTRIC_SPARK, boss.position().add(0, 2, 0), 4, 0.8, 0.05);
		if (s.ready("call", s.phase >= 3 ? 80 : 110)) callLightning(s, boss);
		else if (s.ready("chain", 150)) chain(s, boss);
		if (s.phase >= 3 && s.ready("static", 240)) staticField(s);
		if (s.phase >= 4) tempest(s, boss);
	}

	private void strike(TrialSession s, Mob boss, Vec3 ground, float dmg) {
		TrialKit.lightning(s, ground);
		Fx.far(s.level, ParticleTypes.ELECTRIC_SPARK, ground.add(0, 0.5, 0), 40, 0.6, 0.3);
		if (TrialKit.blast(s, boss, ground, 2.3, dmg, 0.5, 0.4)) {
			var p = s.player();
			if (p != null) p.addEffect(new MobEffectInstance(MobEffects.SLOWNESS, 30, 1));
		}
	}

	private void callLightning(TrialSession s, Mob boss) {
		TrialKit.callout(s, "The sky charges above you!", BLUE);
		for (int i = 0; i < 3; i++) {
			Vec3 at = i == 0 ? TrialKit.playerPos(s) : i == 1 ? TrialKit.predict(s, 14) : TrialKit.predict(s, 24);
			Vec3 g = new Vec3(at.x, Arena.FLOOR_Y + 1, at.z);
			if (!s.arena.inside(g, -1)) continue;
			Scheduler.later(i * 6, () -> TrialKit.telegraph(s, g, 2, 25, BLUE, () -> strike(s, boss, g, 9)));
		}
	}

	private void chain(TrialSession s, Mob boss) {
		TrialKit.callout(s, "Voltaris gathers a bolt... break line of sight!", WHITE);
		Fx.sound(s.level, boss.position(), SoundEvents.BEACON_POWER_SELECT, 1.5f, 2f);
		Scheduler.repeat(0, 2, 8, i -> {
			if (!s.active()) return false;
			Fx.sphere(s.level, Fx.dust(WHITE, 1f), boss.position().add(0, 2.5, 0), 0.6 + i * 0.1, 20);
			return true;
		});
		Scheduler.later(18, () -> {
			var p = s.player();
			if (!s.active() || !s.fighting() || p == null || !boss.isAlive()) return;
			Vec3 from = boss.position().add(0, boss.getBbHeight() * 0.8, 0);
			Vec3 to = p.position().add(0, 1, 0);
			if (!TrialKit.clearLine(s.level, from, to, boss)) {
				Fx.bolt(s.level, Fx.dust(WHITE, 1.2f), from, from.lerp(to, 0.6), 0.6);
				return;
			}
			Fx.bolt(s.level, Fx.dust(WHITE, 1.4f), from, to, 0.8);
			Fx.bolt(s.level, Fx.dust(BLUE, 1f), from, to, 1.0);
			Fx.sound(s.level, to, SoundEvents.LIGHTNING_BOLT_IMPACT, 2f, 1.3f);
			TrialKit.hit(s, boss, 8);
			p.addEffect(new MobEffectInstance(MobEffects.SLOWNESS, 40, 2));
		});
	}

	private void staticField(TrialSession s) {
		TrialKit.callout(s, "The copper hums with static!", BLUE);
		for (int i = 0; i < 4; i++) {
			Vec3 c = s.arena.floorPoint(3, s.arena.radius - 3);
			TrialSession.Zone z = TrialKit.zone(s, c, 3.5, 200, 4, BLUE);
			z.onTouch = p -> Fx.at(s.level, ParticleTypes.ELECTRIC_SPARK, p.position().add(0, 1, 0), 10, 0.3, 0.2);
		}
	}

	private void tempest(TrialSession s, Mob boss) {
		Vec3 c = s.arena.centerTop();
		var p = s.player();
		if (p != null) {
			// The wind circles the arena and drags the player with it.
			Vec3 off = p.position().subtract(c);
			Vec3 tangent = new Vec3(-off.z, 0, off.x).normalize().scale(0.035);
			Ctx.push(p, tangent);
		}
		if (s.fightAge % 3 == 0) {
			double ang = s.fightAge * 0.15;
			for (int k = 0; k < 4; k++) {
				double a = ang + k * Math.PI / 2;
				Fx.at(s.level, ParticleTypes.CLOUD, c.add(Math.cos(a) * 10, 1 + k, Math.sin(a) * 10), 3, 0.5, 0.02);
			}
		}
		if (s.ready("bolts", 22)) {
			Vec3 g = s.arena.floorPoint(0, s.arena.radius - 2);
			TrialKit.telegraph(s, g, 2, 20, WHITE, () -> strike(s, boss, g, 7));
		}
	}

	@Override
	public void ambient(TrialSession s) {
		Vec3 p = TrialKit.playerPos(s);
		Fx.at(s.level, ParticleTypes.FALLING_WATER, p.add(0, 6, 0), 40, 9, 0);
		if (s.level.random.nextInt(6) == 0) {
			Vec3 far = s.arena.centerTop().add((s.level.random.nextDouble() - 0.5) * 80, -10, (s.level.random.nextDouble() - 0.5) * 80);
			if (!s.arena.inside(far, 6)) TrialKit.lightning(s, far);
		}
	}
}
