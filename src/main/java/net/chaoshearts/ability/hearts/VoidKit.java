package net.chaoshearts.ability.hearts;

import java.util.HashSet;
import java.util.Set;
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
import net.minecraft.world.entity.Display;
import net.minecraft.world.entity.LivingEntity;
import net.minecraft.world.entity.projectile.Projectile;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.world.phys.Vec3;

/** Void: fold space. Blink, pull, swap, and open a black hole. */
public final class VoidKit extends HeartKit {
	private static final int PURPLE = 0x8A3CFF, BLACK = 0x0A0014, PINK = 0xD38CFF;

	private final SkillTree tree;
	private final java.util.Map<UUID, String> swapTarget = new java.util.HashMap<>();

	public VoidKit() {
		super(HeartType.VOID);
		ability(0, "Void Step", "Tear through space and step out where you are looking.", 8, this::voidStep);
		ability(1, "Rift Orb", "Launch a slow orb of nothing that drags enemies into it.", 20, this::riftOrb);
		ability(2, "Displace", "Swap places with a target, leaving them lost in darkness.", 30, this::displace);
		ability(3, "Singularity", "Open a black hole that swallows everything, then collapses.", 140, this::singularity);

		feat("step1000", "Wanderer of Nothing", "Travel 1,000 blocks with Void Step", 300);
		feat("orb3", "Gravity Well", "Pull 3 enemies into a single Rift Orb", 400);
		feat("swapkill", "Switcheroo", "Kill an enemy within 5 seconds of Displacing them", 500);
		feat("sing4", "Event Horizon", "Catch 4 enemies in one Singularity", 800);

		SkillTree t = new SkillTree("void");
		t.branch("Voidwalker", "Be everywhere", PURPLE,
				t.node(0, "far_reach", "Far Reach", "+30% Void Step range").mod("a1.range", 0.3),
				t.node(1, "quick_fold", "Quick Fold", "Void Step recharges 25% faster").mod("a1.cooldown", -0.25),
				t.node(2, "shadow_wake", "Shadow Wake", "Enemies near where you vanish are blinded").flag("void.wake"),
				t.node(3, "ambush", "Ambush", "Your first melee hit within 2s of a Void Step deals +50%").flag("void.ambush"),
				t.node(4, "null_dash", "Null Dash", "CAPSTONE: Void Step tears through enemies on the way for 5 damage").flag("void.path"));
		t.branch("Gravity", "Everything falls inward", BLACK,
				t.node(0, "dense_core", "Dense Core", "+40% Rift Orb pull").mod("a2.pull", 0.4),
				t.node(1, "crushing_weight", "Crushing Weight", "+30% Rift Orb damage").mod("a2.damage", 0.3),
				t.node(2, "wider_horizon", "Wider Horizon", "+25% Singularity radius").mod("a4.radius", 0.25),
				t.node(3, "lingering_pull", "Lingering Pull", "Rift Orb lasts 50% longer").mod("a2.duration", 0.5),
				t.node(4, "collapse", "Collapse", "CAPSTONE: Rift Orb ends by collapsing into a miniature Singularity").flag("void.collapse"));
		t.branch("Null", "Unmake them", PINK,
				t.node(0, "deep_dark", "Deep Dark", "Null Touch Darkness lasts twice as long").flag("void.deepdark"),
				t.node(1, "unravel", "Unravel", "Displace also weakens the target").flag("void.unravel"),
				t.node(2, "slippery_space", "Slippery Space", "Phase chance doubled to 30%").mod("p.phase", 1.0),
				t.node(3, "erasure", "Erasure", "Abilities deal +20% to enemies in Darkness").flag("void.erasure"),
				t.node(4, "oblivion", "Oblivion", "CAPSTONE: Displace hurls the target high into the sky instead of swapping").flag("void.oblivion"));
		tree = t;
	}

	@Override public String passive1Name() { return "Phase"; }
	@Override public String passive1Description() { return "15% chance to phase through projectile hits."; }
	@Override public String passive2Name() { return "Null Touch"; }
	@Override public String passive2Description() { return "Melee hits shroud enemies in Darkness."; }
	@Override public String awakenedName() { return "Event Horizon"; }
	@Override public String awakenedDescription() { return "Void Step leaves a rift for 5 seconds; cast it again to return through it."; }
	@Override public SkillTree tree() { return tree; }

