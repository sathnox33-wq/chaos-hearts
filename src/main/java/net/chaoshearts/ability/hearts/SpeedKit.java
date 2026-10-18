package net.chaoshearts.ability.hearts;

import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import com.mojang.datafixers.util.Pair;

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
import net.minecraft.network.protocol.game.ClientboundSetEquipmentPacket;
import net.minecraft.resources.Identifier;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.effect.MobEffects;
import net.minecraft.world.entity.EntitySpawnReason;
import net.minecraft.world.entity.EntityType;
import net.minecraft.world.entity.EquipmentSlot;
import net.minecraft.world.entity.LivingEntity;
import net.minecraft.world.entity.Mob;
import net.minecraft.world.entity.ai.attributes.AttributeModifier;
import net.minecraft.world.entity.ai.attributes.Attributes;
import net.minecraft.world.entity.decoration.ArmorStand;
import net.minecraft.world.entity.projectile.Projectile;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.phys.AABB;
import net.minecraft.world.phys.Vec3;

/** Speed: blink, vanish, outrun, and stop time itself. */
public final class SpeedKit extends HeartKit {
	private static final int GOLD = 0xF5E142, CYAN = 0x29D3F2, WHITE = 0xFFFFFF;

	private final SkillTree tree;
	private final Identifier swift = modifierId("swift");
	private final Map<UUID, Deque<Vec3>> trails = new HashMap<>();

	public SpeedKit() {
		super(HeartType.SPEED);
		ability(0, "Dash", "Blink forward, cutting through every enemy in your path.", 6, this::dash);
		ability(1, "Afterimage", "Leave a decoy behind and vanish completely, armour and all.", 20, this::afterimage);
		ability(2, "Slipstream", "Surge to Speed III. Your wake slows enemies that cross it.", 30, this::slipstream);
		ability(3, "Time Fracture", "Freeze time around you. Enemies and projectiles crawl; you do not.", 120, this::fracture);

		feat("dash_kill", "Blink Strike", "Kill an enemy within 3 seconds of a Dash", 400);
		feat("slip2000", "Afterburner", "Travel 2,000 blocks inside Slipstream", 500);
		feat("fracture3", "Stopped Clock", "Catch 3 enemies in one Time Fracture", 500);
		feat("momentum25", "Unstoppable Force", "Land 25 Momentum strikes", 300);

		SkillTree t = new SkillTree("speed");
		t.branch("Blitz", "Cut through them", GOLD,
				t.node(0, "sharpened_wind", "Sharpened Wind", "+25% Dash damage").mod("a1.damage", 0.25),
				t.node(1, "long_stride", "Long Stride", "+30% Dash distance").mod("a1.range", 0.3),
				t.node(2, "follow_through", "Follow-Through", "Hitting an enemy with Dash refunds 30% of its cooldown").flag("speed.refund"),
				t.node(3, "overload", "Momentum Overload", "+60% Momentum strike damage").mod("p.momentum", 0.6),
				t.node(4, "thousand_cuts", "Thousand Cuts", "CAPSTONE: Dash leaves slashes along its path that strike again half a second later").flag("speed.cuts"));
		t.branch("Phantom", "Never be where they aim", 0xB0B8FF,
				t.node(0, "lingering_shade", "Lingering Shade", "+40% Afterimage invisibility").mod("a2.duration", 0.4),
				t.node(1, "decoy_burst", "Decoy Burst", "The decoy bursts when it fades, slowing nearby enemies").flag("speed.decoy_burst"),
				t.node(2, "slippery", "Slippery", "Take 10% less damage while sprinting").flag("speed.slippery"),
				t.node(3, "ghost_step", "Ghost Step", "Afterimage recharges 25% faster").mod("a2.cooldown", -0.25),
				t.node(4, "phase_runner", "Phase Runner", "CAPSTONE: during Slipstream a quarter of attacks against you miss").flag("speed.phase"));
		t.branch("Chronomancer", "Own the clock", CYAN,
				t.node(0, "wider_wake", "Wider Wake", "+40% Slipstream wake width").mod("a3.width", 0.4),
				t.node(1, "tailwind", "Tailwind", "Slipstream gives teammates Speed II").flag("speed.tailwind"),
				t.node(2, "extended_moment", "Extended Moment", "+30% Time Fracture duration").mod("a4.duration", 0.3),
				t.node(3, "broken_clock", "Broken Clock", "+25% Time Fracture radius").mod("a4.radius", 0.25),
				t.node(4, "rewind", "Rewind", "CAPSTONE: when Time Fracture ends you snap back to where you cast it and recover the health you lost").flag("speed.rewind"));
		tree = t;
	}

