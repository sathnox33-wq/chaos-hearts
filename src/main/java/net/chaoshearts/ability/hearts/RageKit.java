package net.chaoshearts.ability.hearts;

import java.util.List;

import net.chaoshearts.ability.Ctx;
import net.chaoshearts.ability.HeartKit;
import net.chaoshearts.ability.KitUtil;
import net.chaoshearts.combat.Combat;
import net.chaoshearts.fx.Fx;
import net.chaoshearts.fx.Scheduler;
import net.chaoshearts.heart.HeartType;
import net.chaoshearts.mastery.Mastery;
import net.chaoshearts.skill.SkillTree;
import net.minecraft.core.particles.ParticleTypes;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.effect.MobEffects;
import net.minecraft.world.entity.LivingEntity;
import net.minecraft.world.entity.player.Player;
import net.minecraft.world.phys.Vec3;

/**
 * Rage: Fury builds as you fight and is spent on bigger plays. Leap in, roar, chain hits,
 * then Rampage.
 */
public final class RageKit extends HeartKit {
	private static final int RED = 0xE0262B, DARK = 0x3A0000, EMBER = 0xFF6A1F;

	private final SkillTree tree;

	public RageKit() {
		super(HeartType.RAGE);
		ability(0, "Rage Leap", "Leap forward and slam down, damaging and launching enemies where you land.", 10, this::leap);
		ability(1, "War Cry", "Roar: weaken nearby enemies and gain Strength. Spends 30 Fury for a stronger roar.", 25, this::warCry);
		ability(2, "Berserk Chain", "Your next 3 melee hits deal bonus damage and send out a shockwave.", 30, this::berserk);
		ability(3, "Rampage", "Become fury itself: Speed, Strength, Resistance and lifesteal. Kills extend it.", 120, this::rampage);

		feat("leap3", "Earthshaker", "Hit 3 enemies with a single Rage Leap", 400);
		feat("fury10", "Unchained", "Reach maximum Fury 10 times", 300);
		feat("cry5", "Battle Hymn", "Weaken 5 enemies with one War Cry", 500);
		feat("clutch", "Last Stand", "Kill a player during Rampage while below 3 hearts", 800);

		SkillTree t = new SkillTree("rage");
		t.branch("Butcher", "Raw damage", 0xE0262B,
				t.node(0, "heavy_landing", "Heavy Landing", "+20% Rage Leap damage").mod("a1.damage", 0.2),
				t.node(1, "bloodied_edge", "Bloodied Edge", "+25% Berserk Chain damage").mod("a3.damage", 0.25),
				t.node(2, "cleave", "Cleave", "+40% Berserk shockwave radius").mod("a3.radius", 0.4),
				t.node(3, "executioner", "Executioner", "Melee hits deal +15% to targets below 30% health").flag("rage.execute"),
				t.node(4, "avalanche", "Avalanche", "CAPSTONE: Rage Leap can be recast for free within 3 seconds of landing").flag("rage.leap_twice"));
		t.branch("Juggernaut", "Survive anything", 0x8B5A2B,
				t.node(0, "thick_skin", "Thick Skin", "Take 8% less damage while at 50+ Fury").flag("rage.thick"),
				t.node(1, "pain_fuels", "Pain Fuels Me", "Taking damage grants twice the Fury").flag("rage.pain_fury"),
				t.node(2, "unstoppable", "Unstoppable", "+30% Rampage duration").mod("a4.duration", 0.3),
				t.node(3, "iron_will", "Iron Will", "War Cry also grants Resistance I").flag("rage.cry_resist"),
				t.node(4, "undying", "Undying Rage", "CAPSTONE: once every 2 minutes, lethal damage leaves you at 2 hearts and starts a short Rampage").flag("rage.undying"));
		t.branch("Warlord", "Lead the charge", 0xFFB020,
				t.node(0, "rallying", "Rallying Roar", "+30% War Cry radius").mod("a2.radius", 0.3),
				t.node(1, "shared_fury", "Shared Fury", "War Cry gives teammates Strength I").flag("rage.cry_allies"),
				t.node(2, "momentum", "Momentum", "Rage Leap recharges 25% faster").mod("a1.cooldown", -0.25),
				t.node(3, "fury_engine", "Fury Engine", "Rage Leap slams grant 25 Fury").flag("rage.leap_fury"),
				t.node(4, "banner", "Warlord's Banner", "CAPSTONE: War Cry plants a banner for 8s: teammates inside regenerate, enemies inside are weakened").flag("rage.banner"));
		tree = t;
	}

