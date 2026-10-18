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
import net.minecraft.world.effect.MobEffects;
import net.minecraft.world.entity.EntityType;
import net.minecraft.world.entity.Mob;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.Items;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.world.phys.Vec3;

/** Astrael rains stars, sweeps a radiant beam, shields itself in light and finally goes supernova. */
public final class CelestialTrial extends Trial {
	private static final int STAR = 0xFFF2B0;
	private static final int SUN = 0xFFC94A;

	public CelestialTrial() {
		super(HeartType.CELESTIAL);
	}

	@Override
	public String title() {
		return "The Fallen Firmament";
	}

	@Override
	public String tagline() {
		return "Even a dying star burns brighter than you.";
	}

	@Override
	public String bossName() {
		return "Astrael, the Fallen Star";
	}

	@Override
	public BossEvent.BossBarColor barColor() {
		return BossEvent.BossBarColor.YELLOW;
	}

	@Override
	public int pillars() {
		return 8;
	}

	@Override
	public Palette palette() {
		return new Palette(
				Palette.of(Blocks.CALCITE, 3, Blocks.SMOOTH_QUARTZ, 2, Blocks.WHITE_CONCRETE, 1, Blocks.GOLD_BLOCK, 1),
				Palette.of(Blocks.CALCITE, 1),
				Blocks.QUARTZ_BRICKS.defaultBlockState(),
				Blocks.SMOOTH_QUARTZ.defaultBlockState(),
				Blocks.CALCITE.defaultBlockState(),
				Blocks.GOLD_BLOCK.defaultBlockState(),
				Blocks.BEACON.defaultBlockState());
	}

	@Override
	public void decorate(Arena a) {
		int r = a.radius;
		// Constellation rings in gold.
		for (int i = 0; i < 120; i++) {
			double ang = Math.PI * 2 * i / 120;
			if (i % 3 != 0) a.set((int) Math.round(Math.cos(ang) * 16), 0, (int) Math.round(Math.sin(ang) * 16), Blocks.GOLD_BLOCK.defaultBlockState());
		}
		// Stars hanging in the dark: glowstone cores with end-rod rays.
		for (int i = 0; i < 18; i++) {
			double ang = a.random.nextDouble() * Math.PI * 2;
			int d = r + 6 + a.random.nextInt(22);
			int x = (int) (Math.cos(ang) * d), z = (int) (Math.sin(ang) * d), y = 6 + a.random.nextInt(24);
			a.set(x, y, z, Blocks.GLOWSTONE.defaultBlockState());
			if (a.random.nextBoolean()) {
				a.set(x + 1, y, z, Blocks.END_ROD.defaultBlockState());
				a.set(x - 1, y, z, Blocks.END_ROD.defaultBlockState());
				a.set(x, y + 1, z, Blocks.END_ROD.defaultBlockState());
				a.set(x, y - 1, z, Blocks.END_ROD.defaultBlockState());
			}
		}
		// Amethyst growing on the wall.
		for (int i = 0; i < 24; i++) {
			double ang = Math.PI * 2 * i / 24 + 0.1;
			int x = (int) Math.round(Math.cos(ang) * r), z = (int) Math.round(Math.sin(ang) * r);
			if (!a.planned(x, 2, z)) a.set(x, 2, z, Blocks.AMETHYST_CLUSTER.defaultBlockState());
		}
		Palette.Weighted top = Palette.of(Blocks.CALCITE, 2, Blocks.AMETHYST_BLOCK, 1);
		for (int i = 0; i < 5; i++) {
			double ang = a.random.nextDouble() * Math.PI * 2;
			int d = r + 12 + a.random.nextInt(12);
			a.island((int) (Math.cos(ang) * d), -8 + a.random.nextInt(12), (int) (Math.sin(ang) * d), 2, top, Blocks.CALCITE.defaultBlockState(), Blocks.GLOWSTONE.defaultBlockState());
		}
	}

	@Override
	public void spawnWave(TrialSession s, int wave) {
		int starlings = wave == 0 ? 5 : 4;
		int comets = wave == 1 ? 2 : 0;
		for (int i = 0; i < starlings; i++) {
			TrialKit.mob(s, EntityType.VEX, TrialKit.spawnRing(s, i, starlings, 14).add(0, 2, 0), true, m -> {
				TrialKit.stats(m, 16, 4, 0, 1.2, 0);
				TrialKit.name(m, "Starling", STAR);
				m.setItemSlot(net.minecraft.world.entity.EquipmentSlot.MAINHAND, new ItemStack(Items.GOLDEN_SWORD));
			});
		}
		for (int i = 0; i < comets; i++) {
			TrialKit.mob(s, EntityType.PHANTOM, TrialKit.spawnRing(s, i, comets, 12).add(0, 8, 0), true, m -> {
				TrialKit.stats(m, 22, 5, 0, 1.3, 0);
				TrialKit.name(m, "Comet", SUN);
				m.setGlowingTag(true);
			});
		}
	}

