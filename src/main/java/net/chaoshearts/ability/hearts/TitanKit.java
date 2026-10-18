package net.chaoshearts.ability.hearts;

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
import net.minecraft.core.particles.ParticleTypes;
import net.minecraft.resources.Identifier;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.effect.MobEffects;
import net.minecraft.world.entity.Display;
import net.minecraft.world.entity.LivingEntity;
import net.minecraft.world.entity.ai.attributes.AttributeModifier;
import net.minecraft.world.entity.ai.attributes.Attributes;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.world.level.block.state.BlockState;
import net.minecraft.world.phys.Vec3;

/** Titan: shake the ground, turn to stone, throw boulders, and grow into a colossus. */
public final class TitanKit extends HeartKit {
	private static final int GOLD = 0xC9A45C, STONE = 0x7A746A, DARK = 0x3B352E;

	private final SkillTree tree;
	private final Identifier health = modifierId("health");
	private final Identifier kb = modifierId("knockback");
	private final Identifier scale = modifierId("colossus_scale");
	private final Identifier bigHealth = modifierId("colossus_health");
	private final Identifier reach = modifierId("colossus_reach");
	private final Identifier blockReach = modifierId("colossus_block_reach");
	private final Identifier strength = modifierId("colossus_damage");
	private final Identifier skinKb = modifierId("skin_kb");
	private final Identifier step = modifierId("colossus_step");

	public TitanKit() {
		super(HeartType.TITAN);
		ability(0, "Ground Slam", "Slam the earth and send a ripping shockwave forward.", 10, this::slam);
		ability(1, "Stone Skin", "Turn your skin to stone: Resistance II and unshakable footing.", 24, this::stoneSkin);
		ability(2, "Boulder Toss", "Tear a boulder out of the ground and hurl it.", 22, this::boulder);
		ability(3, "Colossus", "Grow to giant size. More health, more reach, every blow a shockwave.", 150, this::colossus);

		feat("slam3", "Fault Line", "Hit 3 enemies with one Ground Slam", 400);
		feat("catapult", "Catapult", "Hit an enemy with a boulder thrown from 20 or more blocks", 400);
		feat("immovable", "Immovable", "Shrug off 200 damage with Stone Skin", 500);
		feat("crush3", "Giant's Wrath", "Get 3 kills during one Colossus", 700);

		SkillTree t = new SkillTree("titan");
		t.branch("Earthshaker", "Break the ground", GOLD,
				t.node(0, "deep_tremor", "Deep Tremor", "+25% Ground Slam damage").mod("a1.damage", 0.25),
				t.node(1, "long_fault", "Long Fault", "+40% Ground Slam length").mod("a1.range", 0.4),
				t.node(2, "aftershock", "Aftershock", "Ground Slam erupts again a second later for half damage").flag("titan.aftershock"),
				t.node(3, "quake_step", "Quake Step", "As a Colossus, your footsteps damage nearby enemies").flag("titan.quake"),
				t.node(4, "tectonic", "Tectonic", "CAPSTONE: Ground Slam splits into three fault lines").flag("titan.fan"));
		t.branch("Bastion", "Be the wall", STONE,
				t.node(0, "granite", "Granite", "+1 more heart of maximum health").flag("titan.granite"),
				t.node(1, "long_skin", "Enduring Stone", "+40% Stone Skin duration").mod("a2.duration", 0.4),
				t.node(2, "spiked_stone", "Spiked Stone", "Attackers take 2 damage while Stone Skin is active").flag("titan.thorns"),
				t.node(3, "unshakable", "Unshakable", "Stone Skin no longer slows you").flag("titan.noslow"),
				t.node(4, "fortress", "Living Fortress", "CAPSTONE: Stone Skin also shields teammates near you").flag("titan.fortress"));
		t.branch("Juggernaut", "Throw mountains", DARK,
				t.node(0, "heavy_rock", "Heavy Rock", "+30% Boulder Toss damage").mod("a3.damage", 0.3),
				t.node(1, "bigger_rock", "Bigger Rock", "+40% Boulder blast radius").mod("a3.radius", 0.4),
				t.node(2, "towering", "Towering", "+30% Colossus duration").mod("a4.duration", 0.3),
				t.node(3, "titanic_reach", "Titanic Reach", "Colossus gives 1.5 more blocks of reach").flag("titan.reach"),
				t.node(4, "world_breaker", "World Breaker", "CAPSTONE: Boulder Toss throws three boulders").flag("titan.triple"));
		tree = t;
	}

