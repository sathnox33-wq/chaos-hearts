package net.chaoshearts.ability.hearts;

import java.util.ArrayList;
import java.util.List;

import net.chaoshearts.ability.AbilityManager;
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
import net.minecraft.resources.Identifier;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.tags.EntityTypeTags;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.effect.MobEffectInstance;
import net.minecraft.world.effect.MobEffects;
import net.minecraft.world.entity.LivingEntity;
import net.minecraft.world.entity.ai.attributes.AttributeModifier;
import net.minecraft.world.entity.ai.attributes.Attributes;
import net.minecraft.world.phys.AABB;
import net.minecraft.world.phys.Vec3;

/** Celestial: falling stars, holy ground, beams of light and ascension. */
public final class CelestialKit extends HeartKit {
	private static final int GOLD = 0xFFC94A, PALE = 0xFFF2B0, WHITE = 0xFFFFFF, SKY = 0x9AD8FF;

	private final SkillTree tree;
	private final Identifier hover = modifierId("ascension_gravity");

	public CelestialKit() {
		super(HeartType.CELESTIAL);
		ability(0, "Starfall", "Call a star down from the sky onto your target.", 9, this::starfall);
		ability(1, "Sanctuary", "Consecrate the ground: allies heal, enemies are weakened.", 28, this::sanctuary);
		ability(2, "Radiant Beam", "A lance of light that pierces everything in a line.", 22, this::beam);
		ability(3, "Ascension", "Rise into the air, shielded by light, as stars rain on your foes.", 150, this::ascension);

		feat("shooting_star", "Shooting Star", "Hit an airborne enemy with Starfall", 300);
		feat("haven", "Haven", "Recover 40 health inside your Sanctuaries", 400);
		feat("lance3", "Lance of Light", "Hit 3 enemies with one Radiant Beam", 500);
		feat("wrath10", "Heaven's Wrath", "Land 10 star hits in one Ascension", 700);

		SkillTree t = new SkillTree("celestial");
		t.branch("Astromancer", "Pull down the heavens", GOLD,
				t.node(0, "heavier_stars", "Heavier Stars", "+25% Starfall damage").mod("a1.damage", 0.25),
				t.node(1, "shower", "Meteor Shower", "Starfall brings two smaller stars with it").flag("celestial.shower"),
				t.node(2, "starburn", "Starburn", "Starfall slows what it hits").flag("celestial.starburn"),
				t.node(3, "constellation", "Constellation", "Starfall recharges 25% faster").mod("a1.cooldown", -0.25),
				t.node(4, "comet", "Comet", "CAPSTONE: Starfall becomes a comet with twice the blast and heavy knockback").flag("celestial.comet"));
		t.branch("Seraph", "Shelter the faithful", PALE,
				t.node(0, "wider_sanctuary", "Wider Sanctuary", "+30% Sanctuary radius").mod("a2.radius", 0.3),
				t.node(1, "blessed_ground", "Blessed Ground", "Sanctuary also grants Resistance I").flag("celestial.blessed"),
				t.node(2, "lasting_light", "Lasting Light", "+40% Sanctuary duration").mod("a2.duration", 0.4),
				t.node(3, "guardian_angel", "Guardian Angel", "Radiance pulses heal twice as much and include you").flag("celestial.angel"),
				t.node(4, "intervention", "Divine Intervention", "CAPSTONE: Sanctuary purges harmful effects from allies inside it").flag("celestial.cleanse"));
		t.branch("Radiant", "Burn with light", WHITE,
				t.node(0, "focused_light", "Focused Light", "+25% Radiant Beam damage").mod("a3.damage", 0.25),
				t.node(1, "prism", "Prism", "The beam splits into two more beams at the first enemy it hits").flag("celestial.prism"),
				t.node(2, "searing_light", "Searing Light", "Radiant Beam briefly blinds players").flag("celestial.blind"),
				t.node(3, "dawn", "Dawn", "+30% Ascension duration").mod("a4.duration", 0.3),
				t.node(4, "judgment", "Judgment", "CAPSTONE: during Ascension, pillars of light strike instead of stars, hitting everything near the target").flag("celestial.judgment"));
		tree = t;
	}

	@Override public String passive1Name() { return "Starlit"; }
	@Override public String passive1Description() { return "Permanent Night Vision. Regeneration I while standing in sunlight."; }
	@Override public String passive2Name() { return "Radiance"; }
	@Override public String passive2Description() { return "+25% damage against undead, and every 4 seconds nearby teammates are healed."; }
	@Override public String awakenedName() { return "Supernova"; }
	@Override public String awakenedDescription() { return "A halo crowns you, and Ascension ends in a blinding supernova."; }
	@Override public SkillTree tree() { return tree; }

