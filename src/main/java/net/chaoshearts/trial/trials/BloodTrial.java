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
import net.minecraft.world.entity.EntityType;
import net.minecraft.world.entity.EquipmentSlot;
import net.minecraft.world.entity.Mob;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.Items;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.world.level.block.CandleBlock;
import net.minecraft.world.phys.Vec3;

/** Vesperine drinks from you through a tether, raises blood spikes and heals in her crimson rain. */
public final class BloodTrial extends Trial {
	private static final int BLOOD = 0x9E0B1F;
	private static final int DARK = 0x2B0006;

	public BloodTrial() {
		super(HeartType.BLOOD);
	}

	@Override
	public String title() {
		return "The Crimson Communion";
	}

	@Override
	public String tagline() {
		return "Everything you bleed, it drinks.";
	}

	@Override
	public String bossName() {
		return "Vesperine, the Crimson Matriarch";
	}

	@Override
	public BossEvent.BossBarColor barColor() {
		return BossEvent.BossBarColor.RED;
	}

	@Override
	public Palette palette() {
		return new Palette(
				Palette.of(Blocks.RED_NETHER_BRICKS, 3, Blocks.NETHER_WART_BLOCK, 2, Blocks.RED_TERRACOTTA, 2, Blocks.STRIPPED_CRIMSON_HYPHAE, 1),
				Palette.of(Blocks.NETHERRACK, 2, Blocks.RED_TERRACOTTA, 1),
				Blocks.POLISHED_BLACKSTONE_BRICKS.defaultBlockState(),
				Blocks.RED_NETHER_BRICKS.defaultBlockState(),
				Blocks.STRIPPED_CRIMSON_HYPHAE.defaultBlockState(),
				Blocks.REDSTONE_BLOCK.defaultBlockState(),
				Blocks.SHROOMLIGHT.defaultBlockState());
	}

	@Override
	public void decorate(Arena a) {
		int r = a.radius;
		// Pools of blood.
		for (int i = 0; i < 6; i++) {
			double ang = Math.PI * 2 * i / 6 + 0.4;
			int cx = (int) Math.round(Math.cos(ang) * 11), cz = (int) Math.round(Math.sin(ang) * 11);
			int pr = 2 + a.random.nextInt(2);
			for (int dx = -pr; dx <= pr; dx++) for (int dz = -pr; dz <= pr; dz++) {
				if (dx * dx + dz * dz <= pr * pr) a.set(cx + dx, 0, cz + dz, Blocks.RED_CONCRETE.defaultBlockState());
			}
		}
		// Lit candles along the wall.
		for (int i = 0; i < 30; i++) {
			double ang = Math.PI * 2 * i / 30;
			int x = (int) Math.round(Math.cos(ang) * r), z = (int) Math.round(Math.sin(ang) * r);
			if (a.planned(x, 2, z)) continue;
			a.set(x, 2, z, Blocks.RED_CANDLE.defaultBlockState().setValue(CandleBlock.LIT, true).setValue(CandleBlock.CANDLES, 1 + a.random.nextInt(4)));
		}
		// Hanging cages beyond the cage.
		for (int i = 0; i < 8; i++) {
			double ang = Math.PI * 2 * i / 8;
			int x = (int) Math.round(Math.cos(ang) * (r + 7)), z = (int) Math.round(Math.sin(ang) * (r + 7));
			for (int y = 4; y <= 14; y++) a.set(x, y, z, Blocks.IRON_BARS.defaultBlockState());
			for (int ox = -1; ox <= 1; ox++) for (int oz = -1; oz <= 1; oz++) for (int y = 0; y <= 3; y++) {
				if (ox == 0 && oz == 0 && y > 0 && y < 3) continue;
				a.set(x + ox, y, z + oz, y == 0 || y == 3 ? Blocks.NETHER_BRICKS.defaultBlockState() : Blocks.IRON_BARS.defaultBlockState());
			}
		}
		Palette.Weighted top = Palette.of(Blocks.CRIMSON_NYLIUM, 2, Blocks.NETHER_WART_BLOCK, 1);
		for (int i = 0; i < 6; i++) {
			double ang = a.random.nextDouble() * Math.PI * 2;
			int d = r + 13 + a.random.nextInt(10);
			a.island((int) (Math.cos(ang) * d), -6 + a.random.nextInt(14), (int) (Math.sin(ang) * d), 2, top, Blocks.NETHERRACK.defaultBlockState(), Blocks.SHROOMLIGHT.defaultBlockState());
		}
	}

	@Override
	public void spawnWave(TrialSession s, int wave) {
		int thralls = wave == 0 ? 5 : 3;
		int witches = wave == 1 ? 2 : 0;
		for (int i = 0; i < thralls; i++) {
			TrialKit.mob(s, EntityType.ZOMBIE, TrialKit.spawnRing(s, i, thralls, 15), true, m -> {
				m.setBaby(false);
				TrialKit.stats(m, 28, 6, 0.28, 1.05, 4);
				TrialKit.name(m, "Bloodthrall", BLOOD);
				TrialKit.equip(m, EquipmentSlot.MAINHAND, new ItemStack(Items.IRON_SWORD));
			});
		}
		for (int i = 0; i < witches; i++) {
			TrialKit.mob(s, EntityType.WITCH, TrialKit.spawnRing(s, i, witches, 18), true, m -> {
				TrialKit.stats(m, 30, 0, 0.25, 1.0, 0);
				TrialKit.name(m, "Blood Witch", BLOOD);
			});
		}
	}

	@Override
	public Mob spawnBoss(TrialSession s, Vec3 at) {
		return TrialKit.mob(s, EntityType.EVOKER, at, false, m -> {
			TrialKit.stats(m, 360, 8, 0.4, 1.8, 6);
			TrialKit.boss(m, bossName(), BLOOD);
		});
	}