	@Override public String passive1Name() { return "Mountain's Endurance"; }
	@Override public String passive1Description() { return "+2 hearts of maximum health and 30% knockback resistance."; }
	@Override public String passive2Name() { return "Bulwark"; }
	@Override public String passive2Description() { return "Take 10% less damage while below half health."; }
	@Override public String awakenedName() { return "Mountain"; }
	@Override public String awakenedDescription() { return "+1 more heart, and Colossus grows you to twice your size."; }
	@Override public SkillTree tree() { return tree; }

	@Override
	public void tick(Ctx c, long t) {
		ServerPlayer p = c.player;
		long now = c.level.getGameTime();
		if (t % 20 == 0) {
			double hp = 4 + (c.awakened ? 2 : 0) + (c.flag("titan.granite") ? 2 : 0);
			keepModifier(p, Attributes.MAX_HEALTH, health, hp, AttributeModifier.Operation.ADD_VALUE);
			keepModifier(p, Attributes.KNOCKBACK_RESISTANCE, kb, 0.3, AttributeModifier.Operation.ADD_VALUE);
		}
		boolean big = c.state.timer("colossus", now);
		if (big) {
			if (c.flag("titan.quake") && t % 10 == 0 && p.onGround() && p.getDeltaMovement().horizontalDistanceSqr() > 0.003) {
				Fx.shockRing(c.level, Fx.dust(STONE, 1.5f), c.pos().add(0, 0.1, 0), 0.5, 20, 0.2);
				KitUtil.debris(c.level, c.pos(), 1.2, 20);
				Fx.sound(c.level, c.pos(), SoundEvents.RAVAGER_STEP, 1.2f, 0.5f);
				for (LivingEntity e : c.enemies(c.pos(), 3)) c.hit(e, 1.5f);
			} else if (t % 12 == 0 && p.onGround() && p.getDeltaMovement().horizontalDistanceSqr() > 0.003) {
				KitUtil.debris(c.level, c.pos(), 0.8, 10);
				Fx.sound(c.level, c.pos(), SoundEvents.RAVAGER_STEP, 0.8f, 0.6f);
			}
		} else if (c.state.var("colossusActive") == 1) {
			endColossus(c);
		}
		if (c.state.timer("skin", now) && t % 4 == 0) {
			Fx.at(c.level, new net.minecraft.core.particles.BlockParticleOption(ParticleTypes.BLOCK, Blocks.STONE.defaultBlockState()), c.center(), 3, 0.35, 0.6, 0.35, 0);
		} else if (!c.state.timer("skin", now) && c.state.var("skinActive") == 1) {
			c.state.var("skinActive", 0);
			keepModifier(p, Attributes.KNOCKBACK_RESISTANCE, skinKb, 0, AttributeModifier.Operation.ADD_VALUE);
		}
	}

	@Override
	public void aura(Ctx c, long t) {
		if (c.player.getDeltaMovement().horizontalDistanceSqr() > 0.003 && c.player.onGround()) KitUtil.dustOfBlock(c.level, c.pos(), 0.3, 2);
		if (c.awakened) Fx.at(c.level, Fx.dust(GOLD, 1.0f), c.center(), 1, 0.4, 0.6, 0.4, 0);
	}

	@Override
	public float incoming(Ctx c, DamageSource s, float amount) {
		if (c.unlocked(Mastery.LVL_PASSIVE2) && c.player.getHealth() < c.player.getMaxHealth() / 2) amount *= 0.9f;
		if (c.state.timer("skin", c.level.getGameTime())) {
			// Resistance II does the reducing; we count what it saved.
			if (Mastery.counter(c.player, c.type, "skin_x10", Math.round(amount * 4)) >= 2000) Mastery.feat(c.player, c.type, "immovable");
		}
		return amount;
	}