	@Override public String passive1Name() { return "Fury"; }
	@Override public String passive1Description() { return "Dealing and taking damage builds Fury. At 50+ Fury your melee hits deal 10% more."; }
	@Override public String passive2Name() { return "Bloodlust"; }
	@Override public String passive2Description() { return "Reaching full Fury grants Strength I for 6 seconds."; }
	@Override public String awakenedName() { return "Wrath Incarnate"; }
	@Override public String awakenedDescription() { return "Fury can reach 150. Above 100 Fury you burn with black flame and take 10% less damage."; }
	@Override public SkillTree tree() { return tree; }

	private static int furyCap(Ctx c) {
		return c.awakened ? 150 : 100;
	}

	private static void addFury(Ctx c, double amount) {
		long now = c.level.getGameTime();
		double before = c.state.var("fury");
		double after = Math.min(furyCap(c), before + amount);
		c.state.var("fury", after);
		c.state.var("furyTouched", now);
		if (after >= 100 && before < 100) {
			if (Mastery.counter(c.player, c.type, "fury_max", 1) >= 10) Mastery.feat(c.player, c.type, "fury10");
			if (c.unlocked(Mastery.LVL_PASSIVE2) && !c.state.timer("bloodlust_cd", now)) {
				c.state.startTimer("bloodlust_cd", now + 200);
				Combat.buff(c.player, MobEffects.STRENGTH, 120, 0);
				Fx.shockRing(c.level, Fx.dust(RED, 1.6f), c.pos().add(0, 0.2, 0), 0.5, 40, 0.35);
				Fx.at(c.level, ParticleTypes.ANGRY_VILLAGER, c.center(), 6, 0.5, 0);
				Fx.sound(c.level, c.pos(), SoundEvents.RAVAGER_ROAR, 0.6f, 1.6f);
				Fx.custom(c.level, c.pos(), "rage_bloodlust", 1f, 1f);
			}
		}
	}

	// ---------------------------------------------------------------- passives

	@Override
	public void tick(Ctx c, long t) {
		long now = c.level.getGameTime();
		// Fury decays after 4 seconds out of combat.
		if (t % 10 == 0 && now - (long) c.state.var("furyTouched") > 80 && c.state.var("fury") > 0) {
			c.state.var("fury", Math.max(0, c.state.var("fury") - 2.5));
		}
		// Rage Leap landing.
		if (c.state.timer("leap", now)) {
			if (!c.player.onGround()) c.state.var("leapAir", 1);
			else if (c.state.var("leapAir") > 0) {
				c.state.var("leapAir", 0);
				c.state.stopTimer("leap");
				slam(c);
			} else {
				Fx.at(c.level, Fx.dust(RED, 1.2f), c.pos(), 3, 0.2, 0);
			}
			if (c.state.var("leapAir") > 0) {
				Fx.at(c.level, Fx.dust(RED, EMBER, 1.4f), c.center(), 4, 0.25, 0);
				Fx.at(c.level, ParticleTypes.FLAME, c.pos(), 2, 0.1, 0.01);
			}
		}
		// Rampage visuals and effects.
		if (c.state.timer("rampage", now)) {
			if (t % 2 == 0) {
				double a = t * 0.45;
				Fx.helix(c.level, Fx.dust(RED, 1.3f), c.pos(), 0.7, 2.1, 1, 6, a);
				Fx.helix(c.level, Fx.dust(DARK, 1.6f), c.pos(), 0.7, 2.1, 1, 6, a + Math.PI);
				Fx.at(c.level, ParticleTypes.FLAME, c.pos().add(0, 0.2, 0), 2, 0.3, 0.02);
			}
			if (t % 20 == 0) {
				Combat.buff(c.player, MobEffects.SPEED, 30, 1);
				Combat.buff(c.player, MobEffects.STRENGTH, 30, 1);
				Combat.buff(c.player, MobEffects.RESISTANCE, 30, 0);
			}
			long left = c.state.timerLeft("rampage", now);
			if (left == 40) Fx.soundTo(c.player, SoundEvents.NOTE_BLOCK_BASEDRUM.value(), 1f, 0.6f);
		}
		if (c.state.timer("berserk", now) && t % 3 == 0) {
			Vec3 hand = c.eye().add(c.flatLook().scale(0.4)).add(KitUtil.rotateY(c.flatLook(), Math.PI / 2).scale(0.35)).subtract(0, 0.5, 0);
			Fx.at(c.level, Fx.dust(EMBER, 1.0f), hand, 2, 0.08, 0);
			Fx.at(c.level, ParticleTypes.SMALL_FLAME, hand, 1, 0.05, 0.01);
		}
		// Wrath Incarnate: black flames above 100 Fury.
		if (c.awakened && c.state.var("fury") > 100 && t % 3 == 0) {
			Fx.at(c.level, ParticleTypes.SOUL_FIRE_FLAME, c.pos().add(0, 0.1, 0), 2, 0.35, 0.02);
			Fx.at(c.level, Fx.dust(0x110000, 2.0f), c.center(), 3, 0.35, 0);
		}
	}