	@Override
	public void tick(Ctx c, long t) {
		long now = c.level.getGameTime();
		if (c.state.timer("rift", now)) {
			Vec3 r = new Vec3(c.state.var("riftX"), c.state.var("riftY"), c.state.var("riftZ"));
			if (t % 2 == 0) {
				Fx.ring(c.level, Fx.dust(PURPLE, 1.2f), r.add(0, 1, 0), 0.6, 12, t * 0.3);
				Fx.at(c.level, ParticleTypes.PORTAL, r.add(0, 1, 0), 4, 0.2, 0.5, 0.2, 0.3);
			}
		} else if (c.state.var("riftOpen") == 1) {
			c.state.var("riftOpen", 0);
			// Rift closed unused: the Void Step cooldown starts now.
			AbilityManager.setReadyAt(c.player, c.type, 0, System.currentTimeMillis() + (long) (c.num("a1.cooldown", 8) * 1000 * 0.85));
		}
	}

	@Override
	public void aura(Ctx c, long t) {
		Fx.at(c.level, ParticleTypes.PORTAL, c.center(), 2, 0.3, 0.5, 0.3, 0.2);
		if (c.awakened) Fx.at(c.level, Fx.dust(BLACK, 1.5f), c.pos().add(0, 0.1, 0), 1, 0.3, 0);
	}

	@Override
	public float outgoing(Ctx c, LivingEntity target, DamageSource s, float amount) {
		long now = c.level.getGameTime();
		if (Combat.inAbilityDamage() && c.flag("void.erasure") && target.hasEffect(MobEffects.DARKNESS)) amount *= 1.2f;
		if (KitUtil.melee(c, s) && c.flag("void.ambush") && c.state.timer("ambush", now)) {
			c.state.stopTimer("ambush");
			Fx.at(c.level, ParticleTypes.REVERSE_PORTAL, target.getEyePosition(), 20, 0.3, 0.3);
			Fx.sound(c.level, target.position(), SoundEvents.ENDERMAN_HURT, 0.6f, 0.5f);
			amount *= 1.5f;
		}
		return amount;
	}

	@Override
	public float incoming(Ctx c, DamageSource s, float amount) {
		if (s.getDirectEntity() instanceof Projectile && c.level.random.nextDouble() < 0.15 * (1 + c.skills.mod("p.phase"))) {
			Fx.at(c.level, ParticleTypes.REVERSE_PORTAL, c.center(), 20, 0.3, 0.1);
			Fx.sound(c.level, c.pos(), SoundEvents.ENDERMAN_TELEPORT, 0.5f, 1.6f);
			Fx.actionBar(c.player, Component.literal("Phased").withStyle(ChatFormatting.DARK_PURPLE));
			return 0;
		}
		return amount;
	}

	@Override
	public void afterHit(Ctx c, LivingEntity target, float amount, boolean ability) {
		if (!ability && c.unlocked(Mastery.LVL_PASSIVE2)) {
			Combat.debuff(target, MobEffects.DARKNESS, c.flag("void.deepdark") ? 120 : 60, 0, c.player);
			Fx.at(c.level, Fx.dust(BLACK, 1.4f), target.getEyePosition(), 6, 0.3, 0);
		}
	}

	@Override
	public void onKill(Ctx c, LivingEntity victim) {
		String id = swapTarget.get(c.player.getUUID());
		if (id != null && id.equals(victim.getUUID().toString()) && c.state.timer("swap", c.level.getGameTime())) {
			Mastery.feat(c.player, c.type, "swapkill");
		}
	}

	// ---------------------------------------------------------------- abilities

	private Vec3 findLanding(ServerLevel level, Vec3 from, Vec3 target) {
		Vec3 dir = target.subtract(from);
		double len = dir.length();
		if (len < 0.5) return null;
		dir = dir.normalize();
		for (double d = len; d > 1; d -= 0.5) {
			Vec3 q = from.add(dir.scale(d));
			Vec3 feet = new Vec3(q.x, Math.floor(q.y), q.z);
			for (int up = 0; up <= 2; up++) {
				Vec3 f = feet.add(0, up, 0);
				if (KitUtil.safeSpot(level, f)) return f;
			}
		}
		return null;
	}

