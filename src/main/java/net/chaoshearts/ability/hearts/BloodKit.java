package net.chaoshearts.ability.hearts;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.joml.Quaternionf;
import org.joml.Vector3f;

import net.chaoshearts.ability.AbilityManager;
import net.chaoshearts.ability.Ctx;
import net.chaoshearts.ability.HeartKit;
import net.chaoshearts.ability.KitUtil;
import net.chaoshearts.combat.Combat;
import net.chaoshearts.fx.Displays;
import net.chaoshearts.fx.Fx;
import net.chaoshearts.fx.Scheduler;
import net.chaoshearts.fx.SimProjectile;
import net.chaoshearts.heart.HeartType;
import net.chaoshearts.mastery.Mastery;
import net.chaoshearts.skill.SkillTree;
import net.minecraft.ChatFormatting;
import net.minecraft.core.particles.ParticleTypes;
import net.minecraft.network.chat.Component;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.effect.MobEffects;
import net.minecraft.world.entity.LivingEntity;
import net.minecraft.world.entity.player.Player;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.Items;
import net.minecraft.world.level.ClipContext;
import net.minecraft.world.phys.HitResult;
import net.minecraft.world.phys.Vec3;

/** Blood: drink from every wound, pay in health for power, and call the Blood Moon. */
public final class BloodKit extends HeartKit {
	private static final int RED = 0x9E0B1F, DARK = 0x2B0006, BRIGHT = 0xFF2D3F;

	private final SkillTree tree;
	/** target -> bleed {ownerMostSig, ownerLeastSig, ticksLeft} */
	private final Map<UUID, Bleed> bleeds = new HashMap<>();

	private static final class Bleed {
		final UUID owner;
		int ticks;
		final LivingEntity target;

		Bleed(UUID owner, int ticks, LivingEntity target) {
			this.owner = owner;
			this.ticks = ticks;
			this.target = target;
		}
	}

	public BloodKit() {
		super(HeartType.BLOOD);
		ability(0, "Blood Spike", "Hurl a spike of blood that wounds and feeds you.", 8, this::spike);
		ability(1, "Crimson Pact", "Pay 2 hearts for a surge of Strength II.", 20, this::pact);
		ability(2, "Siphon", "Tether yourself to an enemy and drink their life.", 26, this::siphon);
		ability(3, "Blood Moon", "The moon bleeds: you drink deeply and every enemy near you bleeds.", 140, this::bloodMoon);

		feat("steal500", "Insatiable", "Heal 500 health with the Blood Heart", 500);
		feat("bleed10", "Exsanguinate", "Kill 10 enemies while they bleed", 400);
		feat("price", "Blood Price", "Kill a player during Crimson Pact while below 4 hearts", 600);
		feat("feast", "Feast", "Heal 20 health during one Blood Moon", 600);

		SkillTree t = new SkillTree("blood");
		t.branch("Vampire", "Never stop drinking", RED,
				t.node(0, "thirst", "Thirst", "+50% lifesteal").mod("p.lifesteal", 0.5),
				t.node(1, "long_draw", "Long Draw", "+40% Siphon duration").mod("a3.duration", 0.4),
				t.node(2, "night_feeder", "Night Feeder", "Lifesteal doubles at night").flag("blood.night"),
				t.node(3, "bloodbank", "Bloodbank", "Siphon healing beyond full health becomes absorption").flag("blood.bank"),
				t.node(4, "undeath", "Undeath", "CAPSTONE: Siphon drains every enemy near you at once").flag("blood.mass_siphon"));
		t.branch("Hemomancer", "Open every vein", BRIGHT,
				t.node(0, "deep_cuts", "Deep Cuts", "Bleeding lasts 50% longer").mod("p.bleed", 0.5),
				t.node(1, "spike_volley", "Spike Volley", "Blood Spike throws three spikes").flag("blood.volley"),
				t.node(2, "open_veins", "Open Veins", "Bleeding enemies take 10% more damage from you").flag("blood.veins"),
				t.node(3, "blood_rain", "Blood Rain", "+50% Blood Moon bleed damage").mod("a4.damage", 0.5),
				t.node(4, "burst", "Hemorrhagic Burst", "CAPSTONE: bleeding enemies burst when they die, making everyone near them bleed").flag("blood.burst"));
		t.branch("Berserker", "Pay any price", DARK,
				t.node(0, "cheap_price", "Cheap Price", "Crimson Pact costs 1 heart instead of 2").flag("blood.cheap"),
				t.node(1, "frenzy", "Blood Frenzy", "+40% Crimson Pact duration").mod("a2.duration", 0.4),
				t.node(2, "tolerance", "Pain Tolerance", "Take 10% less damage below half health").flag("blood.tolerance"),
				t.node(3, "red_haste", "Red Haste", "Crimson Pact also grants Speed II and Haste II").flag("blood.haste"),
				t.node(4, "martyr", "Martyr", "CAPSTONE: killing a player resets Crimson Pact").flag("blood.martyr"));
		tree = t;
	}