	@Override public String passive1Name() { return "Swift"; }
	@Override public String passive1Description() { return "You move 15% faster at all times."; }
	@Override public String passive2Name() { return "Momentum"; }
	@Override public String passive2Description() { return "Sprint for 3 seconds to charge your next melee hit with +4 damage and heavy knockback."; }
	@Override public String awakenedName() { return "Lightspeed"; }
	@Override public String awakenedDescription() { return "Dash recharges twice as fast and sprinting leaves a crackling electric trail."; }
	@Override public SkillTree tree() { return tree; }

	@Override
	public void tick(Ctx c, long t) {
		ServerPlayer p = c.player;
		long now = c.level.getGameTime();
		if (t % 20 == 0) keepModifier(p, Attributes.MOVEMENT_SPEED, swift, 0.15, AttributeModifier.Operation.ADD_MULTIPLIED_TOTAL);

		// Momentum
		if (c.unlocked(Mastery.LVL_PASSIVE2)) {
			if (p.isSprinting()) {
				double s = c.state.addVar("sprint", 1);
				if (s == 60) {
					Fx.soundTo(p, SoundEvents.NOTE_BLOCK_CHIME.value(), 0.6f, 2f);
					Fx.at(c.level, Fx.dust(GOLD, 1.2f), c.center(), 10, 0.3, 0);
				}
				if (s >= 60 && t % 2 == 0) Fx.at(c.level, ParticleTypes.ELECTRIC_SPARK, c.center(), 2, 0.25, 0.05);
			} else if (c.state.var("sprint") < 60) {
				c.state.var("sprint", 0);
			}
		}
		// Lightspeed trail
		if (c.awakened && p.isSprinting() && t % 2 == 0) {
			Fx.at(c.level, ParticleTypes.ELECTRIC_SPARK, c.pos().add(0, 0.2, 0), 2, 0.2, 0.02);
			Fx.at(c.level, Fx.dust(CYAN, 0.9f), c.pos().add(0, 0.5, 0), 1, 0.1, 0);
		}

		// Slipstream wake
		if (c.state.timer("slip", now)) {
			Deque<Vec3> trail = trails.computeIfAbsent(p.getUUID(), u -> new ArrayDeque<>());
			Vec3 last = trail.peekLast();
			Vec3 here = c.pos();
			if (last != null && last.distanceTo(here) < 8) {
				double moved = Mastery.counter(p, c.type, "slip_cm", Math.round(last.distanceTo(here) * 100));
				if (moved >= 200_000) Mastery.feat(p, c.type, "slip2000");
			}
			trail.addLast(here);
			while (trail.size() > 50) trail.removeFirst();
			if (t % 2 == 0) {
				Fx.at(c.level, Fx.dust(GOLD, CYAN, 1.3f), here.add(0, 0.15, 0), 3, 0.25, 0);
				Fx.at(c.level, ParticleTypes.CLOUD, here.add(0, 0.1, 0), 1, 0.1, 0.01);
			}
			if (t % 5 == 0) {
				double w = c.num("a3.width", 1.3);
				Set<UUID> slowed = new java.util.HashSet<>();
				int i = 0;
				for (Vec3 pt : trail) {
					if (i++ % 3 != 0) continue;
					for (LivingEntity e : c.enemies(pt, w)) {
						if (slowed.add(e.getUUID())) {
							c.control(e, MobEffects.SLOWNESS, 25, 1);
							Fx.at(c.level, ParticleTypes.REVERSE_PORTAL, e.position().add(0, 1, 0), 4, 0.3, 0.02);
						}
					}
				}
				if (c.flag("speed.tailwind")) for (LivingEntity a : c.allies(here, 6)) if (a != p) Combat.buff(a, MobEffects.SPEED, 30, 1);
			}
		} else {
			trails.remove(p.getUUID());
		}

		// Time Fracture
		if (c.state.timer("fracture", now)) fractureTick(c, t);
		else if (c.state.var("fractureActive") == 1) endFracture(c);

		// Afterimage
		if (c.state.var("vanished") == 1 && !c.state.timer("vanish", now)) reveal(c);
	}