	@Override
	public void afterHurt(Ctx c, DamageSource s, float amount) {
		if (c.flag("titan.thorns") && c.state.timer("skin", c.level.getGameTime()) && s.getEntity() instanceof LivingEntity le && le != c.player) {
			c.hit(le, 2);
			Fx.at(c.level, new net.minecraft.core.particles.BlockParticleOption(ParticleTypes.BLOCK, Blocks.POINTED_DRIPSTONE.defaultBlockState()), le.position().add(0, 1, 0), 10, 0.3, 0.1);
		}
	}

	@Override
	public void afterHit(Ctx c, LivingEntity target, float amount, boolean ability) {
		if (ability || !c.state.timer("colossus", c.level.getGameTime())) return;
		Vec3 at = target.position();
		Fx.shockRing(c.level, Fx.dust(GOLD, 1.6f), at.add(0, 0.2, 0), 0.4, 24, 0.25);
		KitUtil.debris(c.level, at, 1.0, 30);
		Fx.sound(c.level, at, SoundEvents.IRON_GOLEM_ATTACK, 1f, 0.6f);
		for (LivingEntity e : c.enemies(at, 2.5)) {
			if (e == target) continue;
			c.hit(e, c.dmg("a4.damage", 3.0));
			Ctx.knockFrom(e, at, 0.7, 0.3);
		}
	}

	@Override
	public void onKill(Ctx c, LivingEntity victim) {
		if (c.state.timer("colossus", c.level.getGameTime()) && c.state.addVar("colossusKills", 1) >= 3) Mastery.feat(c.player, c.type, "crush3");
	}

	@Override
	public String hud(Ctx c, long t) {
		long now = c.level.getGameTime();
		if (c.state.timer("colossus", now)) return "⛰ COLOSSUS " + (c.state.timerLeft("colossus", now) / 20 + 1) + "s";
		if (c.state.timer("skin", now)) return "Stone Skin " + (c.state.timerLeft("skin", now) / 20 + 1) + "s";
		return null;
	}

	@Override
	public void deactivate(ServerPlayer p) {
		super.deactivate(p);
		Ctx c = AbilityManager.ctx(p);
		if (c != null) {
			c.state.var("colossusActive", 0);
			c.state.var("skinActive", 0);
		}
	}

	// ---------------------------------------------------------------- abilities

	private void faultLine(Ctx c, Vec3 start, Vec3 dir, double len, float dmg, java.util.Set<java.util.UUID> hit) {
		ServerPlayer p = c.player;
		ServerLevel level = c.level;
		int steps = (int) Math.ceil(len);
		for (int i = 1; i <= steps; i++) {
			final int k = i;
			Scheduler.later(i, () -> {
				Ctx cc = AbilityManager.ctx(p);
				if (cc == null) return;
				Vec3 q = start.add(dir.scale(k));
				Vec3 g = KitUtil.groundBelow(level, q.add(0, 2, 0), 5);
				Vec3 spot = g == null ? q : g;
				KitUtil.debris(level, spot, 0.5, 25);
				KitUtil.dustOfBlock(level, spot, 0.4, 6);
				if (k % 2 == 0) Fx.at(level, ParticleTypes.EXPLOSION, spot.add(0, 0.3, 0), 1, 0, 0);
				// A slab of earth pops up for a moment.
				BlockState ground = KitUtil.ground(level, spot);
				Display.BlockDisplay d = Displays.block(level, spot.add(0, -0.5, 0), ground, 0.9f, false);
				if (d != null) {
					Displays.transform(d, new Vector3f(-0.45f, -0.2f, -0.45f), new Quaternionf().rotateXYZ(level.random.nextFloat() * 0.6f - 0.3f, 0, level.random.nextFloat() * 0.6f - 0.3f), new Vector3f(0.9f), 0);
					Scheduler.later(1, () -> Displays.transform(d, new Vector3f(-0.45f, 0.6f, -0.45f), new Quaternionf().rotateXYZ(0.3f, 0.2f, -0.2f), new Vector3f(0.9f), 3));
					Scheduler.later(10, () -> Displays.transform(d, new Vector3f(-0.45f, -0.6f, -0.45f), new Quaternionf(), new Vector3f(0.9f), 6));
					Scheduler.later(17, d::discard);
				}
				if (k % 2 == 1) Fx.sound(level, spot, SoundEvents.MACE_SMASH_GROUND, 0.8f, 0.6f + k * 0.03f);
				for (LivingEntity e : cc.enemies(spot.add(0, 0.8, 0), 1.6)) {
					if (hit.add(e.getUUID())) {
						cc.hit(e, dmg);
						Ctx.setVelocity(e, e.getDeltaMovement().add(dir.scale(0.3)).add(0, 0.75, 0));
					}
				}
			});
		}
	}