	@Override public String passive1Name() { return "Lifesteal"; }
	@Override public String passive1Description() { return "Heal 10% of the melee damage you deal."; }
	@Override public String passive2Name() { return "Hemorrhage"; }
	@Override public String passive2Description() { return "Critical hits make enemies bleed for 4 seconds."; }
	@Override public String awakenedName() { return "Sanguine Lord"; }
	@Override public String awakenedDescription() { return "Healing beyond full health becomes up to 3 hearts of absorption."; }
	@Override public SkillTree tree() { return tree; }

	/** Heals the owner, counting toward feats; overheal becomes absorption when awakened or with Bloodbank. */
	private void drink(Ctx c, float amount, boolean bank) {
		if (amount <= 0) return;
		ServerPlayer p = c.player;
		float missing = p.getMaxHealth() - p.getHealth();
		p.heal(amount);
		float over = amount - missing;
		if (over > 0 && (c.awakened || bank)) p.setAbsorptionAmount(Math.min(6f, p.getAbsorptionAmount() + over));
		long total = Mastery.counter(p, c.type, "healed_x10", Math.round(amount * 10));
		if (total >= 5000) Mastery.feat(p, c.type, "steal500");
		if (c.state.timer("moon", c.level.getGameTime()) && c.state.addVar("moonHeal", amount) >= 20) Mastery.feat(p, c.type, "feast");
	}

	private void bleed(Ctx c, LivingEntity e, int ticks) {
		int t = (int) (ticks * (1 + c.skills.mod("p.bleed")));
		Bleed b = bleeds.get(e.getUUID());
		if (b != null && b.owner.equals(c.player.getUUID())) b.ticks = Math.max(b.ticks, t);
		else bleeds.put(e.getUUID(), new Bleed(c.player.getUUID(), t, e));
	}

	private boolean bleeding(LivingEntity e) {
		Bleed b = bleeds.get(e.getUUID());
		return b != null && b.ticks > 0;
	}

	private double lifesteal(Ctx c) {
		double base = 0.10 * (1 + c.skills.mod("p.lifesteal"));
		if (c.flag("blood.night") && c.level.isDarkOutside()) base *= 2;
		if (c.state.timer("moon", c.level.getGameTime())) base = Math.max(base, 0.40);
		return base;
	}

	@Override
	public void tick(Ctx c, long t) {
		long now = c.level.getGameTime();
		// Bleeds caused by this player tick here (one owner per bleed).
		if (t % 20 == 0) {
			Iterator<Map.Entry<UUID, Bleed>> it = bleeds.entrySet().iterator();
			while (it.hasNext()) {
				Bleed b = it.next().getValue();
				if (!b.owner.equals(c.player.getUUID())) continue;
				if (!b.target.isAlive() || b.ticks <= 0 || b.target.level() != c.level) {
					it.remove();
					continue;
				}
				b.ticks -= 20;
				Combat.damage(c.player, b.target, 1f, true);
				Vec3 at = b.target.position().add(0, b.target.getBbHeight() * 0.6, 0);
				Fx.at(c.level, Fx.dust(RED, 1.2f), at, 8, 0.25, 0);
				Fx.at(c.level, ParticleTypes.DAMAGE_INDICATOR, at, 1, 0.1, 0);
				if (!b.target.isAlive()) {
					it.remove();
					onBleedDeath(c, b.target);
				}
			}
		}
		if (c.state.timer("pact", now) && t % 3 == 0) {
			Fx.at(c.level, Fx.dust(BRIGHT, 1.1f), c.center(), 2, 0.3, 0.5, 0.3, 0);
			Fx.at(c.level, ParticleTypes.DRIPPING_LAVA, c.pos().add(0, 1.2, 0), 1, 0.2, 0);
		}
		if (c.state.timer("moon", now)) moonTick(c, t);
	}