	@Override
	public void aura(Ctx c, long t) {
		if (c.player.getDeltaMovement().horizontalDistanceSqr() > 0.01) Fx.at(c.level, Fx.dust(GOLD, 0.7f), c.pos().add(0, 0.3, 0), 1, 0.2, 0);
		if (c.awakened) Fx.at(c.level, ParticleTypes.ELECTRIC_SPARK, c.center(), 1, 0.3, 0.02);
	}

	@Override
	public float outgoing(Ctx c, LivingEntity target, DamageSource s, float amount) {
		if (KitUtil.melee(c, s) && c.state.var("sprint") >= 60 && c.unlocked(Mastery.LVL_PASSIVE2)) {
			c.state.var("sprint", 0);
			float bonus = (float) (c.num("p.momentum", 4.0));
			Vec3 at = target.position().add(0, target.getBbHeight() / 2, 0);
			Fx.flash(c.level, at);
			Fx.at(c.level, ParticleTypes.ELECTRIC_SPARK, at, 25, 0.3, 0.6);
			Fx.sound(c.level, at, SoundEvents.TRIDENT_RIPTIDE_1.value(), 0.8f, 1.4f);
			Fx.custom(c.level, at, "speed_momentum", 1f, 1f);
			Ctx.knockFrom(target, c.pos(), 1.2, 0.35);
			if (Mastery.counter(c.player, c.type, "momentum_hits", 1) >= 25) Mastery.feat(c.player, c.type, "momentum25");
			return amount + bonus;
		}
		return amount;
	}

	@Override
	public float incoming(Ctx c, DamageSource s, float amount) {
		long now = c.level.getGameTime();
		if (c.flag("speed.phase") && c.state.timer("slip", now) && !KitUtil.fall(s) && c.level.random.nextFloat() < 0.25f) {
			Fx.at(c.level, Fx.dust(CYAN, 1.2f), c.center(), 12, 0.4, 0);
			Fx.soundTo(c.player, SoundEvents.ENDERMAN_TELEPORT, 0.4f, 2f);
			return 0;
		}
		if (c.flag("speed.slippery") && c.player.isSprinting()) amount *= 0.9f;
		return amount;
	}

	@Override
	public void afterHit(Ctx c, LivingEntity target, float amount, boolean ability) {
		if (!ability && c.state.var("vanished") == 1) reveal(c);
	}

	@Override
	public void onKill(Ctx c, LivingEntity victim) {
		if (c.state.timer("dashed", c.level.getGameTime())) Mastery.feat(c.player, c.type, "dash_kill");
	}

	@Override
	public String hud(Ctx c, long t) {
		long now = c.level.getGameTime();
		if (c.state.timer("fracture", now)) return "⌛ TIME FRACTURE " + (c.state.timerLeft("fracture", now) / 20 + 1) + "s";
		if (c.state.timer("slip", now)) return "Slipstream " + (c.state.timerLeft("slip", now) / 20 + 1) + "s";
		if (c.state.var("sprint") >= 60) return "⚡ Momentum";
		return null;
	}