	@Override
	public Mob spawnBoss(TrialSession s, Vec3 at) {
		return TrialKit.mob(s, EntityType.VEX, at.add(0, 1, 0), false, m -> {
			TrialKit.stats(m, 360, 9, 0, 3.2, 8);
			TrialKit.boss(m, bossName(), STAR);
			m.setItemSlot(net.minecraft.world.entity.EquipmentSlot.MAINHAND, new ItemStack(Items.GOLDEN_SWORD));
		});
	}

	@Override
	public void bossEntrance(TrialSession s, Mob boss) {
		Vec3 c = boss.position().add(0, 1.5, 0);
		Fx.flash(s.level, c);
		Fx.far(s.level, ParticleTypes.END_ROD, c, 150, 0.4, 0.4);
		Fx.sphere(s.level, Fx.dust(STAR, 2f), c, 3, 120);
		Fx.sound(s.level, c, SoundEvents.BEACON_ACTIVATE, 3f, 0.6f);
		Fx.custom(s.level, c, "celestial_chime", 2f, 0.7f);
	}

	@Override
	public float bossIncoming(TrialSession s, Mob boss, float amount) {
		if (s.var("shield") > 0) {
			long hits = s.var("shield") - 1;
			Fx.sound(s.level, boss.position(), SoundEvents.AMETHYST_BLOCK_HIT, 1.5f, 1.4f);
			Fx.sphere(s.level, Fx.dust(SUN, 1f), boss.position().add(0, 1.5, 0), 2.4, 30);
			if (hits <= 0) {
				s.var("shield", 0);
				Fx.flash(s.level, boss.position().add(0, 1.5, 0));
				Fx.sound(s.level, boss.position(), SoundEvents.GLASS_BREAK, 2f, 1.2f);
				TrialKit.callout(s, "The sanctuary shatters!", STAR);
			} else {
				s.var("shield", hits);
				TrialKit.callout(s, "Sanctuary: " + hits + " hits to break it", STAR);
			}
			return amount * 0.15f;
		}
		return amount;
	}

	@Override
	public void bossTick(TrialSession s, Mob boss) {
		if (s.fightAge % 3 == 0) Fx.at(s.level, ParticleTypes.END_ROD, boss.position().add(0, 1.5, 0), 2, 0.6, 0.02);
		if (s.var("shield") > 0) {
			if (s.fightAge % 3 == 0) Fx.sphere(s.level, Fx.dust(SUN, 1.2f), boss.position().add(0, 1.5, 0), 2.4, 24);
			if (s.fightAge % 20 == 0) boss.heal(4);
		}
		if (s.var("nova") > 0) {
			supernovaTick(s, boss);
			return;
		}
		if (s.ready("starfall", 120)) starfall(s, boss);
		else if (s.ready("beam", 180)) beam(s, boss);
		if (s.phase >= 3 && s.ready("sanctuary", 360)) {
			s.var("shield", 7);
			TrialKit.callout(s, "Astrael raises a sanctuary! Strike it 7 times!", STAR);
			Fx.sound(s.level, boss.position(), SoundEvents.BEACON_POWER_SELECT, 2f, 1.4f);
		}
		if (s.phase >= 4 && s.ready("supernova", 320)) {
			s.var("nova", 1);
			TrialKit.callout(s, "SUPERNOVA! Hide behind a pillar!", SUN);
			Fx.sound(s.level, boss.position(), SoundEvents.BEACON_ACTIVATE, 3f, 0.5f);
		}
	}