	private void onBleedDeath(Ctx c, LivingEntity victim) {
		if (Mastery.counter(c.player, c.type, "bleed_kills", 1) >= 10) Mastery.feat(c.player, c.type, "bleed10");
		if (c.flag("blood.burst")) {
			Vec3 at = victim.position().add(0, 1, 0);
			Fx.sphere(c.level, Fx.dust(BRIGHT, 1.8f), at, 1.5, 60);
			Fx.at(c.level, Fx.dust(DARK, 2f), at, 30, 1.2, 0);
			Fx.sound(c.level, at, SoundEvents.SLIME_SQUISH, 1f, 0.5f);
			Fx.sound(c.level, at, SoundEvents.WARDEN_HEARTBEAT, 1f, 1.5f);
			for (LivingEntity e : c.enemies(at, 4)) {
				bleed(c, e, 80);
				c.hit(e, 3);
			}
		}
	}

	@Override
	public void aura(Ctx c, long t) {
		Fx.at(c.level, ParticleTypes.DRIPPING_LAVA, c.center(), 1, 0.3, 0.4, 0.3, 0);
		if (c.awakened) Fx.at(c.level, Fx.dust(DARK, 1.2f), c.pos().add(0, 0.1, 0), 2, 0.4, 0);
	}

	@Override
	public float outgoing(Ctx c, LivingEntity target, DamageSource s, float amount) {
		if (c.flag("blood.veins") && bleeding(target)) amount *= 1.1f;
		return amount;
	}

	@Override
	public float incoming(Ctx c, DamageSource s, float amount) {
		if (c.flag("blood.tolerance") && c.player.getHealth() < c.player.getMaxHealth() / 2) amount *= 0.9f;
		return amount;
	}

	@Override
	public void afterHit(Ctx c, LivingEntity target, float amount, boolean ability) {
		if (ability) return;
		drink(c, (float) (amount * lifesteal(c)), false);
		Fx.line(c.level, Fx.dust(RED, 0.8f), target.position().add(0, 1, 0), c.center(), 0.5);
		ServerPlayer p = c.player;
		boolean crit = p.fallDistance > 0 && !p.onGround() && !p.onClimbable() && !p.isInWater() && !p.isPassenger();
		if (crit && c.unlocked(Mastery.LVL_PASSIVE2) && target.isAlive()) {
			bleed(c, target, 80);
			Fx.at(c.level, Fx.dust(BRIGHT, 1.5f), target.position().add(0, 1, 0), 15, 0.3, 0);
			Fx.sound(c.level, target.position(), SoundEvents.HONEY_BLOCK_BREAK, 0.8f, 0.6f);
		}
	}

	@Override
	public void onKill(Ctx c, LivingEntity victim) {
		if (bleeding(victim)) {
			bleeds.remove(victim.getUUID());
			onBleedDeath(c, victim);
		}
		long now = c.level.getGameTime();
		if (victim instanceof Player) {
			if (c.state.timer("pact", now) && c.player.getHealth() < 8) Mastery.feat(c.player, c.type, "price");
			if (c.flag("blood.martyr")) {
				AbilityManager.setReadyAt(c.player, c.type, 1, 0);
				Fx.actionBar(c.player, Component.literal("Martyr: Crimson Pact is ready").withStyle(c.type.style().withBold(true)));
			}
		}
	}

	@Override
	public String hud(Ctx c, long t) {
		long now = c.level.getGameTime();
		if (c.state.timer("moon", now)) return "☾ BLOOD MOON " + (c.state.timerLeft("moon", now) / 20 + 1) + "s";
		if (c.state.timer("pact", now)) return "Pact " + (c.state.timerLeft("pact", now) / 20 + 1) + "s";
		return null;
	}

	// ---------------------------------------------------------------- abilities