	@Override
	public void aura(Ctx c, long t) {
		Fx.at(c.level, Fx.dust(RED, 0.8f), c.pos().add(0, 0.1, 0), 2, 0.4, 0);
		if (c.awakened) Fx.at(c.level, ParticleTypes.LAVA, c.pos(), 1, 0.3, 0);
	}

	@Override
	public float outgoing(Ctx c, LivingEntity target, DamageSource s, float amount) {
		if (!KitUtil.melee(c, s)) return amount;
		long now = c.level.getGameTime();
		if (c.state.var("fury") >= 50) amount *= 1.10f;
		if (c.flag("rage.execute") && target.getHealth() < target.getMaxHealth() * 0.3f) amount *= 1.15f;
		if (c.state.timer("berserk", now) && c.state.var("berserkHits") > 0) amount += c.dmg("a3.damage", 3.0);
		return amount;
	}

	@Override
	public float incoming(Ctx c, DamageSource s, float amount) {
		long now = c.level.getGameTime();
		if (KitUtil.fall(s) && c.state.timer("leapsafe", now)) return 0;
		if (c.flag("rage.thick") && c.state.var("fury") >= 50) amount *= 0.92f;
		if (c.awakened && c.state.var("fury") > 100) amount *= 0.90f;
		return amount;
	}

	@Override
	public void afterHit(Ctx c, LivingEntity target, float amount, boolean ability) {
		addFury(c, ability ? 4 : 8 + amount);
		long now = c.level.getGameTime();
		if (!ability && c.state.timer("berserk", now) && c.state.var("berserkHits") > 0) {
			double hits = c.state.addVar("berserkHits", -1);
			Vec3 at = target.position().add(0, target.getBbHeight() / 2, 0);
			double r = c.num("a3.radius", 2.5);
			Fx.shockRing(c.level, Fx.dust(EMBER, 1.5f), target.position().add(0, 0.3, 0), 0.3, 24, r * 0.12);
			Fx.at(c.level, ParticleTypes.SWEEP_ATTACK, at, 3, 0.6, 0);
			Fx.at(c.level, ParticleTypes.CRIT, at, 18, 0.4, 0.5);
			Fx.sound(c.level, at, SoundEvents.PLAYER_ATTACK_CRIT, 1f, 0.7f);
			Fx.sound(c.level, at, SoundEvents.ANVIL_LAND, 0.25f, 1.8f);
			for (LivingEntity e : c.enemies(at, r)) {
				if (e == target) continue;
				c.hit(e, c.dmg("a3.damage", 3.0) * 0.5f);
				Ctx.knockFrom(e, at, 0.6, 0.25);
			}
			if (hits <= 0) c.state.stopTimer("berserk");
		}
		if (!ability && c.state.timer("rampage", now)) {
			c.player.heal(amount * 0.15f);
			Fx.at(c.level, Fx.dust(RED, 1f), c.center(), 4, 0.3, 0);
		}
	}