	private boolean slam(Ctx c) {
		Vec3 start = c.pos();
		double len = c.num("a1.range", 8.0);
		float dmg = c.dmg("a1.damage", 6.0);
		Fx.shockRing(c.level, Fx.dust(STONE, 2f), start.add(0, 0.1, 0), 0.4, 36, 0.3);
		KitUtil.debris(c.level, start, 1.0, 40);
		Fx.sound(c.level, start, SoundEvents.MACE_SMASH_GROUND_HEAVY, 1.2f, 0.6f);
		Fx.sound(c.level, start, SoundEvents.IRON_GOLEM_ATTACK, 1f, 0.5f);
		Fx.custom(c.level, start, "titan_slam", 1.3f, 1f);
		java.util.Set<java.util.UUID> hit = new java.util.HashSet<>();
		Vec3 dir = c.flatLook();
		faultLine(c, start, dir, len, dmg, hit);
		if (c.flag("titan.fan")) {
			faultLine(c, start, KitUtil.rotateY(dir, Math.toRadians(30)), len * 0.8, dmg * 0.8f, hit);
			faultLine(c, start, KitUtil.rotateY(dir, Math.toRadians(-30)), len * 0.8, dmg * 0.8f, hit);
		}
		ServerPlayer p = c.player;
		Scheduler.later((int) len + 2, () -> {
			if (hit.size() >= 3) Mastery.feat(p, HeartType.TITAN, "slam3");
		});
		if (c.flag("titan.aftershock")) {
			Scheduler.later(20, () -> {
				Ctx cc = AbilityManager.ctx(p);
				if (cc != null) faultLine(cc, start, dir, len, dmg * 0.5f, new java.util.HashSet<>());
			});
		}
		return true;
	}

	private boolean stoneSkin(Ctx c) {
		long now = c.level.getGameTime();
		int dur = c.ticks("a2.duration", 5.0);
		ServerPlayer p = c.player;
		Combat.buff(p, MobEffects.RESISTANCE, dur, 1);
		if (!c.flag("titan.noslow")) Combat.buff(p, MobEffects.SLOWNESS, dur, 0);
		keepModifier(p, Attributes.KNOCKBACK_RESISTANCE, skinKb, 1.0, AttributeModifier.Operation.ADD_VALUE);
		c.state.startTimer("skin", now + dur);
		c.state.var("skinActive", 1);
		if (c.flag("titan.fortress")) for (LivingEntity a : c.allies(c.pos(), 6)) if (a != p) Combat.buff(a, MobEffects.RESISTANCE, dur, 0);
		Fx.sphere(c.level, new net.minecraft.core.particles.BlockParticleOption(ParticleTypes.BLOCK, Blocks.STONE.defaultBlockState()), c.center(), 1.2, 60);
		Fx.sphere(c.level, Fx.dust(GOLD, 1.2f), c.center(), 1.3, 40);
		Fx.sound(c.level, c.pos(), SoundEvents.STONE_PLACE, 1.2f, 0.5f);
		Fx.sound(c.level, c.pos(), SoundEvents.ANVIL_USE, 0.6f, 0.6f);
		Fx.custom(c.level, c.pos(), "titan_stoneskin", 1f, 1f);
		return true;
	}