	private void spikeProjectile(Ctx c, Vec3 dir) {
		ServerPlayer p = c.player;
		ServerLevel level = c.level;
		float dmg = c.dmg("a1.damage", 6.0);
		Vec3 from = c.eye().add(dir.scale(0.7)).subtract(0, 0.2, 0);
		SimProjectile pr = new SimProjectile(level, from, dir.normalize().scale(1.8));
		pr.owner = p;
		pr.radius = 0.4;
		pr.maxTicks = 30;
		pr.gravity = 0.01;
		pr.display = Displays.item(level, from, new ItemStack(Items.POINTED_DRIPSTONE), 0.7f, true);
		if (pr.display != null) {
			float yaw = (float) Math.atan2(-dir.x, dir.z);
			float pitch = (float) Math.asin(-dir.y);
			Displays.transform(pr.display, new Vector3f(), new Quaternionf().rotateY(-yaw).rotateX(pitch + (float) Math.PI / 2), new Vector3f(0.7f), 0);
			Displays.glow(pr.display, BRIGHT);
		}
		pr.canHit(e -> Combat.canTarget(p, e));
		pr.onTick(s -> {
			Fx.at(level, Fx.dust(RED, 1.3f), s.pos, 3, 0.06, 0);
			if (s.age() % 2 == 0) Fx.at(level, ParticleTypes.DRIPPING_LAVA, s.pos, 1, 0.05, 0);
		});
		pr.onEntity((s, e) -> {
			Ctx cc = AbilityManager.ctx(p);
			if (cc == null) return;
			if (cc.hit(e, dmg)) {
				drink(cc, 2, false);
				bleed(cc, e, 60);
				Fx.line(level, Fx.dust(BRIGHT, 1f), e.position().add(0, 1, 0), p.position().add(0, 1, 0), 0.4);
			}
		});
		pr.onEnd((s, at) -> {
			Fx.at(level, Fx.dust(RED, 1.8f), at, 25, 0.3, 0);
			Fx.sound(level, at, SoundEvents.POINTED_DRIPSTONE_LAND, 1f, 0.8f);
			Fx.sound(level, at, SoundEvents.SLIME_SQUISH_SMALL, 1f, 0.6f);
		});
		pr.launch();
	}

	private boolean spike(Ctx c) {
		if (c.flag("blood.volley")) {
			for (int i = -1; i <= 1; i++) spikeProjectile(c, KitUtil.rotateY(c.look(), Math.toRadians(i * 8)));
		} else {
			spikeProjectile(c, c.look());
		}
		Fx.sound(c.level, c.pos(), SoundEvents.TRIDENT_THROW.value(), 1f, 0.6f);
		Fx.custom(c.level, c.pos(), "blood_spike", 1f, 1f);
		return true;
	}

	private boolean pact(Ctx c) {
		ServerPlayer p = c.player;
		float cost = c.flag("blood.cheap") ? 2 : 4;
		if (p.getHealth() <= cost + 1) {
			Fx.actionBar(p, Component.literal("Too weak to pay the price.").withStyle(ChatFormatting.RED));
			return false;
		}
		long now = c.level.getGameTime();
		int dur = c.ticks("a2.duration", 8.0);
		p.setHealth(p.getHealth() - cost);
		Combat.buff(p, MobEffects.STRENGTH, dur, 1);
		if (c.flag("blood.haste")) {
			Combat.buff(p, MobEffects.SPEED, dur, 1);
			Combat.buff(p, MobEffects.HASTE, dur, 1);
		}
		c.state.startTimer("pact", now + dur);
		Vec3 at = c.center();
		Fx.sphere(c.level, Fx.dust(BRIGHT, 1.6f), at, 1.2, 60);
		Fx.at(c.level, Fx.dust(DARK, 2f), at, 30, 0.5, 0);
		Fx.at(c.level, ParticleTypes.DAMAGE_INDICATOR, at, 6, 0.3, 0.1);
		Fx.sound(c.level, at, SoundEvents.WARDEN_HEARTBEAT, 1.5f, 0.8f);
		Fx.sound(c.level, at, SoundEvents.PLAYER_HURT, 0.8f, 0.6f);
		Fx.custom(c.level, at, "blood_pact", 1f, 1f);
		return true;
	}