	@Override
	public void afterHurt(Ctx c, DamageSource s, float amount) {
		addFury(c, (c.flag("rage.pain_fury") ? 10 : 5) + amount);
	}

	@Override
	public void onKill(Ctx c, LivingEntity victim) {
		long now = c.level.getGameTime();
		if (c.state.timer("rampage", now)) {
			c.state.startTimer("rampage", now + c.state.timerLeft("rampage", now) + 60);
			Fx.at(c.level, ParticleTypes.EXPLOSION, victim.position(), 1, 0, 0);
			Fx.soundTo(c.player, SoundEvents.ENDER_DRAGON_GROWL, 0.4f, 1.8f);
			if (victim instanceof Player && c.player.getHealth() <= 6) Mastery.feat(c.player, c.type, "clutch");
		}
	}

	@Override
	public boolean preventDeath(Ctx c, DamageSource s) {
		long now = c.level.getGameTime();
		if (!c.flag("rage.undying") || c.state.timer("undying_cd", now)) return false;
		c.state.startTimer("undying_cd", now + 2400);
		c.player.setHealth(4);
		c.state.startTimer("rampage", now + 80);
		Fx.at(c.level, ParticleTypes.TOTEM_OF_UNDYING, c.center(), 60, 0.5, 0.6);
		Fx.sphere(c.level, Fx.dust(RED, 2f), c.center(), 2.0, 80);
		Fx.sound(c.level, c.pos(), SoundEvents.TOTEM_USE, 1f, 0.6f);
		Fx.sound(c.level, c.pos(), SoundEvents.RAVAGER_ROAR, 1f, 0.7f);
		Fx.custom(c.level, c.pos(), "rage_rampage", 1.2f, 1.2f);
		return true;
	}

	@Override
	public String hud(Ctx c, long t) {
		int fury = (int) c.state.var("fury");
		int cap = furyCap(c);
		if (fury <= 0 && !c.state.timer("rampage", c.level.getGameTime())) return null;
		int bars = (int) Math.round(fury / (double) cap * 10);
		String meter = "▮".repeat(bars) + "▯".repeat(10 - bars);
		String s = "Fury " + meter + " " + fury;
		long left = c.state.timerLeft("rampage", c.level.getGameTime());
		if (left > 0) s += "  RAMPAGE " + (left / 20 + 1) + "s";
		return s;
	}

	@Override
	public void deactivate(ServerPlayer p) {
		super.deactivate(p);
	}

	// ---------------------------------------------------------------- abilities

	private boolean leap(Ctx c) {
		long now = c.level.getGameTime();
		Vec3 dir = c.flatLook();
		double pitchBoost = Math.max(0, -c.look().y) * 0.4;
		Ctx.setVelocity(c.player, dir.scale(1.25).add(0, 0.85 + pitchBoost, 0));
		c.state.startTimer("leap", now + 60);
		c.state.startTimer("leapsafe", now + 100);
		c.state.var("leapAir", 0);
		Fx.shockRing(c.level, Fx.dust(RED, 1.4f), c.pos().add(0, 0.1, 0), 0.4, 20, 0.2);
		KitUtil.debris(c.level, c.pos(), 0.6, 20);
		Fx.at(c.level, ParticleTypes.CLOUD, c.pos(), 10, 0.3, 0.05);
		Fx.sound(c.level, c.pos(), SoundEvents.RAVAGER_ROAR, 0.5f, 1.5f);
		Fx.sound(c.level, c.pos(), SoundEvents.PLAYER_ATTACK_SWEEP, 1f, 0.6f);
		Fx.custom(c.level, c.pos(), "rage_leap", 1f, 1f);
		c.state.addVar("leapCount", 1);
		return true;
	}