	@Override
	public void deactivate(ServerPlayer p) {
		super.deactivate(p);
		trails.remove(p.getUUID());
		Ctx c = AbilityManager.ctx(p);
		if (c != null && c.state.var("vanished") == 1) reveal(c);
	}

	// ---------------------------------------------------------------- abilities

	private boolean dash(Ctx c) {
		ServerPlayer p = c.player;
		double range = c.num("a1.range", 8.0);
		Vec3 dir = c.look();
		if (p.onGround() && dir.y < 0) dir = new Vec3(dir.x, 0, dir.z).normalize();
		Vec3 start = c.pos();
		Vec3 end = start;
		for (double d = 0.5; d <= range; d += 0.5) {
			Vec3 q = start.add(dir.scale(d));
			if (!KitUtil.safeSpot(c.level, q)) break;
			end = q;
		}
		if (end.distanceTo(start) < 1.0) {
			Fx.actionBar(p, net.minecraft.network.chat.Component.literal("No room to dash.").withStyle(net.minecraft.ChatFormatting.GRAY));
			return false;
		}
		long now = c.level.getGameTime();
		c.state.startTimer("dashed", now + 60);
		// Afterimage at the start
		Fx.at(c.level, ParticleTypes.CLOUD, start.add(0, 1, 0), 12, 0.3, 0.6, 0.3, 0.02);
		Fx.at(c.level, Fx.dust(GOLD, 1.6f), start.add(0, 1, 0), 20, 0.25, 0.7, 0.25, 0);
		p.teleportTo(c.level, end.x, end.y, end.z, Set.of(), p.getYRot(), p.getXRot(), false);
		Ctx.setVelocity(p, dir.scale(0.5));
		p.fallDistance = 0;
		Fx.line(c.level, Fx.dust(GOLD, 1.3f), start.add(0, 1, 0), end.add(0, 1, 0), 0.3);
		Fx.line(c.level, ParticleTypes.END_ROD, start.add(0, 0.6, 0), end.add(0, 0.6, 0), 0.8);
		if (c.awakened) Fx.bolt(c.level, ParticleTypes.ELECTRIC_SPARK, start.add(0, 1.2, 0), end.add(0, 1.2, 0), 0.4);
		Fx.sound(c.level, start, SoundEvents.BREEZE_WIND_CHARGE_BURST.value(), 0.7f, 1.6f);
		Fx.sound(c.level, end, SoundEvents.ENDERMAN_TELEPORT, 0.4f, 2f);
		Fx.custom(c.level, end, "speed_dash", 1f, 1f);

		float dmg = c.dmg("a1.damage", 4.0);
		AABB box = new AABB(start, end).inflate(1.2);
		List<LivingEntity> victims = new ArrayList<>();
		for (LivingEntity e : c.level.getEntitiesOfClass(LivingEntity.class, box, e -> Combat.canTarget(p, e))) {
			if (e.getBoundingBox().inflate(0.9).clip(start.add(0, 0.9, 0), end.add(0, 0.9, 0)).isPresent()) victims.add(e);
		}
		boolean any = false;
		for (LivingEntity e : victims) {
			if (c.hit(e, dmg)) any = true;
			Fx.at(c.level, ParticleTypes.SWEEP_ATTACK, e.position().add(0, 1, 0), 1, 0, 0);
		}
		if (any) Fx.sound(c.level, end, SoundEvents.PLAYER_ATTACK_SWEEP, 1f, 1.5f);
		if (any && c.flag("speed.refund")) Scheduler.later(1, () -> AbilityManager.reduceCooldown(p, c.type, 0, c.num("a1.cooldown", 6) * 0.3));
		if (c.awakened) Scheduler.later(1, () -> AbilityManager.reduceCooldown(p, c.type, 0, c.num("a1.cooldown", 6) * 0.5));
		if (c.flag("speed.cuts")) {
			Vec3 s0 = start, e0 = end;
			Scheduler.later(10, () -> {
				Ctx cc = AbilityManager.ctx(p);
				if (cc == null || cc.type != HeartType.SPEED) return;
				for (int i = 0; i < 3; i++) {
					Vec3 q = s0.lerp(e0, (i + 0.5) / 3.0).add(0, 1, 0);
					Fx.at(cc.level, ParticleTypes.SWEEP_ATTACK, q, 2, 0.4, 0);
					Fx.sound(cc.level, q, SoundEvents.PLAYER_ATTACK_SWEEP, 0.6f, 1.8f);
					for (LivingEntity e : cc.enemies(q, 1.6)) cc.hit(e, dmg * 0.5f);
				}
			});
		}
		return true;
	}