	@Override
	public void tick(Ctx c, long t) {
		ServerPlayer p = c.player;
		long now = c.level.getGameTime();
		if (t % 20 == 0) {
			MobEffectInstance nv = p.getEffect(MobEffects.NIGHT_VISION);
			if (nv == null || nv.getDuration() < 240) Combat.buff(p, MobEffects.NIGHT_VISION, 400, 0);
			if (c.level.isBrightOutside() && c.level.canSeeSky(p.blockPosition().above())) Combat.buff(p, MobEffects.REGENERATION, 50, 0);
		}
		if (t % 80 == 0 && c.unlocked(Mastery.LVL_PASSIVE2)) {
			boolean angel = c.flag("celestial.angel");
			for (LivingEntity a : c.allies(c.pos(), 8)) {
				if (a == p && !angel) continue;
				a.heal(angel ? 2 : 1);
				Fx.at(c.level, ParticleTypes.HAPPY_VILLAGER, a.getEyePosition(), 3, 0.3, 0);
			}
		}
		if (c.state.timer("ascend", now)) ascendTick(c, t);
		else if (c.state.var("ascending") == 1) endAscension(c);
	}

	@Override
	public void aura(Ctx c, long t) {
		Fx.at(c.level, ParticleTypes.END_ROD, c.center(), 1, 0.4, 0.6, 0.4, 0.005);
		if (c.awakened) Fx.ring(c.level, Fx.dust(GOLD, 0.8f), c.player.getEyePosition().add(0, 0.55, 0), 0.32, 10, t * 0.2);
	}

	@Override
	public float outgoing(Ctx c, LivingEntity target, DamageSource s, float amount) {
		if (c.unlocked(Mastery.LVL_PASSIVE2) && target.getType().is(EntityTypeTags.UNDEAD)) amount *= 1.25f;
		return amount;
	}

	@Override
	public float incoming(Ctx c, DamageSource s, float amount) {
		if (c.state.timer("ascend", c.level.getGameTime())) return amount * 0.4f;
		return amount;
	}

	@Override
	public void onKill(Ctx c, LivingEntity victim) {}

	@Override
	public String hud(Ctx c, long t) {
		long now = c.level.getGameTime();
		if (c.state.timer("ascend", now)) return "✦ ASCENSION " + (c.state.timerLeft("ascend", now) / 20 + 1) + "s";
		return null;
	}

	@Override
	public void deactivate(ServerPlayer p) {
		super.deactivate(p);
		Ctx c = AbilityManager.ctx(p);
		if (c != null) c.state.var("ascending", 0);
	}

	// ---------------------------------------------------------------- abilities

	/** A star falls onto at. Returns immediately; impact happens 10 ticks later. */
	private void star(ServerPlayer owner, ServerLevel level, Vec3 at, float dmg, double radius, boolean comet, boolean small, Runnable onHit) {
		Vec3 sky = at.add(level.random.nextDouble() * 4 - 2, 16, level.random.nextDouble() * 4 - 2);
		int fall = 10;
		Scheduler.repeat(0, 1, fall + 1, i -> {
			if (i < fall) {
				Vec3 q = sky.lerp(at, i / (double) fall);
				Vec3 q2 = sky.lerp(at, (i + 1) / (double) fall);
				Fx.line(level, Fx.dust(i % 2 == 0 ? GOLD : PALE, comet ? 2.2f : (small ? 1.0f : 1.6f)), q, q2, 0.4);
				Fx.at(level, ParticleTypes.END_ROD, q2, comet ? 6 : 3, 0.15, 0.02);
				if (comet) Fx.at(level, ParticleTypes.FLAME, q2, 3, 0.2, 0.02);
				if (i == 0) Fx.ring(level, Fx.dust(GOLD, 1.2f), at.add(0, 0.1, 0), radius, (int) (radius * 8));
				return true;
			}
			Ctx cc = AbilityManager.ctx(owner);
			Fx.flash(level, at.add(0, 0.5, 0));
			Fx.at(level, ParticleTypes.FIREWORK, at.add(0, 0.5, 0), comet ? 60 : (small ? 12 : 30), 0.2, comet ? 0.4 : 0.25);
			Fx.shockRing(level, Fx.dust(PALE, 1.5f), at.add(0, 0.2, 0), 0.3, comet ? 48 : 24, radius * 0.1);
			Fx.sound(level, at, SoundEvents.AMETHYST_CLUSTER_BREAK, 1.2f, small ? 1.6f : 0.9f);
			Fx.sound(level, at, SoundEvents.FIREWORK_ROCKET_BLAST, 1f, small ? 1.4f : 0.8f);
			if (!small) Fx.custom(level, at, comet ? "celestial_comet" : "celestial_starfall", 1.3f, 1f);
			if (comet) Fx.sound(level, at, SoundEvents.GENERIC_EXPLODE, 1f, 1.2f);
			if (cc != null && cc.type == HeartType.CELESTIAL) {
				for (LivingEntity e : cc.enemies(at.add(0, 0.8, 0), radius)) {
					boolean airborne = !e.onGround();
					if (cc.hit(e, dmg)) {
						Combat.debuff(e, MobEffects.GLOWING, 100, 0, owner);
						if (cc.flag("celestial.starburn")) cc.control(e, MobEffects.SLOWNESS, 50, 1);
						if (airborne && !small) Mastery.feat(owner, HeartType.CELESTIAL, "shooting_star");
						if (onHit != null) onHit.run();
					}
					if (comet) Ctx.knockFrom(e, at, 1.2, 0.5);
				}
			}
			return false;
		});
	}