	private void slam(Ctx c) {
		Vec3 at = c.pos();
		double r = c.num("a1.radius", 4.0);
		float dmg = c.dmg("a1.damage", 6.0);
		Fx.shockRing(c.level, Fx.dust(RED, 2.2f), at.add(0, 0.15, 0), 0.5, 48, r * 0.09);
		Fx.shockRing(c.level, Fx.dust(DARK, 1.8f), at.add(0, 0.3, 0), 0.3, 32, r * 0.06);
		KitUtil.debris(c.level, at, r * 0.5, 80);
		KitUtil.dustOfBlock(c.level, at, r * 0.4, 30);
		Fx.at(c.level, ParticleTypes.EXPLOSION, at.add(0, 0.3, 0), 3, r * 0.3, 0);
		Fx.at(c.level, ParticleTypes.FLAME, at, 25, r * 0.3, 0.05);
		Fx.sound(c.level, at, SoundEvents.MACE_SMASH_GROUND_HEAVY, 1.2f, 0.7f);
		Fx.sound(c.level, at, SoundEvents.GENERIC_EXPLODE, 0.6f, 0.6f);
		Fx.custom(c.level, at, "rage_slam", 1.3f, 1f);
		int hits = 0;
		for (LivingEntity e : c.enemies(at, r)) {
			double falloff = 1 - 0.4 * (e.distanceTo(c.player) / r);
			if (c.hit(e, (float) (dmg * falloff))) hits++;
			Ctx.knockFrom(e, at, 0.7, 0.55);
		}
		if (hits >= 3) Mastery.feat(c.player, c.type, "leap3");
		if (c.flag("rage.leap_fury")) addFury(c, 25);
		// Avalanche: one free recast within 3 seconds of landing.
		long now = c.level.getGameTime();
		if (c.flag("rage.leap_twice") && !c.state.timer("avalanche_used", now)) {
			c.state.startTimer("avalanche_used", now + 100);
			ServerPlayer p = c.player;
			long ready = net.chaoshearts.ability.AbilityManager.readyAt(p, c.type, 0);
			double count = c.state.var("leapCount");
			net.chaoshearts.ability.AbilityManager.setReadyAt(p, c.type, 0, 0);
			Fx.actionBar(p, net.minecraft.network.chat.Component.literal("Avalanche: leap again!").withStyle(c.type.style().withBold(true)));
			Scheduler.later(60, () -> {
				// Not used in time: the original cooldown resumes.
				if (c.state.var("leapCount") == count) net.chaoshearts.ability.AbilityManager.setReadyAt(p, c.type, 0, ready);
			});
		}
	}

	private boolean warCry(Ctx c) {
		double r = c.num("a2.radius", 8.0);
		int dur = c.ticks("a2.duration", 5.0);
		boolean empowered = c.state.var("fury") >= 30;
		if (empowered) c.state.addVar("fury", -30);
		Vec3 at = c.pos();
		Combat.buff(c.player, MobEffects.STRENGTH, 120, empowered ? 1 : 0);
		if (c.flag("rage.cry_resist")) Combat.buff(c.player, MobEffects.RESISTANCE, 100, 0);
		if (c.flag("rage.cry_allies")) {
			for (LivingEntity a : c.allies(at, r)) if (a != c.player) Combat.buff(a, MobEffects.STRENGTH, 120, 0);
		}
		int weakened = 0;
		for (LivingEntity e : c.enemies(at, r)) {
			if (c.control(e, MobEffects.WEAKNESS, dur, 0)) weakened++;
			if (empowered) c.control(e, MobEffects.SLOWNESS, dur, 0);
			Fx.at(c.level, ParticleTypes.ANGRY_VILLAGER, e.getEyePosition(), 2, 0.2, 0);
			c.rewardHit(e);
		}
		if (weakened >= 5) Mastery.feat(c.player, c.type, "cry5");
		Fx.sound(c.level, at, SoundEvents.RAVAGER_ROAR, 1.2f, empowered ? 0.7f : 0.9f);
		Fx.sound(c.level, at, SoundEvents.GOAT_SCREAMING_RAM_IMPACT, 0.8f, 0.5f);
		Fx.custom(c.level, at, "rage_warcry", 1.4f, 1f);
		for (int i = 0; i < 4; i++) {
			final int k = i;
			Scheduler.later(1 + i * 2, () -> {
				double rr = r * (k + 1) / 4.0;
				Fx.ring(c.level, Fx.dust(k % 2 == 0 ? RED : EMBER, 1.8f), at.add(0, 0.4 + k * 0.25, 0), rr, (int) (rr * 10));
			});
		}
		Fx.at(c.level, ParticleTypes.SONIC_BOOM, c.eye().add(c.look().scale(1.2)), 1, 0, 0);
		if (c.flag("rage.banner")) banner(c, at, r * 0.6);
		return true;
	}