	private boolean afterimage(Ctx c) {
		ServerPlayer p = c.player;
		ServerLevel level = c.level;
		long now = level.getGameTime();
		int dur = c.ticks("a2.duration", 3.0);
		ArmorStand decoy = EntityType.ARMOR_STAND.create(level, EntitySpawnReason.COMMAND);
		if (decoy != null) {
			decoy.snapTo(p.getX(), p.getY(), p.getZ(), p.getYRot(), 0);
			decoy.setShowArms(true);
			decoy.setNoBasePlate(true);
			decoy.setInvulnerable(true);
			decoy.addTag("chaoshearts.decoy." + p.getUUID());
			net.chaoshearts.fx.Displays.track(decoy);
			for (EquipmentSlot slot : new EquipmentSlot[] {EquipmentSlot.HEAD, EquipmentSlot.CHEST, EquipmentSlot.LEGS, EquipmentSlot.FEET, EquipmentSlot.MAINHAND}) {
				decoy.setItemSlot(slot, p.getItemBySlot(slot).copy());
			}
			if (decoy.getItemBySlot(EquipmentSlot.HEAD).isEmpty()) decoy.setItemSlot(EquipmentSlot.HEAD, playerHead(p));
			decoy.setCustomName(p.getDisplayName());
			decoy.setCustomNameVisible(true);
			level.addFreshEntity(decoy);
			int life = dur + 20;
			Scheduler.repeat(0, 2, life / 2, i -> {
				if (!decoy.isAlive()) return false;
				Fx.at(level, Fx.dust(GOLD, CYAN, 0.9f), decoy.position().add(0, 1, 0), 2, 0.3, 0.6, 0.3, 0);
				if (i == life / 2 - 1) {
					Fx.at(level, ParticleTypes.CLOUD, decoy.position().add(0, 1, 0), 20, 0.3, 0.6, 0.3, 0.05);
					Fx.sound(level, decoy.position(), SoundEvents.ILLUSIONER_MIRROR_MOVE, 0.8f, 1.2f);
					if (c.flag("speed.decoy_burst")) {
						Ctx cc = AbilityManager.ctx(p);
						if (cc != null) for (LivingEntity e : cc.enemies(decoy.position(), 4)) {
							cc.control(e, MobEffects.SLOWNESS, 60, 1);
							cc.rewardHit(e);
						}
						Fx.shockRing(level, Fx.dust(CYAN, 1.5f), decoy.position().add(0, 0.5, 0), 0.4, 30, 0.3);
					}
					decoy.discard();
					return false;
				}
				return true;
			});
		}
		// Mobs lose track of you.
		for (Mob m : level.getEntitiesOfClass(Mob.class, p.getBoundingBox().inflate(24), m -> m.getTarget() == p)) m.setTarget(null);
		Combat.buff(p, MobEffects.INVISIBILITY, dur, 0);
		Combat.buff(p, MobEffects.SPEED, dur, 1);
		c.state.startTimer("vanish", now + dur);
		c.state.var("vanished", 1);
		hideEquipment(p, true);
		Fx.at(level, ParticleTypes.CLOUD, c.center(), 25, 0.4, 0.05);
		Fx.flash(level, c.center());
		Fx.sound(level, c.pos(), SoundEvents.ILLUSIONER_CAST_SPELL, 0.9f, 1.5f);
		Fx.custom(level, c.pos(), "speed_afterimage", 1f, 1f);
		return true;
	}