	private boolean starfall(Ctx c) {
		double range = c.num("a1.range", 30.0);
		LivingEntity target = c.aimEntity(range, 1.2);
		Vec3 at = target != null ? target.position() : c.aimPoint(range);
		Vec3 g = KitUtil.groundBelow(c.level, at.add(0, 1, 0), 10);
		if (g != null && target == null) at = g;
		boolean comet = c.flag("celestial.comet");
		float dmg = c.dmg("a1.damage", 7.0);
		double radius = c.num("a1.radius", 2.5) * (comet ? 2 : 1);
		Fx.sound(c.level, c.pos(), SoundEvents.BEACON_POWER_SELECT, 1f, 1.8f);
		Fx.at(c.level, ParticleTypes.END_ROD, c.player.getEyePosition().add(0, 0.6, 0), 10, 0.2, 0.1);
		star(c.player, c.level, at, dmg, radius, comet, false, null);
		if (c.flag("celestial.shower")) {
			for (int i = 0; i < 2; i++) {
				Vec3 off = at.add(c.level.random.nextDouble() * 5 - 2.5, 0, c.level.random.nextDouble() * 5 - 2.5);
				Vec3 gg = KitUtil.groundBelow(c.level, off.add(0, 3, 0), 8);
				Vec3 spot = gg == null ? off : gg;
				ServerPlayer p = c.player;
				Scheduler.later(4 + i * 4, () -> star(p, c.level, spot, dmg * 0.5f, 1.8, false, true, null));
			}
		}
		return true;
	}

	private boolean sanctuary(Ctx c) {
		ServerPlayer p = c.player;
		ServerLevel level = c.level;
		Vec3 at = c.pos();
		double r = c.num("a2.radius", 5.0);
		int dur = c.ticks("a2.duration", 6.0);
		Fx.sound(level, at, SoundEvents.BEACON_ACTIVATE, 1.5f, 1.2f);
		Fx.sound(level, at, SoundEvents.AMETHYST_BLOCK_RESONATE, 1.2f, 1.5f);
		Fx.custom(level, at, "celestial_sanctuary", 1.3f, 1f);
		Scheduler.repeat(0, 5, dur / 5, i -> {
			Ctx cc = AbilityManager.ctx(p);
			if (cc == null || cc.type != HeartType.CELESTIAL) return false;
			Fx.ring(level, Fx.dust(GOLD, 1.5f), at.add(0, 0.1, 0), r, (int) (r * 7), i * 0.2);
			Fx.ring(level, Fx.dust(PALE, 1.0f), at.add(0, 0.12, 0), r * 0.6, (int) (r * 4), -i * 0.3);
			for (int k = 0; k < 6; k++) {
				double a = i * 0.4 + k * Math.PI / 3;
				Fx.pillar(level, ParticleTypes.END_ROD, at.add(Math.cos(a) * r, 0, Math.sin(a) * r), 2.5, 3, 0.02);
			}
			Fx.at(level, ParticleTypes.WAX_OFF, at.add(0, 1, 0), 6, r * 0.5, 0.5, r * 0.5, 0);
			for (LivingEntity a : cc.allies(at, r)) {
				Combat.buff(a, MobEffects.REGENERATION, 30, 1);
				if (cc.flag("celestial.blessed")) Combat.buff(a, MobEffects.RESISTANCE, 30, 0);
				if (cc.flag("celestial.cleanse")) {
					for (MobEffectInstance inst : new ArrayList<>(a.getActiveEffects())) {
						if (!inst.getEffect().value().isBeneficial()) a.removeEffect(inst.getEffect());
					}
				}
			}
			for (LivingEntity e : cc.enemies(at, r)) {
				Combat.debuff(e, MobEffects.WEAKNESS, 30, 0, p);
				if (e.getType().is(EntityTypeTags.UNDEAD)) e.igniteForSeconds(2);
			}
			return true;
		});
		// Haven feat: count health regained while standing in the zone.
		float[] hp = {p.getHealth()};
		Scheduler.repeat(0, 10, dur / 10, i -> {
			if (p.position().distanceTo(at) <= r && p.getHealth() > hp[0]) {
				if (Mastery.counter(p, HeartType.CELESTIAL, "haven_x10", Math.round((p.getHealth() - hp[0]) * 10)) >= 400) Mastery.feat(p, HeartType.CELESTIAL, "haven");
			}
			hp[0] = p.getHealth();
			return true;
		});
		return true;
	}