	private void starfall(TrialSession s, Mob boss) {
		int n = s.phase >= 3 ? 8 : 6;
		for (int i = 0; i < n; i++) {
			Vec3 at = i == 0 ? TrialKit.predict(s, 15) : TrialKit.playerPos(s).add((s.level.random.nextDouble() - 0.5) * 12, 0, (s.level.random.nextDouble() - 0.5) * 12);
			Vec3 g = new Vec3(at.x, Arena.FLOOR_Y + 1, at.z);
			if (!s.arena.inside(g, -1)) continue;
			Scheduler.later(i * 3, () -> TrialKit.telegraph(s, g, 2, 28, STAR, () -> {
				var star = TrialKit.itemDisplay(s, g.add(0, 16, 0), new ItemStack(Items.NETHER_STAR), 1.2f);
				if (star != null) net.chaoshearts.fx.Displays.teleportDuration(star, 2);
				Scheduler.repeat(0, 1, 7, k -> {
					if (star == null) return false;
					net.chaoshearts.fx.Displays.move(star, g.add(0, 16 - 16 * (k + 1) / 7.0, 0));
					Fx.at(s.level, ParticleTypes.END_ROD, star.position(), 2, 0.1, 0.02);
					if (k == 6) {
						star.discard();
						Fx.flash(s.level, g.add(0, 0.5, 0));
						Fx.shockRing(s.level, Fx.dust(STAR, 1.5f), g.add(0, 0.3, 0), 0.5, 24, 0.3);
						Fx.sound(s.level, g, SoundEvents.FIREWORK_ROCKET_TWINKLE, 1.5f, 1.2f);
						TrialKit.blast(s, boss, g, 2.3, 7, 0.5, 0.4);
					}
					return true;
				});
			}));
		}
	}

	private void beam(TrialSession s, Mob boss) {
		TrialKit.callout(s, "Astrael focuses a radiant beam!", SUN);
		Vec3 from = boss.position().add(0, boss.getBbHeight() * 0.6, 0);
		Vec3 dir = TrialKit.playerPos(s).add(0, 1, 0).subtract(from).normalize();
		Fx.sound(s.level, from, SoundEvents.BEACON_POWER_SELECT, 2f, 1.8f);
		Scheduler.repeat(0, 2, 13, i -> {
			if (!s.active()) return false;
			Fx.line(s.level, Fx.dust(SUN, 0.7f), from, from.add(dir.scale(30)), 1.0);
			return true;
		});
		boolean[] hit = {false};
		Scheduler.repeat(26, 1, 10, i -> {
			if (!s.active() || !s.fighting()) return false;
			Vec3 to = from.add(dir.scale(30));
			var res = s.level.clip(new net.minecraft.world.level.ClipContext(from, to, net.minecraft.world.level.ClipContext.Block.COLLIDER, net.minecraft.world.level.ClipContext.Fluid.NONE, boss));
			Vec3 end = res.getLocation();
			Fx.line(s.level, Fx.dust(0xFFFFFF, 1.6f), from, end, 0.35);
			Fx.line(s.level, ParticleTypes.END_ROD, from, end, 1.2);
			if (i % 3 == 0) Fx.sound(s.level, from, SoundEvents.BEACON_AMBIENT, 2f, 2f);
			var p = s.player();
			if (!hit[0] && p != null && TrialKit.segmentDistance(p.position().add(0, 1, 0), from, end) < 1.3) {
				hit[0] = true;
				TrialKit.hit(s, boss, 9);
				p.igniteForSeconds(2);
			}
			return true;
		});
	}

	private void supernovaTick(TrialSession s, Mob boss) {
		long t = s.var("nova");
		s.var("nova", t + 1);
		Vec3 c = s.arena.centerTop().add(0, 6, 0);
		boss.getNavigation().stop();
		boss.teleportTo(c.x, c.y, c.z);
		boss.setDeltaMovement(Vec3.ZERO);
		if (t % 3 == 0) Fx.implode(s.level, Fx.dust(SUN, STAR, 2f), c, 8 - t / 12.0, 30, 0.4);
		if (t % 10 == 0) Fx.sound(s.level, c, SoundEvents.NOTE_BLOCK_CHIME.value(), 2f, 0.5f + t / 70f);
		if (t >= 70) {
			s.var("nova", 0);
			Fx.flash(s.level, c);
			Fx.far(s.level, ParticleTypes.END_ROD, c, 300, 0.5, 0.9);
			Fx.sound(s.level, c, SoundEvents.GENERIC_EXPLODE.value(), 3f, 0.5f);
			Fx.custom(s.level, c, "celestial_nova", 3f, 1f);
			var p = s.player();
			if (p != null && TrialKit.clearLine(s.level, c, p.getEyePosition(), boss)) {
				TrialKit.hit(s, boss, 18);
				TrialKit.effect(s, MobEffects.BLINDNESS, 60, 0);
			}
		}
	}

	@Override
	public void ambient(TrialSession s) {
		Vec3 p = TrialKit.playerPos(s);
		Fx.at(s.level, ParticleTypes.END_ROD, p.add(0, 5, 0), 6, 9, 0.01);
		Fx.at(s.level, Fx.dust(STAR, 0.7f), p.add(0, 3, 0), 15, 9, 0);
	}
}