	private static ItemStack playerHead(ServerPlayer p) {
		ItemStack head = new ItemStack(net.minecraft.world.item.Items.PLAYER_HEAD);
		head.set(net.minecraft.core.component.DataComponents.PROFILE, net.minecraft.world.item.component.ResolvableProfile.createResolved(p.getGameProfile()));
		return head;
	}

	private void reveal(Ctx c) {
		c.state.var("vanished", 0);
		c.state.stopTimer("vanish");
		c.player.removeEffect(MobEffects.INVISIBILITY);
		hideEquipment(c.player, false);
		Fx.at(c.level, Fx.dust(GOLD, 1.2f), c.center(), 15, 0.3, 0);
	}

	/** True invisibility: other players are told this player wears nothing. */
	private static void hideEquipment(ServerPlayer p, boolean hide) {
		List<Pair<EquipmentSlot, ItemStack>> list = new ArrayList<>();
		for (EquipmentSlot slot : EquipmentSlot.values()) {
			if (slot.getType() == EquipmentSlot.Type.ANIMAL_ARMOR || slot == EquipmentSlot.SADDLE) continue;
			list.add(Pair.of(slot, hide ? ItemStack.EMPTY : p.getItemBySlot(slot).copy()));
		}
		((ServerLevel) p.level()).getChunkSource().sendToTrackingPlayers(p, new ClientboundSetEquipmentPacket(p.getId(), list));
	}

	private boolean slipstream(Ctx c) {
		long now = c.level.getGameTime();
		int dur = c.ticks("a3.duration", 6.0);
		c.state.startTimer("slip", now + dur);
		Combat.buff(c.player, MobEffects.SPEED, dur, 2);
		Combat.buff(c.player, MobEffects.HASTE, dur, 1);
		trails.remove(c.player.getUUID());
		Fx.shockRing(c.level, Fx.dust(GOLD, 1.5f), c.pos().add(0, 0.2, 0), 0.3, 36, 0.4);
		Fx.at(c.level, ParticleTypes.GUST_EMITTER_SMALL, c.pos(), 1, 0, 0);
		Fx.sound(c.level, c.pos(), SoundEvents.BREEZE_CHARGE, 1f, 1.5f);
		Fx.sound(c.level, c.pos(), SoundEvents.TRIDENT_RIPTIDE_3.value(), 0.6f, 1.6f);
		Fx.custom(c.level, c.pos(), "speed_slipstream", 1f, 1f);
		return true;
	}

	private boolean fracture(Ctx c) {
		long now = c.level.getGameTime();
		int dur = c.ticks("a4.duration", 6.0);
		c.state.startTimer("fracture", now + dur);
		c.state.var("fractureActive", 1);
		c.state.var("fx", c.player.getX());
		c.state.var("fy", c.player.getY());
		c.state.var("fz", c.player.getZ());
		c.state.var("fHealth", c.player.getHealth());
		c.state.var("fCaught", 0);
		Combat.buff(c.player, MobEffects.SPEED, dur, 1);
		Combat.buff(c.player, MobEffects.HASTE, dur, 2);
		Fx.flash(c.level, c.center());
		Fx.sphere(c.level, Fx.dust(CYAN, 2f), c.center(), c.num("a4.radius", 12.0) * 0.5, 120);
		Fx.sound(c.level, c.pos(), SoundEvents.BELL_RESONATE, 1.5f, 0.5f);
		Fx.sound(c.level, c.pos(), SoundEvents.BEACON_DEACTIVATE, 1f, 0.5f);
		Fx.custom(c.level, c.pos(), "speed_timefracture", 1.5f, 1f);
		Fx.title(c.player, net.minecraft.network.chat.Component.empty(), net.minecraft.network.chat.Component.literal("⌛ Time stands still").withStyle(c.type.style().withBold(true)), 2, 30, 10);
		return true;
	}