	private int beamLine(Ctx c, Vec3 from, Vec3 dir, double range, float dmg, boolean split) {
		ServerLevel level = c.level;
		Vec3 to = from.add(dir.scale(range));
		var hit = level.clip(new net.minecraft.world.level.ClipContext(from, to, net.minecraft.world.level.ClipContext.Block.COLLIDER, net.minecraft.world.level.ClipContext.Fluid.NONE, c.player));
		Vec3 end = hit.getType() == net.minecraft.world.phys.HitResult.Type.MISS ? to : hit.getLocation();
		Fx.line(level, ParticleTypes.END_ROD, from, end, 0.35);
		Fx.line(level, Fx.dust(WHITE, 1.8f), from, end, 0.25);
		Fx.line(level, Fx.dust(GOLD, 1.2f), from.add(0, 0.08, 0), end.add(0, 0.08, 0), 0.4);
		Fx.flash(level, end);
		Fx.at(level, ParticleTypes.FIREWORK, end, 12, 0.1, 0.15);
		List<LivingEntity> victims = new ArrayList<>();
		for (LivingEntity e : level.getEntitiesOfClass(LivingEntity.class, new AABB(from, end).inflate(1), e -> Combat.canTarget(c.player, e))) {
			if (e.getBoundingBox().inflate(0.5).clip(from, end).isPresent()) victims.add(e);
		}
		victims.sort(java.util.Comparator.comparingDouble(e -> e.distanceToSqr(from)));
		int n = 0;
		for (LivingEntity e : victims) {
			if (c.hit(e, dmg)) {
				n++;
				Combat.debuff(e, MobEffects.GLOWING, 120, 0, c.player);
				if (c.flag("celestial.blind") && e instanceof ServerPlayer) c.control(e, MobEffects.BLINDNESS, 20, 0);
			}
		}
		if (split && !victims.isEmpty()) {
			Vec3 at = victims.get(0).position().add(0, 1, 0);
			for (int s = -1; s <= 1; s += 2) n += beamLine(c, at, KitUtil.rotateY(dir, Math.toRadians(35 * s)), range * 0.5, dmg * 0.5f, false);
		}
		return n;
	}

	private boolean beam(Ctx c) {
		Vec3 from = c.eye().add(c.look().scale(0.5)).subtract(0, 0.15, 0);
		float dmg = c.dmg("a3.damage", 8.0);
		Fx.sound(c.level, c.pos(), SoundEvents.BEACON_POWER_SELECT, 1.5f, 2f);
		Fx.sound(c.level, c.pos(), SoundEvents.GUARDIAN_ATTACK, 0.6f, 1.8f);
		Fx.custom(c.level, c.pos(), "celestial_beam", 1.3f, 1f);
		int n = beamLine(c, from, c.look(), c.num("a3.range", 24.0), dmg, c.flag("celestial.prism"));
		if (n >= 3) Mastery.feat(c.player, c.type, "lance3");
		return true;
	}