	private void throwBoulder(Ctx c, Vec3 dir, float dmg, double radius, BlockState rock) {
		ServerPlayer p = c.player;
		ServerLevel level = c.level;
		Vec3 from = c.pos().add(0, c.player.getBbHeight() + 1.0, 0);
		SimProjectile pr = new SimProjectile(level, from, dir.normalize().scale(1.3).add(0, 0.25, 0));
		pr.owner = p;
		pr.gravity = 0.045;
		pr.radius = 0.8;
		pr.maxTicks = 80;
		Display.BlockDisplay d = Displays.block(level, from, rock, 1.4f, false);
		pr.display = d;
		Vec3 origin = c.pos();
		pr.canHit(e -> Combat.canTarget(p, e));
		pr.onTick(s -> {
			if (d != null) {
				Quaternionf q = new Quaternionf().rotateXYZ(s.age() * 0.3f, s.age() * 0.2f, 0);
				Vector3f half = new Vector3f(-0.7f);
				q.transform(half);
				Displays.transform(d, half.add(0, 0.25f, 0), q, new Vector3f(1.4f), 1);
			}
			if (s.age() % 2 == 0) Fx.at(level, new net.minecraft.core.particles.BlockParticleOption(ParticleTypes.BLOCK, rock), s.pos, 2, 0.3, 0);
		});
		pr.onEnd((s, at) -> {
			Ctx cc = AbilityManager.ctx(p);
			Fx.at(level, ParticleTypes.EXPLOSION, at, 2, 0.5, 0);
			level.sendParticles(new net.minecraft.core.particles.BlockParticleOption(ParticleTypes.BLOCK, rock), at.x, at.y + 0.3, at.z, 80, radius * 0.4, 0.3, radius * 0.4, 0.3);
			KitUtil.dustOfBlock(level, at, radius * 0.5, 20);
			Fx.sound(level, at, SoundEvents.GENERIC_EXPLODE, 1f, 0.7f);
			Fx.sound(level, at, SoundEvents.STONE_BREAK, 1.5f, 0.5f);
			Fx.custom(level, at, "titan_boulder", 1.3f, 1f);
			if (cc == null) return;
			for (LivingEntity e : cc.enemies(at, radius)) {
				if (cc.hit(e, dmg) && origin.distanceTo(at) >= 20) Mastery.feat(p, HeartType.TITAN, "catapult");
				Ctx.knockFrom(e, at, 0.9, 0.45);
			}
		});
		pr.onEntity((s, e) -> s.stop());
		pr.launch();
	}

	private boolean boulder(Ctx c) {
		ServerPlayer p = c.player;
		ServerLevel level = c.level;
		BlockState rock = KitUtil.ground(level, c.pos());
		if (!rock.isSolidRender()) rock = Blocks.COBBLESTONE.defaultBlockState();
		final BlockState rockF = rock;
		float dmg = c.dmg("a3.damage", 8.0);
		double radius = c.num("a3.radius", 3.0);
		KitUtil.debris(level, c.pos(), 0.8, 40);
		Fx.sound(level, c.pos(), SoundEvents.STONE_BREAK, 1.5f, 0.5f);
		Fx.sound(level, c.pos(), SoundEvents.RAVAGER_ATTACK, 0.6f, 0.6f);
		// The rock is wrenched up first, then thrown.
		Display.BlockDisplay lift = Displays.block(level, c.pos().add(0, -0.5, 0), rock, 1.4f, false);
		if (lift != null) {
			Displays.teleportDuration(lift, 6);
			Scheduler.later(1, () -> Displays.move(lift, p.position().add(0, p.getBbHeight() + 1.0, 0)));
		}
		Scheduler.later(8, () -> {
			if (lift != null) lift.discard();
			Ctx cc = AbilityManager.ctx(p);
			if (cc == null || cc.type != HeartType.TITAN) return;
			Fx.sound(level, cc.pos(), SoundEvents.PLAYER_ATTACK_KNOCKBACK, 1f, 0.5f);
			if (cc.flag("titan.triple")) {
				for (int i = -1; i <= 1; i++) throwBoulder(cc, KitUtil.rotateY(cc.look(), Math.toRadians(i * 12)), dmg, radius, rockF);
			} else {
				throwBoulder(cc, cc.look(), dmg, radius, rockF);
			}
		});
		return true;
	}