	private boolean voidStep(Ctx c) {
		ServerPlayer p = c.player;
		long now = c.level.getGameTime();
		Vec3 start = c.pos();
		Vec3 dest;
		boolean returning = c.awakened && c.state.timer("rift", now);
		if (returning) {
			dest = new Vec3(c.state.var("riftX"), c.state.var("riftY"), c.state.var("riftZ"));
			c.state.stopTimer("rift");
			c.state.var("riftOpen", 0);
		} else {
			Vec3 aim = c.aimPoint(c.num("a1.range", 20.0));
			dest = findLanding(c.level, c.eye().subtract(0, 1.5, 0), aim.subtract(c.look().scale(0.6)));
			if (dest == null) {
				Fx.actionBar(p, Component.literal("Nowhere to step.").withStyle(ChatFormatting.GRAY));
				return false;
			}
		}
		Fx.implode(c.level, ParticleTypes.PORTAL, start.add(0, 1, 0), 1.6, 40, 0.6);
		Fx.at(c.level, Fx.dust(BLACK, 1.8f), start.add(0, 1, 0), 20, 0.3, 0.6, 0.3, 0);
		if (c.flag("void.wake")) for (LivingEntity e : c.enemies(start, 4)) c.control(e, MobEffects.BLINDNESS, 40, 0);
		p.teleportTo(c.level, dest.x, dest.y, dest.z, Set.of(), p.getYRot(), p.getXRot(), false);
		p.fallDistance = 0;
		Ctx.setVelocity(p, Vec3.ZERO);
		Fx.line(c.level, Fx.dust(PURPLE, 1.1f), start.add(0, 1, 0), dest.add(0, 1, 0), 0.5);
		Fx.at(c.level, ParticleTypes.REVERSE_PORTAL, dest.add(0, 1, 0), 40, 0.3, 0.6, 0.3, 0.1);
		Fx.sound(c.level, start, SoundEvents.ENDERMAN_TELEPORT, 0.8f, 0.6f);
		Fx.sound(c.level, dest, SoundEvents.ENDERMAN_TELEPORT, 0.8f, 0.8f);
		Fx.custom(c.level, dest, "void_step", 1f, 1f);
		if (c.flag("void.path")) {
			for (LivingEntity e : c.level.getEntitiesOfClass(LivingEntity.class, new net.minecraft.world.phys.AABB(start, dest).inflate(1), e -> Combat.canTarget(p, e))) {
				if (e.getBoundingBox().inflate(0.8).clip(start.add(0, 1, 0), dest.add(0, 1, 0)).isPresent()) c.hit(e, c.dmg("p.nulldash", 5));
			}
		}
		if (Mastery.counter(p, c.type, "step_m", (long) start.distanceTo(dest)) >= 1000) Mastery.feat(p, c.type, "step1000");
		c.state.startTimer("ambush", now + 40);
		if (c.awakened && !returning) {
			c.state.var("riftX", start.x);
			c.state.var("riftY", start.y);
			c.state.var("riftZ", start.z);
			c.state.startTimer("rift", now + 100);
			c.state.var("riftOpen", 1);
			Scheduler.later(1, () -> AbilityManager.setReadyAt(p, HeartType.VOID, 0, 0));
		}
		return true;
	}

	private Display.BlockDisplay core(ServerLevel level, Vec3 at, float scale) {
		Display.BlockDisplay d = Displays.block(level, at, Blocks.BLACK_CONCRETE.defaultBlockState(), scale, false);
		if (d != null) Displays.glow(d, PURPLE);
		return d;
	}

	private void spinCore(Display.BlockDisplay d, long t, float scale) {
		if (d == null) return;
		Quaternionf q = new Quaternionf().rotateXYZ(t * 0.13f, t * 0.21f, t * 0.07f);
		Vector3f half = new Vector3f(-scale / 2);
		q.transform(half);
		Displays.transform(d, half, q, new Vector3f(scale), 2);
	}