	private boolean ascension(Ctx c) {
		ServerPlayer p = c.player;
		long now = c.level.getGameTime();
		int dur = c.ticks("a4.duration", 8.0);
		c.state.startTimer("ascend", now + dur);
		c.state.var("ascending", 1);
		c.state.var("starHits", 0);
		Combat.buff(p, MobEffects.LEVITATION, 18, 3);
		ServerPlayer owner = p;
		Scheduler.later(18, () -> {
			Ctx cc = AbilityManager.ctx(owner);
			if (cc != null && cc.state.var("ascending") == 1) keepModifier(owner, Attributes.GRAVITY, hover, -1.0, AttributeModifier.Operation.ADD_MULTIPLIED_TOTAL);
			Ctx.setVelocity(owner, Vec3.ZERO);
		});
		Fx.far(c.level, ParticleTypes.END_ROD, c.center(), 80, 0.6, 0.3);
		Fx.pillar(c.level, Fx.dust(GOLD, 2f), c.pos(), 20, 60, 0.15);
		Fx.sound(c.level, c.pos(), SoundEvents.BEACON_ACTIVATE, 2f, 0.8f);
		Fx.sound(c.level, c.pos(), SoundEvents.TOTEM_USE, 0.6f, 1.6f);
		Fx.custom(c.level, c.pos(), "celestial_ascension", 2f, 1f);
		Fx.title(p, net.minecraft.network.chat.Component.empty(), net.minecraft.network.chat.Component.literal("✦ Ascension").withStyle(c.type.style().withBold(true)), 2, 30, 10);
		return true;
	}

	private void ascendTick(Ctx c, long t) {
		ServerPlayer p = c.player;
		ServerLevel level = c.level;
		// Wings of light behind the player.
		if (t % 2 == 0) {
			Vec3 back = c.flatLook().scale(-0.35);
			Vec3 side = KitUtil.rotateY(c.flatLook(), Math.PI / 2);
			Vec3 base = c.pos().add(0, 1.3, 0).add(back);
			double flap = Math.sin(t * 0.25) * 0.3;
			for (int s = -1; s <= 1; s += 2) {
				for (int i = 1; i <= 8; i++) {
					double f = i / 8.0;
					Vec3 q = base.add(side.scale(s * f * 1.8)).add(0, Math.sin(f * Math.PI) * 0.6 + flap * f, 0).add(back.scale(f));
					Fx.at(level, Fx.dust(i % 2 == 0 ? GOLD : WHITE, 1.1f), q, 1, 0.02, 0);
				}
			}
			Fx.ring(level, Fx.dust(PALE, 0.9f), p.getEyePosition().add(0, 0.6, 0), 0.35, 10, t * 0.3);
		}
		if (t % 10 == 0) {
			List<LivingEntity> targets = c.enemies(c.pos(), 18);
			if (!targets.isEmpty()) {
				LivingEntity e = targets.get(level.random.nextInt(targets.size()));
				float dmg = c.dmg("a4.damage", 5.0);
				Runnable count = () -> {
					Ctx cc = AbilityManager.ctx(p);
					if (cc != null && cc.state.addVar("starHits", 1) >= 10) Mastery.feat(p, HeartType.CELESTIAL, "wrath10");
				};
				if (c.flag("celestial.judgment")) {
					Vec3 at = e.position();
					Fx.line(level, ParticleTypes.END_ROD, at.add(0, 18, 0), at, 0.4);
					Fx.line(level, Fx.dust(WHITE, 2.2f), at.add(0, 18, 0), at, 0.3);
					Fx.flash(level, at.add(0, 0.5, 0));
					Fx.sound(level, at, SoundEvents.BEACON_POWER_SELECT, 1.2f, 2f);
					for (LivingEntity v : c.enemies(at.add(0, 1, 0), 2.5)) {
						if (c.hit(v, dmg)) count.run();
					}
				} else {
					star(p, level, e.position(), dmg, 2.0, false, true, count);
				}
			}
		}
	}

	private void endAscension(Ctx c) {
		ServerPlayer p = c.player;
		c.state.var("ascending", 0);
		keepModifier(p, Attributes.GRAVITY, hover, 0, AttributeModifier.Operation.ADD_MULTIPLIED_TOTAL);
		Combat.buff(p, MobEffects.SLOW_FALLING, 80, 0);
		if (c.awakened) {
			Vec3 at = c.center();
			Fx.far(c.level, ParticleTypes.EXPLOSION_EMITTER, at, 1, 0, 0);
			Fx.sphere(c.level, Fx.dust(WHITE, 3f), at, 4, 160);
			Fx.sphere(c.level, Fx.dust(GOLD, 2f), at, 6, 160);
			Fx.far(c.level, ParticleTypes.END_ROD, at, 100, 0.5, 0.6);
			Fx.sound(c.level, at, SoundEvents.GENERIC_EXPLODE, 1.5f, 1.4f);
			Fx.custom(c.level, at, "celestial_supernova", 2f, 1f);
			for (LivingEntity e : c.enemies(at, 6)) {
				c.hit(e, c.dmg("p.supernova", 10.0));
				c.control(e, MobEffects.BLINDNESS, 40, 0);
				Ctx.knockFrom(e, at, 1.0, 0.4);
			}
		}
	}
}
