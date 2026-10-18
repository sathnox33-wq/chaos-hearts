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
import net.minecraft.world.entity.Mob;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.Items;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.world.phys.Vec3;

/** Nyxara spits plague, snares you in webs, breeds a brood and lets the rot swallow the garden. */
public final class CorruptionTrial extends Trial {
	private static final int ROT = 0x7BD13A;
	private static final int BRUISE = 0x3D1A52;

	public CorruptionTrial() {
		super(HeartType.CORRUPTION);
	}

	@Override
	public String title() {
		return "The Rotting Garden";
	}

	@Override
	public String tagline() {
		return "It does not want to kill you. It wants to keep you.";
	}

	@Override
	public String bossName() {
		return "Nyxara, the Blightmother";
	}

	@Override
	public BossEvent.BossBarColor barColor() {
		return BossEvent.BossBarColor.GREEN;
	}

	@Override
	public Palette palette() {
		return new Palette(
				Palette.of(Blocks.MOSS_BLOCK, 2, Blocks.MYCELIUM, 2, Blocks.PODZOL, 1, Blocks.SCULK, 2, Blocks.ROOTED_DIRT, 1),
				Palette.of(Blocks.MUD, 2, Blocks.ROOTED_DIRT, 1),
				Blocks.MOSSY_COBBLESTONE.defaultBlockState(),
				Blocks.MUD_BRICKS.defaultBlockState(),
				Blocks.MUSHROOM_STEM.defaultBlockState(),
				Blocks.SCULK.defaultBlockState(),
				Blocks.VERDANT_FROGLIGHT.defaultBlockState());
	}

	@Override
	public void decorate(Arena a) {
		int r = a.radius;
		// Giant mushrooms beyond the wall.
		for (int i = 0; i < 9; i++) {
			double ang = Math.PI * 2 * i / 9 + a.random.nextDouble() * 0.4;
			int d = r + 5 + a.random.nextInt(10);
			int x = (int) (Math.cos(ang) * d), z = (int) (Math.sin(ang) * d);
			int h = 5 + a.random.nextInt(8);
			for (int y = -8; y <= h; y++) a.set(x, y, z, Blocks.MUSHROOM_STEM.defaultBlockState());
			var cap = a.random.nextBoolean() ? Blocks.RED_MUSHROOM_BLOCK.defaultBlockState() : Blocks.BROWN_MUSHROOM_BLOCK.defaultBlockState();
			int cr = 2 + a.random.nextInt(2);
			for (int ox = -cr; ox <= cr; ox++) for (int oz = -cr; oz <= cr; oz++) {
				if (ox * ox + oz * oz <= cr * cr + 1) a.set(x + ox, h + 1, z + oz, cap);
				if (ox * ox + oz * oz == cr * cr) a.set(x + ox, h, z + oz, cap);
			}
			a.set(x, h, z, Blocks.VERDANT_FROGLIGHT.defaultBlockState());
		}
		// Rot pustules and webs on floating clods.
		Palette.Weighted top = Palette.of(Blocks.MOSS_BLOCK, 2, Blocks.SCULK, 2, Blocks.SLIME_BLOCK, 1);
		for (int i = 0; i < 6; i++) {
			double ang = a.random.nextDouble() * Math.PI * 2;
			int d = r + 14 + a.random.nextInt(10);
			int x = (int) (Math.cos(ang) * d), z = (int) (Math.sin(ang) * d), y = -6 + a.random.nextInt(14);
			a.island(x, y, z, 2, top, Blocks.MUD.defaultBlockState(), Blocks.VERDANT_FROGLIGHT.defaultBlockState());
			a.set(x, y + 1, z, Blocks.COBWEB.defaultBlockState());
		}
		// Sculk veins of rot running to the sigil.
		for (int arm = 0; arm < 6; arm++) {
			double ang = arm * Math.PI / 3 + 0.25;
			for (int k = 7; k < r - 1; k++) {
				double wob = Math.sin(k * 0.6 + arm) * 1.2;
				a.set((int) Math.round(Math.cos(ang) * k - Math.sin(ang) * wob), 0, (int) Math.round(Math.sin(ang) * k + Math.cos(ang) * wob), Blocks.SCULK.defaultBlockState());
			}
		}
	}