	private boolean riftOrb(Ctx c) {
		ServerPlayer p = c.player;
		ServerLevel level = c.level;
		int dur = c.ticks("a2.duration", 3.0);
		double pull = c.num("a2.pull", 0.12);
		float dmg = c.dmg("a2.damage", 2.0);
		Vec3[] pos = {c.eye().add(c.look().scale(1.5))};
		Vec3 vel = c.look().scale(0.45);
		Display.BlockDisplay d = core(level, pos[0], 0.5f);
		Set<UUID> pulled = new HashSet<>();
		Fx.sound(level, pos[0], SoundEvents.WARDEN_SONIC_CHARGE, 0.8f, 1.6f);
		Fx.custom(level, pos[0], "void_orb", 1f, 1f);
		Scheduler.repeat(0, 1, dur, i -> {
			Ctx cc = AbilityManager.ctx(p);
			Vec3 next = pos[0].add(vel);
			if (!level.getBlockState(net.minecraft.core.BlockPos.containing(next)).getCollisionShape(level, net.minecraft.core.BlockPos.containing(next)).isEmpty()) next = pos[0];
			pos[0] = next;
			if (d != null) {
				Displays.move(d, pos[0]);
				spinCore(d, i, 0.5f);
			}
			Fx.ring(level, Fx.dust(PURPLE, 1f), pos[0], 0.8, 10, i * 0.4);
			Fx.implode(level, ParticleTypes.PORTAL, pos[0], 2.5, 4, 1.0);
			if (cc != null) {
				for (LivingEntity e : cc.enemies(pos[0], 5)) {
					Vec3 to = pos[0].subtract(e.position().add(0, e.getBbHeight() / 2, 0));
					Ctx.push(e, to.normalize().scale(pull));
					pulled.add(e.getUUID());
					if (i % 10 == 0 && e.distanceToSqr(pos[0]) < 2.5 * 2.5) cc.hit(e, dmg);
				}
			}
			boolean last = i == dur - 1;
			if (last || cc == null) {
				if (d != null) d.discard();
				Fx.implode(level, Fx.dust(PINK, 1.5f), pos[0], 2.5, 40, 0.6);
				Fx.sound(level, pos[0], SoundEvents.ENDER_EYE_DEATH, 1f, 0.5f);
				if (pulled.size() >= 3) Mastery.feat(p, HeartType.VOID, "orb3");
				if (cc != null) {
					boolean collapse = cc.flag("void.collapse");
					double r = collapse ? 4.5 : 3;
					for (LivingEntity e : cc.enemies(pos[0], r)) {
						cc.hit(e, dmg * (collapse ? 4 : 2));
						if (collapse) Ctx.knockFrom(e, pos[0], 1.0, 0.6);
					}
					if (collapse) {
						Fx.far(level, ParticleTypes.SONIC_BOOM, pos[0], 1, 0, 0);
						Fx.sound(level, pos[0], SoundEvents.WARDEN_SONIC_BOOM, 0.8f, 1.3f);
					}
				}
				return false;
			}
			return true;
		});
		return true;
	}

	private boolean displace(Ctx c) {
		ServerPlayer p = c.player;
		LivingEntity target = c.aimEntity(c.num("a3.range", 20.0), 0.8);
		if (target == null) {
			Fx.actionBar(p, Component.literal("No target in sight.").withStyle(ChatFormatting.GRAY));
			return false;
		}
		Vec3 a = c.pos(), b = target.position();
		long now = c.level.getGameTime();
		swapTarget.put(p.getUUID(), target.getUUID().toString());
		c.state.startTimer("swap", now + 100);
		Fx.implode(c.level, ParticleTypes.PORTAL, a.add(0, 1, 0), 1.5, 30, 0.6);
		Fx.implode(c.level, ParticleTypes.PORTAL, b.add(0, 1, 0), 1.5, 30, 0.6);
		Fx.bolt(c.level, Fx.dust(PURPLE, 1.2f), a.add(0, 1, 0), b.add(0, 1, 0), 0.6);
		if (c.flag("void.oblivion")) {
			Ctx.setVelocity(target, new Vec3(0, 2.2, 0));
			Fx.pillar(c.level, ParticleTypes.REVERSE_PORTAL, b, 10, 40, 0.3);
			Fx.sound(c.level, b, SoundEvents.SHULKER_SHOOT, 1f, 0.5f);
		} else {
			float yawT = target.getYRot();
			target.teleportTo(c.level, a.x, a.y, a.z, Set.of(), yawT, target.getXRot(), false);
			p.teleportTo(c.level, b.x, b.y, b.z, Set.of(), p.getYRot(), p.getXRot(), false);
			p.fallDistance = 0;
		}
		c.control(target, MobEffects.DARKNESS, 60, 0);
		c.control(target, MobEffects.NAUSEA, 60, 0);
		if (target instanceof ServerPlayer) c.control(target, MobEffects.BLINDNESS, 20, 0);
		if (c.flag("void.unravel")) c.control(target, MobEffects.WEAKNESS, 80, 0);
		c.rewardHit(target);
		Fx.sound(c.level, a, SoundEvents.ENDERMAN_TELEPORT, 1f, 0.5f);
		Fx.sound(c.level, b, SoundEvents.ENDERMAN_TELEPORT, 1f, 0.5f);
		Fx.custom(c.level, b, "void_displace", 1f, 1f);
		return true;
	}