	@Override
	public void bossEntrance(TrialSession s, Mob boss) {
		Vec3 c = boss.position();
		Fx.far(s.level, Fx.dust(BLOOD, 3f), c.add(0, 1.5, 0), 150, 1.3, 0);
		Fx.far(s.level, ParticleTypes.DRIPPING_LAVA, c.add(0, 3, 0), 40, 1.5, 0);
		Fx.pillar(s.level, Fx.dust(BLOOD, DARK, 2f), c, 8, 60, 0.4);
		Fx.sound(s.level, c, SoundEvents.EVOKER_PREPARE_SUMMON, 2f, 0.6f);
		Fx.custom(s.level, c, "blood_drink", 2f, 0.6f);
	}

	@Override
	public void bossTick(TrialSession s, Mob boss) {
		if (s.fightAge % 4 == 0) Fx.at(s.level, Fx.dust(BLOOD, 1.2f), boss.position().add(0, 1.2, 0), 4, 0.6, 0);
		tether(s, boss);
		if (s.var("tetherUntil") <= s.fightAge && s.ready("tether", s.phase >= 4 ? 130 : 200)) {
			s.var("tetherUntil", s.fightAge + 60);
			TrialKit.callout(s, "Vesperine latches on! Break line of sight or get away!", BLOOD);
			Fx.sound(s.level, boss.position(), SoundEvents.EVOKER_CAST_SPELL, 2f, 0.6f);
		}
		if (s.ready("spikes", 120)) spikes(s, boss);
		if (s.phase >= 3 && s.ready("rain", 260)) rain(s, boss);
	}

	private void tether(TrialSession s, Mob boss) {
		if (s.var("tetherUntil") <= s.fightAge) return;
		var p = s.player();
		if (p == null) return;
		Vec3 from = boss.position().add(0, boss.getBbHeight() * 0.7, 0);
		Vec3 to = p.position().add(0, 1, 0);
		boolean held = from.distanceTo(to) < 15 && TrialKit.clearLine(s.level, from, to, boss);
		if (!held) {
			s.var("tetherUntil", 0);
			Fx.sound(s.level, to, SoundEvents.GLASS_BREAK, 1.2f, 0.6f);
			TrialKit.callout(s, "The tether snaps.", 0xFFFFFF);
			return;
		}
		if (s.fightAge % 2 == 0) Fx.line(s.level, Fx.dust(BLOOD, 1.1f), from, to, 0.35);
		if (s.fightAge % 10 == 0) {
			float drain = s.phase >= 4 ? 3.5f : 2.5f;
			if (TrialKit.hit(s, boss, drain)) boss.heal(drain * 4);
			Fx.sound(s.level, to, SoundEvents.HONEY_DRINK.value(), 0.8f, 0.6f);
		}
	}

	private void spikes(TrialSession s, Mob boss) {
		Vec3 from = new Vec3(boss.getX(), Arena.FLOOR_Y + 1, boss.getZ());
		Vec3 aim = TrialKit.flat(TrialKit.playerPos(s).subtract(from));
		int fan = s.phase >= 3 ? 5 : 3;
		for (int f = 0; f < fan; f++) {
			double off = (f - (fan - 1) / 2.0) * 0.35;
			Vec3 dir = net.chaoshearts.ability.KitUtil.rotateY(aim, off);
			for (int i = 1; i <= 8; i++) {
				Vec3 at = from.add(dir.scale(i * 1.8));
				if (!s.arena.inside(at, -1)) break;
				int k = i;
				Scheduler.later(i * 2, () -> TrialKit.telegraph(s, at, 1.1, 14, BLOOD, () -> {
					var d = TrialKit.blockDisplay(s, at.add(0, -0.5, 0), Blocks.POINTED_DRIPSTONE.defaultBlockState(), 1.2f);
					if (d != null) {
						net.chaoshearts.fx.Displays.glow(d, BLOOD);
						Scheduler.later(15, d::discard);
					}
					Fx.at(s.level, Fx.dust(BLOOD, 1.5f), at.add(0, 0.6, 0), 10, 0.3, 0);
					if (k == 1) Fx.sound(s.level, at, SoundEvents.POINTED_DRIPSTONE_LAND, 1.5f, 0.7f);
					if (TrialKit.blast(s, boss, at, 1.3, 6, 0.2, 0.6)) TrialKit.bleed(s, boss, 1f, 4, 10);
				}));
			}
		}
	}

	private void rain(TrialSession s, Mob boss) {
		TrialKit.callout(s, "Crimson rain! It heals her while you stand in it!", BLOOD);
		for (int i = 0; i < 3; i++) {
			Vec3 c = i == 0 ? TrialKit.predict(s, 10) : s.arena.floorPoint(3, s.arena.radius - 4);
			Vec3 g = new Vec3(c.x, Arena.FLOOR_Y + 1, c.z);
			TrialSession.Zone z = TrialKit.zone(s, g, 4, 220, 3, BLOOD);
			z.onTouch = p -> {
				if (boss.isAlive()) boss.heal(2);
				Fx.at(s.level, ParticleTypes.DRIPPING_LAVA, p.position().add(0, 2.5, 0), 6, 0.4, 0);
			};
		}
	}

	@Override
	public void ambient(TrialSession s) {
		Vec3 p = TrialKit.playerPos(s);
		Fx.at(s.level, ParticleTypes.CRIMSON_SPORE, p.add(0, 2, 0), 20, 8, 0);
		Fx.at(s.level, Fx.dust(BLOOD, 0.8f), p.add(0, 4, 0), 8, 8, 0);
	}
}