	private boolean siphon(Ctx c) {
		ServerPlayer p = c.player;
		ServerLevel level = c.level;
		List<LivingEntity> targets;
		if (c.flag("blood.mass_siphon")) {
			targets = c.enemies(c.center(), 6);
		} else {
			LivingEntity t = c.aimEntity(10, 1.0);
			if (t == null) {
				List<LivingEntity> near = c.enemies(c.center(), 8);
				t = near.isEmpty() ? null : near.get(0);
			}
			targets = t == null ? List.of() : List.of(t);
		}
		if (targets.isEmpty()) {
			Fx.actionBar(p, Component.literal("Nothing to drink from.").withStyle(ChatFormatting.GRAY));
			return false;
		}
		int dur = c.ticks("a3.duration", 4.0);
		float per = c.dmg("a3.damage", 1.5);
		Fx.sound(level, c.pos(), SoundEvents.ZOMBIE_VILLAGER_CURE, 0.4f, 1.8f);
		Fx.custom(level, c.pos(), "blood_siphon", 1f, 1f);
		Scheduler.repeat(0, 2, dur / 2, i -> {
			Ctx cc = AbilityManager.ctx(p);
			if (cc == null || cc.type != HeartType.BLOOD) return false;
			boolean any = false;
			for (LivingEntity e : targets) {
				if (!e.isAlive() || e.distanceTo(p) > 12 || e.level() != p.level()) continue;
				Vec3 from = e.position().add(0, e.getBbHeight() / 2, 0);
				Vec3 to = cc.center();
				if (level.clip(new ClipContext(from, to, ClipContext.Block.COLLIDER, ClipContext.Fluid.NONE, p)).getType() != HitResult.Type.MISS) continue;
				any = true;
				// Blood flowing along the tether toward the caster.
				double phase = (i % 5) / 5.0;
				for (int k = 0; k < 6; k++) Fx.at(level, Fx.dust(k % 2 == 0 ? RED : BRIGHT, 1.1f), from.lerp(to, (k + phase) / 6.0), 1, 0.02, 0);
				if (i % 5 == 0) {
					if (cc.hit(e, per)) drink(cc, per, cc.flag("blood.bank"));
					Fx.sound(level, from, SoundEvents.HONEY_DRINK.value(), 0.5f, 0.6f);
				}
			}
			return any;
		});
		return true;
	}

	private boolean bloodMoon(Ctx c) {
		long now = c.level.getGameTime();
		int dur = c.ticks("a4.duration", 12.0);
		c.state.startTimer("moon", now + dur);
		c.state.var("moonHeal", 0);
		Combat.buff(c.player, MobEffects.STRENGTH, dur, 0);
		Fx.far(c.level, ParticleTypes.EXPLOSION_EMITTER, c.center(), 1, 0, 0);
		Fx.sound(c.level, c.pos(), SoundEvents.WITHER_AMBIENT, 1f, 0.5f);
		Fx.sound(c.level, c.pos(), SoundEvents.WARDEN_HEARTBEAT, 2f, 0.6f);
		Fx.custom(c.level, c.pos(), "blood_moon", 2f, 1f);
		Fx.title(c.player, Component.empty(), Component.literal("☾ The Blood Moon rises").withStyle(c.type.style().withBold(true)), 2, 30, 10);
		for (LivingEntity e : c.enemies(c.pos(), 16)) if (e instanceof ServerPlayer sp) Fx.title(sp, Component.empty(), Component.literal("☾ The moon bleeds").withStyle(ChatFormatting.DARK_RED), 2, 30, 10);
		return true;
	}

	private void moonTick(Ctx c, long t) {
		ServerLevel level = c.level;
		Vec3 moon = c.pos().add(0, 9, 0);
		double r = c.num("a4.radius", 10.0);
		if (t % 3 == 0) {
			Fx.disc(level, Fx.dust(BRIGHT, 3.5f), moon, 2.2, 18);
			Fx.ring(level, Fx.dust(DARK, 2.5f), moon, 2.5, 20, t * 0.05);
			Fx.ring(level, Fx.dust(RED, 1.2f), c.pos().add(0, 0.1, 0), r, (int) (r * 5), -t * 0.04);
			Fx.at(level, ParticleTypes.CRIMSON_SPORE, c.pos().add(0, 2, 0), 10, r * 0.5, 1.5, r * 0.5, 0);
		}
		if (t % 20 == 0) {
			for (LivingEntity e : c.enemies(c.pos(), r)) {
				bleed(c, e, 30);
				if (c.skills.mod("a4.damage") > 0) c.hit(e, c.dmg("a4.damage", 1.0) - 1f);
				if (e instanceof ServerPlayer sp) Fx.soundTo(sp, SoundEvents.WARDEN_HEARTBEAT, 0.8f, 1.2f);
			}
		}
	}
}