	private boolean singularity(Ctx c) {
		ServerPlayer p = c.player;
		ServerLevel level = c.level;
		Vec3 at = c.aimPoint(c.num("a4.range", 25.0)).subtract(c.look().scale(1)).add(0, 1.5, 0);
		int dur = c.ticks("a4.duration", 6.0);
		double r = c.num("a4.radius", 10.0);
		float dmg = c.dmg("a4.damage", 12.0);
		Display.BlockDisplay d = core(level, at, 0.3f);
		Set<UUID> caught = new HashSet<>();
		Fx.sound(level, at, SoundEvents.WARDEN_SONIC_CHARGE, 2f, 0.5f);
		Fx.sound(level, at, SoundEvents.BEACON_ACTIVATE, 1.5f, 0.5f);
		Fx.custom(level, at, "void_singularity", 2f, 1f);
		Fx.title(p, Component.empty(), Component.literal("The void opens").withStyle(c.type.style().withBold(true)), 2, 30, 10);
		Scheduler.repeat(0, 1, dur, i -> {
			Ctx cc = AbilityManager.ctx(p);
			float grow = 0.3f + 1.4f * Math.min(1, i / (float) dur);
			if (d != null) spinCore(d, i, grow);
			double ramp = 0.05 + 0.15 * (i / (double) dur);
			if (i % 2 == 0) {
				Fx.ring(level, Fx.dust(PURPLE, 1.3f), at, grow + 1.2, 24, i * 0.25);
				Fx.ring(level, Fx.dust(PINK, 1.0f), at.add(0, 0.1, 0), grow + 2.0, 30, -i * 0.18);
				Fx.ring(level, ParticleTypes.END_ROD, at, grow + 0.8, 8, i * 0.4);
				Fx.implode(level, ParticleTypes.PORTAL, at, r, 12, 1.5);
				Fx.implode(level, Fx.dust(BLACK, 2f), at, r * 0.6, 6, 0.6);
			}
			if (i % 20 == 0) Fx.sound(level, at, SoundEvents.PORTAL_AMBIENT, 1.5f, 0.5f + (float) i / dur);
			if (cc != null) {
				for (LivingEntity e : cc.enemies(at, r)) {
					Vec3 to = at.subtract(e.position().add(0, e.getBbHeight() / 2, 0));
					double dist = to.length();
					Ctx.push(e, to.normalize().scale(ramp * (1.2 - dist / r)));
					caught.add(e.getUUID());
					if (i % 10 == 0 && dist < 3) cc.hit(e, dmg * 0.1f);
				}
			}
			if (i == dur - 1) {
				if (d != null) d.discard();
				Fx.far(level, ParticleTypes.EXPLOSION_EMITTER, at, 2, 0.5, 0);
				Fx.far(level, ParticleTypes.SONIC_BOOM, at, 3, 0.8, 0);
				Fx.sphere(level, Fx.dust(PURPLE, 3f), at, 5, 150);
				Fx.shockRing(level, Fx.dust(PINK, 2f), at, 0.5, 60, 1.0);
				Fx.sound(level, at, SoundEvents.WARDEN_SONIC_BOOM, 2f, 0.6f);
				Fx.sound(level, at, SoundEvents.GENERIC_EXPLODE, 2f, 0.5f);
				Fx.custom(level, at, "void_collapse", 2f, 1f);
				if (cc != null) {
					for (LivingEntity e : cc.enemies(at, 5)) {
						cc.hit(e, dmg);
						Ctx.knockFrom(e, at, 1.6, 0.7);
					}
				}
				if (caught.size() >= 4) Mastery.feat(p, HeartType.VOID, "sing4");
				return false;
			}
			return true;
		});
		return true;
	}
}