	@Override
	public void spawnWave(TrialSession s, int wave) {
		int lings = wave == 0 ? 6 : 3;
		int archers = wave == 0 ? 0 : wave == 1 ? 3 : 1;
		for (int i = 0; i < lings; i++) {
			TrialKit.mob(s, EntityType.CAVE_SPIDER, TrialKit.spawnRing(s, i, lings, 14), true, m -> {
				TrialKit.stats(m, 14, 3, 0.34, 1.2, 0);
				TrialKit.name(m, "Blightling", ROT);
			});
		}
		for (int i = 0; i < archers; i++) {
			TrialKit.mob(s, EntityType.BOGGED, TrialKit.spawnRing(s, i, archers, 18), true, m -> {
				TrialKit.stats(m, 24, 4, 0.27, 1.0, 2);
				TrialKit.name(m, "Rotting Archer", ROT);
				m.setItemSlot(net.minecraft.world.entity.EquipmentSlot.MAINHAND, new ItemStack(Items.BOW));
			});
		}
	}

	@Override
	public Mob spawnBoss(TrialSession s, Vec3 at) {
		return TrialKit.mob(s, EntityType.SPIDER, at, false, m -> {
			TrialKit.stats(m, 400, 10, 0.34, 2.6, 8);
			TrialKit.boss(m, bossName(), ROT);
		});
	}

	@Override
	public void bossEntrance(TrialSession s, Mob boss) {
		Vec3 c = boss.position();
		Fx.far(s.level, Fx.dust(ROT, BRUISE, 2.5f), c.add(0, 1, 0), 160, 1.6, 0);
		Fx.far(s.level, ParticleTypes.SCULK_SOUL, c.add(0, 1, 0), 40, 1.2, 0.05);
		Fx.far(s.level, ParticleTypes.SPORE_BLOSSOM_AIR, c.add(0, 3, 0), 60, 3, 0);
		Fx.sound(s.level, c, SoundEvents.SPIDER_AMBIENT, 3f, 0.4f);
		Fx.custom(s.level, c, "corruption_spread", 2f, 0.6f);
	}

	@Override
	public void bossTick(TrialSession s, Mob boss) {
		if (s.fightAge % 4 == 0) Fx.at(s.level, Fx.dust(ROT, 1.2f), boss.position().add(0, 0.8, 0), 5, 0.9, 0);
		if (s.ready("spit", 100)) spit(s, boss);
		else if (s.ready("snare", 160)) snare(s, boss);
		if (s.phase >= 3) {
			if (s.ready("brood", 300)) brood(s);
			if (s.fightAge % 30 == 0) TrialKit.zone(s, new Vec3(boss.getX(), Arena.FLOOR_Y + 1, boss.getZ()), 1.8, 160, 2, BRUISE);
		}
		if (s.phase >= 4) infestation(s, boss);
	}

	private void spit(TrialSession s, Mob boss) {
		var p = s.player();
		if (p == null) return;
		Fx.sound(s.level, boss.position(), SoundEvents.LLAMA_SPIT, 2f, 0.5f);
		Vec3 from = boss.position().add(0, boss.getBbHeight() * 0.6, 0);
		int n = s.phase >= 3 ? 5 : 3;
		for (int i = 0; i < n; i++) {
			Vec3 target = (i == 0 ? TrialKit.predict(s, 14) : p.position().add((s.level.random.nextDouble() - 0.5) * 6, 0, (s.level.random.nextDouble() - 0.5) * 6));
			Vec3 d = target.subtract(from);
			double flight = 16;
			double g = 0.05;
			Vec3 vel = new Vec3(d.x / flight, (d.y + 0.5 * g * flight * flight) / flight, d.z / flight);
			var orb = TrialKit.itemDisplay(s, from, new ItemStack(Items.SLIME_BALL), 0.8f);
			var proj = TrialKit.shoot(s, boss, from, vel, Fx.dust(ROT, 1f), orb, 4, 0.5, at -> {
				Vec3 gnd = new Vec3(at.x, Arena.FLOOR_Y + 1, at.z);
				Fx.at(s.level, ParticleTypes.ITEM_SLIME, gnd.add(0, 0.3, 0), 15, 0.5, 0.1);
				Fx.sound(s.level, gnd, SoundEvents.SLIME_SQUISH, 1f, 0.7f);
				TrialSession.Zone z = TrialKit.zone(s, gnd, 2.5, 160, 2, ROT);
				z.onTouch = pl -> pl.addEffect(new MobEffectInstance(MobEffects.POISON, 50, 0, false, true, true));
			});
			proj.gravity = g;
		}
	}