	private void fractureTick(Ctx c, long t) {
		Vec3 center = new Vec3(c.state.var("fx"), c.state.var("fy"), c.state.var("fz"));
		double r = c.num("a4.radius", 12.0);
		if (t % 2 == 0) {
			double a = t * 0.05;
			Fx.ring(c.level, Fx.dust(CYAN, 1.2f), center.add(0, 0.1, 0), r, (int) (r * 5), a);
			Fx.ring(c.level, Fx.dust(GOLD, 1.0f), center.add(0, 0.12, 0), r * 0.92, 12, -a * 2);
			// Clock hands
			Vec3 minute = new Vec3(Math.cos(t * 0.21), 0, Math.sin(t * 0.21));
			Vec3 hour = new Vec3(Math.cos(t * 0.03), 0, Math.sin(t * 0.03));
			Fx.line(c.level, Fx.dust(WHITE, 1.0f), center.add(0, 0.15, 0), center.add(minute.scale(r * 0.8)).add(0, 0.15, 0), 0.6);
			Fx.line(c.level, Fx.dust(GOLD, 1.3f), center.add(0, 0.15, 0), center.add(hour.scale(r * 0.5)).add(0, 0.15, 0), 0.5);
		}
		if (t % 10 == 0) Fx.sound(c.level, center, SoundEvents.NOTE_BLOCK_HAT.value(), 1f, (t / 10) % 2 == 0 ? 1.4f : 1.0f);
		if (t % 10 == 0) {
			for (LivingEntity e : c.enemies(center, r)) {
				boolean first = !e.hasEffect(MobEffects.SLOWNESS);
				c.control(e, MobEffects.SLOWNESS, 15, 3);
				Combat.debuff(e, MobEffects.MINING_FATIGUE, 15, 1, c.player);
				Fx.at(c.level, ParticleTypes.REVERSE_PORTAL, e.position().add(0, 1, 0), 6, 0.3, 0.02);
				if (first && c.state.addVar("fCaught", 1) == 3) Mastery.feat(c.player, c.type, "fracture3");
			}
		}
		for (Projectile pr : c.level.getEntitiesOfClass(Projectile.class, new AABB(center, center).inflate(r), pr -> pr.getOwner() != c.player)) {
			pr.setDeltaMovement(pr.getDeltaMovement().scale(0.6));
			pr.hurtMarked = true;
		}
	}

	private void endFracture(Ctx c) {
		c.state.var("fractureActive", 0);
		Fx.sound(c.level, c.pos(), SoundEvents.BELL_BLOCK, 1f, 1.5f);
		if (c.flag("speed.rewind")) {
			Vec3 back = new Vec3(c.state.var("fx"), c.state.var("fy"), c.state.var("fz"));
			if (back.distanceTo(c.pos()) < 64 && KitUtil.safeSpot(c.level, back)) {
				Fx.line(c.level, Fx.dust(CYAN, 1.2f), c.center(), back.add(0, 1, 0), 0.4);
				c.player.teleportTo(c.level, back.x, back.y, back.z, Set.of(), c.player.getYRot(), c.player.getXRot(), false);
				float h = (float) c.state.var("fHealth");
				if (h > c.player.getHealth()) c.player.setHealth(Math.min(c.player.getMaxHealth(), h));
				Fx.sound(c.level, back, SoundEvents.ENDERMAN_TELEPORT, 0.8f, 0.6f);
				Fx.custom(c.level, back, "speed_rewind", 1f, 1f);
			}
		}
	}
}