	private boolean colossus(Ctx c) {
		ServerPlayer p = c.player;
		long now = c.level.getGameTime();
		int dur = c.ticks("a4.duration", 12.0);
		c.state.startTimer("colossus", now + dur);
		c.state.var("colossusActive", 1);
		c.state.var("colossusKills", 0);
		double grow = c.awakened ? 1.0 : 0.6;
		keepModifier(p, Attributes.SCALE, scale, grow, AttributeModifier.Operation.ADD_MULTIPLIED_BASE);
		keepModifier(p, Attributes.MAX_HEALTH, bigHealth, 10, AttributeModifier.Operation.ADD_VALUE);
		double r = 1.5 + (c.flag("titan.reach") ? 1.5 : 0);
		keepModifier(p, Attributes.ENTITY_INTERACTION_RANGE, reach, r, AttributeModifier.Operation.ADD_VALUE);
		keepModifier(p, Attributes.BLOCK_INTERACTION_RANGE, blockReach, r, AttributeModifier.Operation.ADD_VALUE);
		keepModifier(p, Attributes.ATTACK_DAMAGE, strength, 3, AttributeModifier.Operation.ADD_VALUE);
		keepModifier(p, Attributes.STEP_HEIGHT, step, 1.0, AttributeModifier.Operation.ADD_VALUE);
		p.heal(10);
		Fx.far(c.level, ParticleTypes.EXPLOSION_EMITTER, c.pos().add(0, 1, 0), 1, 0, 0);
		Fx.shockRing(c.level, Fx.dust(GOLD, 2.5f), c.pos().add(0, 0.2, 0), 0.5, 60, 0.6);
		KitUtil.debris(c.level, c.pos(), 2.0, 120);
		Fx.sound(c.level, c.pos(), SoundEvents.IRON_GOLEM_REPAIR, 1.5f, 0.5f);
		Fx.sound(c.level, c.pos(), SoundEvents.RAVAGER_ROAR, 1.2f, 0.5f);
		Fx.custom(c.level, c.pos(), "titan_colossus", 2f, 1f);
		Fx.title(p, net.minecraft.network.chat.Component.empty(), net.minecraft.network.chat.Component.literal("⛰ COLOSSUS").withStyle(c.type.style().withBold(true)), 2, 30, 10);
		for (LivingEntity e : c.enemies(c.pos(), 5)) Ctx.knockFrom(e, c.pos(), 1.0, 0.4);
		return true;
	}

	private void endColossus(Ctx c) {
		ServerPlayer p = c.player;
		c.state.var("colossusActive", 0);
		keepModifier(p, Attributes.SCALE, scale, 0, AttributeModifier.Operation.ADD_MULTIPLIED_BASE);
		keepModifier(p, Attributes.MAX_HEALTH, bigHealth, 0, AttributeModifier.Operation.ADD_VALUE);
		keepModifier(p, Attributes.ENTITY_INTERACTION_RANGE, reach, 0, AttributeModifier.Operation.ADD_VALUE);
		keepModifier(p, Attributes.BLOCK_INTERACTION_RANGE, blockReach, 0, AttributeModifier.Operation.ADD_VALUE);
		keepModifier(p, Attributes.ATTACK_DAMAGE, strength, 0, AttributeModifier.Operation.ADD_VALUE);
		keepModifier(p, Attributes.STEP_HEIGHT, step, 0, AttributeModifier.Operation.ADD_VALUE);
		if (p.getHealth() > p.getMaxHealth()) p.setHealth(p.getMaxHealth());
		Fx.at(c.level, ParticleTypes.CLOUD, c.center(), 30, 0.6, 0.05);
		Fx.sound(c.level, c.pos(), SoundEvents.IRON_GOLEM_DEATH, 0.6f, 1.2f);
	}
}