	private void banner(Ctx c, Vec3 at, double r) {
		ServerPlayer owner = c.player;
		Scheduler.repeat(0, 10, 16, i -> {
			Fx.pillar(c.level, Fx.dust(RED, 1.5f), at, 3.5, 10, 0.05);
			Fx.ring(c.level, Fx.dust(0xFFB020, 1.0f), at.add(0, 0.1, 0), r, (int) (r * 8), i * 0.3);
			Ctx cc = net.chaoshearts.ability.AbilityManager.ctx(owner);
			if (cc == null) return false;
			for (LivingEntity a : cc.allies(at, r)) Combat.buff(a, MobEffects.REGENERATION, 30, 0);
			for (LivingEntity e : cc.enemies(at, r)) Combat.debuff(e, MobEffects.WEAKNESS, 30, 0, owner);
			return true;
		});
	}

	private boolean berserk(Ctx c) {
		long now = c.level.getGameTime();
		c.state.startTimer("berserk", now + 120);
		c.state.var("berserkHits", 3 + (c.awakened ? 1 : 0));
		Fx.sphere(c.level, Fx.dust(EMBER, 1.2f), c.center(), 1.1, 40);
		Fx.at(c.level, ParticleTypes.FLAME, c.center(), 15, 0.4, 0.05);
		Fx.sound(c.level, c.pos(), SoundEvents.ARMOR_EQUIP_NETHERITE.value(), 1f, 0.6f);
		Fx.sound(c.level, c.pos(), SoundEvents.BLAZE_SHOOT, 0.5f, 0.6f);
		Fx.custom(c.level, c.pos(), "rage_berserk", 1f, 1f);
		return true;
	}

	private boolean rampage(Ctx c) {
		long now = c.level.getGameTime();
		c.state.startTimer("rampage", now + c.ticks("a4.duration", 10.0));
		addFury(c, 50);
		Vec3 at = c.pos();
		Fx.far(c.level, ParticleTypes.EXPLOSION_EMITTER, at.add(0, 0.5, 0), 1, 0, 0);
		Fx.shockRing(c.level, Fx.dust(RED, 2.5f), at.add(0, 0.2, 0), 0.5, 60, 0.6);
		Fx.pillar(c.level, ParticleTypes.FLAME, at, 5, 30, 0.2);
		Fx.sound(c.level, at, SoundEvents.ENDER_DRAGON_GROWL, 0.9f, 1.3f);
		Fx.sound(c.level, at, SoundEvents.RAVAGER_ROAR, 1f, 0.6f);
		Fx.custom(c.level, at, "rage_rampage", 1.5f, 1f);
		Fx.title(c.player, net.minecraft.network.chat.Component.empty(), net.minecraft.network.chat.Component.literal("R A M P A G E").withStyle(c.type.style().withBold(true)), 2, 25, 8);
		for (LivingEntity e : c.enemies(at, 4)) Ctx.knockFrom(e, at, 0.8, 0.3);
		List<LivingEntity> near = c.enemies(at, 10);
		for (LivingEntity e : near) if (e instanceof ServerPlayer sp) Fx.soundTo(sp, SoundEvents.WARDEN_HEARTBEAT, 1f, 1.3f);
		return true;
	}
}