	private void snare(TrialSession s, Mob boss) {
		Vec3 at = TrialKit.playerPos(s);
		Vec3 g = new Vec3(at.x, Arena.FLOOR_Y + 1, at.z);
		TrialKit.callout(s, "Webs gather beneath you!", 0xFFFFFF);
		TrialKit.telegraph(s, g, 2.2, 25, 0xDDDDDD, () -> {
			Fx.at(s.level, ParticleTypes.CLOUD, g.add(0, 0.5, 0), 25, 0.8, 0.02);
			Fx.sound(s.level, g, SoundEvents.WOOL_PLACE, 1.5f, 0.6f);
			if (TrialKit.blast(s, boss, g, 2.4, 5, 0, 0)) {
				var p = s.player();
				if (p != null) {
					p.addEffect(new MobEffectInstance(MobEffects.SLOWNESS, 50, 3, false, true, true));
					p.addEffect(new MobEffectInstance(MobEffects.POISON, 60, 0, false, true, true));
				}
				// Nyxara lunges at a snared victim.
				Scheduler.later(5, () -> {
					if (s.active() && boss.isAlive()) TrialKit.leap(boss, TrialKit.playerPos(s), 0.55);
				});
			}
		});
	}

	private void brood(TrialSession s) {
		TrialKit.callout(s, "The brood hatches!", ROT);
		for (int i = 0; i < 3; i++) {
			TrialKit.mob(s, EntityType.CAVE_SPIDER, TrialKit.spawnRing(s, i, 3, 10), false, m -> {
				TrialKit.stats(m, 10, 3, 0.36, 1.0, 0);
				TrialKit.name(m, "Broodling", ROT);
			});
		}
	}

	private void infestation(TrialSession s, Mob boss) {
		Vec3 c = s.arena.centerTop();
		long grown = Math.min(11, 2 + s.var("rotGrow") / 40);
		s.var("rotGrow", s.var("rotGrow") + 1);
		if (s.fightAge % 6 == 0) Fx.ring(s.level, Fx.dust(BRUISE, ROT, 1.4f), c.add(0, 0.2, 0), grown, (int) (grown * 8), s.fightAge * 0.05);
		if (s.fightAge % 6 == 0) Fx.disc(s.level, Fx.dust(BRUISE, 1f), c.add(0, 0.15, 0), grown, (int) (grown * 4));
		var p = s.player();
		if (p != null && s.fightAge % 10 == 0 && Math.hypot(p.getX() - c.x, p.getZ() - c.z) < grown) {
			TrialKit.hit(s, boss, 2.5f);
			p.addEffect(new MobEffectInstance(MobEffects.POISON, 40, 0, false, true, true));
			if (s.fightAge % 40 == 0) TrialKit.callout(s, "The rot spreads from the centre! Fight at the edge!", ROT);
		}
	}

	@Override
	public void ambient(TrialSession s) {
		Vec3 p = TrialKit.playerPos(s);
		Fx.at(s.level, ParticleTypes.SPORE_BLOSSOM_AIR, p.add(0, 4, 0), 12, 9, 0);
		Fx.at(s.level, ParticleTypes.MYCELIUM, p.add(0, 0.5, 0), 25, 8, 0);
	}
}
