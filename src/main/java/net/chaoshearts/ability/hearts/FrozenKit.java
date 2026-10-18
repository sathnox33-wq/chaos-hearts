package net.chaoshearts.ability.hearts;

import java.util.HashMap;
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
import net.chaoshearts.fx.TempBlocks;
import net.chaoshearts.heart.HeartType;
import net.chaoshearts.mastery.Mastery;
import net.chaoshearts.skill.SkillTree;
import net.minecraft.core.BlockPos;
import net.minecraft.core.particles.BlockParticleOption;
import net.minecraft.core.particles.ParticleTypes;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.tags.DamageTypeTags;
import net.minecraft.util.Mth;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.effect.MobEffectInstance;
import net.minecraft.world.effect.MobEffects;
import net.minecraft.world.entity.Display;
import net.minecraft.world.entity.LivingEntity;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.Items;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.world.level.block.state.BlockState;
import net.minecraft.world.level.material.Fluids;
import net.minecraft.world.phys.Vec3;

/** Frozen: shards, walls of ice, freezing novas and a killing blizzard. */
public final class FrozenKit extends HeartKit {
	private static final int ICE = 0x9BE7FF, DEEP = 0x2F6FA8, WHITE = 0xF2FBFF;

	private final SkillTree tree;
	/** target -> [stacks, last hit gametime] */
	private final Map<UUID, long[]> frostbite = new HashMap<>();

	public FrozenKit() {
		super(HeartType.FROZEN);
		ability(0, "Ice Shard", "Fire a piercing shard of ice that chills what it hits.", 5, this::shard);
		ability(1, "Glacial Wall", "Raise a wall of solid ice in front of you.", 20, this::wall);
		ability(2, "Frost Nova", "Freeze everything around you in a burst of cold.", 25, this::nova);
		ability(3, "Absolute Zero", "Call a blizzard: enemies freeze and ice spikes tear through them.", 130, this::absoluteZero);

		feat("freeze10", "Deep Freeze", "Fully freeze 10 enemies with Frostbite", 400);
		feat("sniper", "Shard Sniper", "Hit an Ice Shard from 30 or more blocks away", 400);
		feat("nova4", "Flash Freeze", "Hit 4 enemies with one Frost Nova", 500);
		feat("zero2", "Absolute", "Get 2 kills during one Absolute Zero", 700);

		SkillTree t = new SkillTree("frozen");
		t.branch("Glacier", "Lock them in place", DEEP,
				t.node(0, "biting_cold", "Biting Cold", "Frostbite freezes at 4 stacks instead of 5").flag("frozen.fast_freeze"),
				t.node(1, "thick_ice", "Thick Ice", "+40% Glacial Wall duration").mod("a2.duration", 0.4),
				t.node(2, "great_wall", "Great Wall", "+40% Glacial Wall width").mod("a2.width", 0.4),
				t.node(3, "frozen_solid", "Frozen Solid", "Full freezes last 50% longer").mod("p.freeze", 0.5),
				t.node(4, "ice_prison", "Ice Prison", "CAPSTONE: Frost Nova encases enemies in a shell of ice").flag("frozen.prison"));
		t.branch("Shardcaster", "Cold steel", ICE,
				t.node(0, "sharper", "Sharper Shards", "+25% Ice Shard damage").mod("a1.damage", 0.25),
				t.node(1, "splinter", "Splinter", "Ice Shard shatters into fragments on impact").flag("frozen.splinter"),
				t.node(2, "piercing_cold", "Piercing Cold", "Ice Shard pierces 2 more enemies").flag("frozen.pierce"),
				t.node(3, "cold_snap", "Cold Snap", "+30% Frost Nova damage").mod("a3.damage", 0.3),
				t.node(4, "hailstorm", "Hailstorm", "CAPSTONE: Ice Shard fires a fan of three shards").flag("frozen.fan"));
		t.branch("Winter's Heart", "Endure the cold", WHITE,
				t.node(0, "frost_armor", "Frost Armor", "Enemies that hit you in melee are slowed").flag("frozen.armor"),
				t.node(1, "chilled_blood", "Chilled Blood", "Take 10% less damage from slowed enemies").flag("frozen.chilled"),
				t.node(2, "long_winter", "Long Winter", "+30% Absolute Zero duration").mod("a4.duration", 0.3),
				t.node(3, "wider_storm", "Wider Storm", "+25% Absolute Zero radius").mod("a4.radius", 0.25),
				t.node(4, "avalanche_heart", "Heart of Winter", "CAPSTONE: inside Absolute Zero you regenerate and cannot be slowed").flag("frozen.heart"));
		tree = t;
	}

	@Override public String passive1Name() { return "Coldborn"; }
	@Override public String passive1Description() { return "You never freeze, and water freezes beneath your feet."; }
	@Override public String passive2Name() { return "Frostbite"; }
	@Override public String passive2Description() { return "Melee hits stack Frostbite; at 5 stacks the target freezes solid."; }
	@Override public String awakenedName() { return "Permafrost"; }
	@Override public String awakenedDescription() { return "Frozen enemies shatter when your abilities hit them, taking 40% more damage."; }
	@Override public SkillTree tree() { return tree; }

	private boolean frozen(LivingEntity e) {
		MobEffectInstance s = e.getEffect(MobEffects.SLOWNESS);
		return s != null && s.getAmplifier() >= 2;
	}

	private void freezeSolid(Ctx c, LivingEntity e) {
		int ticks = (int) (30 * (1 + c.skills.mod("p.freeze")));
		Combat.control(e, MobEffects.SLOWNESS, ticks, 3, c.player);
		e.setTicksFrozen(Math.max(e.getTicksFrozen(), e.getTicksRequiredToFreeze() + 20));
		Vec3 at = e.position().add(0, e.getBbHeight() / 2, 0);
		c.level.sendParticles(new BlockParticleOption(ParticleTypes.BLOCK, Blocks.ICE.defaultBlockState()), at.x, at.y, at.z, 30, 0.3, 0.5, 0.3, 0.1);
		Fx.sound(c.level, at, SoundEvents.GLASS_BREAK, 0.8f, 1.4f);
		Fx.sound(c.level, at, SoundEvents.PLAYER_HURT_FREEZE, 0.8f, 0.8f);
		if (Mastery.counter(c.player, c.type, "freezes", 1) >= 10) Mastery.feat(c.player, c.type, "freeze10");
	}

	/** Ability damage with Permafrost shatter. */
	private boolean iceHit(Ctx c, LivingEntity e, float dmg) {
		if (c.awakened && frozen(e)) {
			dmg *= 1.4f;
			Vec3 at = e.position().add(0, e.getBbHeight() / 2, 0);
			c.level.sendParticles(new BlockParticleOption(ParticleTypes.BLOCK, Blocks.BLUE_ICE.defaultBlockState()), at.x, at.y, at.z, 40, 0.4, 0.6, 0.4, 0.2);
			Fx.sound(c.level, at, SoundEvents.GLASS_BREAK, 1f, 0.7f);
			Fx.custom(c.level, at, "frozen_shatter", 1f, 1f);
			e.removeEffect(MobEffects.SLOWNESS);
		}
		return c.hit(e, dmg);
	}

	@Override
	public void tick(Ctx c, long t) {
		ServerPlayer p = c.player;
		long now = c.level.getGameTime();
		if (p.getTicksFrozen() > 0 && !p.isInPowderSnow) p.setTicksFrozen(0);
		// Frost walking
		if (t % 2 == 0 && !p.isShiftKeyDown()) {
			BlockPos base = p.blockPosition().below();
			BlockState frosted = Blocks.FROSTED_ICE.defaultBlockState();
			for (BlockPos bp : BlockPos.betweenClosed(base.offset(-2, 0, -2), base.offset(2, 0, 2))) {
				if (bp.distToCenterSqr(p.getX(), base.getY() + 0.5, p.getZ()) > 6.5) continue;
				if (!c.level.getBlockState(bp.above()).isAir()) continue;
				BlockState st = c.level.getBlockState(bp);
				if (st.getFluidState().is(Fluids.WATER) && st.getFluidState().isSource() && st.is(Blocks.WATER)) {
					c.level.setBlockAndUpdate(bp, frosted);
					c.level.scheduleTick(bp.immutable(), Blocks.FROSTED_ICE, Mth.nextInt(p.getRandom(), 60, 120));
				}
			}
		}
		if (t % 100 == 0) frostbite.values().removeIf(v -> now - v[1] > 200);
		if (c.state.timer("zero", now)) zeroTick(c, t);
		else if (c.state.var("zeroActive") == 1) c.state.var("zeroActive", 0);
	}

	@Override
	public void aura(Ctx c, long t) {
		Fx.at(c.level, ParticleTypes.SNOWFLAKE, c.center(), 2, 0.4, 0.6, 0.4, 0.01);
		if (c.awakened) Fx.at(c.level, Fx.dust(ICE, 1.0f), c.pos().add(0, 0.1, 0), 2, 0.4, 0);
	}

	@Override
	public float incoming(Ctx c, DamageSource s, float amount) {
		if (s.is(DamageTypeTags.IS_FREEZING)) return 0;
		if (c.flag("frozen.chilled") && s.getEntity() instanceof LivingEntity le && le.hasEffect(MobEffects.SLOWNESS)) amount *= 0.9f;
		return amount;
	}

	@Override
	public void afterHit(Ctx c, LivingEntity target, float amount, boolean ability) {
		if (ability || !c.unlocked(Mastery.LVL_PASSIVE2) || !target.isAlive()) return;
		long now = c.level.getGameTime();
		long[] st = frostbite.computeIfAbsent(target.getUUID(), u -> new long[] {0, now});
		if (now - st[1] > 100) st[0] = 0;
		st[0]++;
		st[1] = now;
		int needed = c.flag("frozen.fast_freeze") ? 4 : 5;
		Fx.at(c.level, ParticleTypes.SNOWFLAKE, target.getEyePosition(), 6 + (int) st[0] * 2, 0.3, 0.05);
		if (st[0] >= needed) {
			st[0] = 0;
			freezeSolid(c, target);
		} else {
			Combat.debuff(target, MobEffects.SLOWNESS, 40, 0, c.player);
			target.setTicksFrozen(Math.min(target.getTicksRequiredToFreeze() - 1, target.getTicksFrozen() + 30));
		}
	}

	@Override
	public void afterHurt(Ctx c, DamageSource s, float amount) {
		if (c.flag("frozen.armor") && s.getEntity() instanceof LivingEntity le && s.getDirectEntity() == le && le != c.player) {
			Combat.control(le, MobEffects.SLOWNESS, 40, 1, c.player);
			Fx.at(c.level, ParticleTypes.SNOWFLAKE, le.getEyePosition(), 10, 0.3, 0.05);
		}
	}

	@Override
	public void onKill(Ctx c, LivingEntity victim) {
		if (c.state.timer("zero", c.level.getGameTime()) && c.state.addVar("zeroKills", 1) >= 2) Mastery.feat(c.player, c.type, "zero2");
	}

	@Override
	public String hud(Ctx c, long t) {
		long now = c.level.getGameTime();
		if (c.state.timer("zero", now)) return "❄ ABSOLUTE ZERO " + (c.state.timerLeft("zero", now) / 20 + 1) + "s";
		return null;
	}

	// ---------------------------------------------------------------- abilities

	private void shardProjectile(Ctx c, Vec3 from, Vec3 dir, float dmg, boolean fragment) {
		ServerPlayer p = c.player;
		ServerLevel level = c.level;
		SimProjectile pr = new SimProjectile(level, from, dir.normalize().scale(fragment ? 1.2 : 2.2));
		pr.owner = p;
		pr.radius = fragment ? 0.3 : 0.4;
		pr.maxTicks = fragment ? 8 : 30;
		pr.pierce = fragment ? 0 : (c.flag("frozen.pierce") ? 3 : 1);
		pr.gravity = fragment ? 0.03 : 0.0;
		if (!fragment) {
			pr.display = Displays.item(level, from, new ItemStack(Items.ICE), 0.45f, true);
			if (pr.display != null) Displays.transform(pr.display, new Vector3f(), new Quaternionf().rotateXYZ(0.6f, 0.8f, 0.3f), new Vector3f(0.45f, 0.45f, 0.9f), 0);
		}
		Vec3 origin = from;
		pr.canHit(e -> Combat.canTarget(p, e));
		pr.onTick(s -> {
			Fx.at(level, ParticleTypes.SNOWFLAKE, s.pos, fragment ? 1 : 3, 0.05, 0.01);
			if (!fragment) Fx.at(level, Fx.dust(ICE, 1.0f), s.pos, 2, 0.05, 0);
		});
		pr.onEntity((s, e) -> {
			Ctx cc = AbilityManager.ctx(p);
			if (cc == null) return;
			if (iceHit(cc, e, dmg)) {
				cc.control(e, MobEffects.SLOWNESS, 40, 1);
				e.setTicksFrozen(Math.min(e.getTicksRequiredToFreeze() - 1, e.getTicksFrozen() + 60));
				if (e instanceof ServerPlayer sp) Fx.frostScreen(sp, 120);
				if (!fragment && e.position().distanceTo(origin) >= 30) Mastery.feat(p, HeartType.FROZEN, "sniper");
			}
		});
		pr.onEnd((s, at) -> {
			level.sendParticles(new BlockParticleOption(ParticleTypes.BLOCK, Blocks.ICE.defaultBlockState()), at.x, at.y, at.z, fragment ? 4 : 14, 0.15, 0.15, 0.15, 0.1);
			Fx.sound(level, at, SoundEvents.GLASS_BREAK, fragment ? 0.3f : 0.6f, 1.6f);
			if (!fragment && c.flag("frozen.splinter")) {
				Ctx cc = AbilityManager.ctx(p);
				if (cc != null) for (int i = 0; i < 4; i++) {
					Vec3 d = Fx.randomDir(level);
					shardProjectile(cc, at, new Vec3(d.x, Math.abs(d.y) * 0.5, d.z), dmg * 0.35f, true);
				}
			}
		});
		pr.launch();
	}

	private boolean shard(Ctx c) {
		float dmg = c.dmg("a1.damage", 5.0);
		int n = c.flag("frozen.fan") ? 3 : 1;
		for (int i = 0; i < n; i++) {
			double off = n == 1 ? 0 : Math.toRadians((i - 1) * 9);
			Vec3 dir = KitUtil.rotateY(c.look(), off);
			shardProjectile(c, c.eye().add(dir.scale(0.6)).subtract(0, 0.15, 0), dir, dmg, false);
		}
		Fx.sound(c.level, c.pos(), SoundEvents.SNOW_GOLEM_SHOOT, 1f, 0.7f);
		Fx.sound(c.level, c.pos(), SoundEvents.AMETHYST_BLOCK_HIT, 1f, 1.6f);
		Fx.custom(c.level, c.pos(), "frozen_shard", 1f, 1f);
		return true;
	}

	private boolean wall(Ctx c) {
		ServerLevel level = c.level;
		Vec3 fwd = c.flatLook();
		Vec3 side = KitUtil.rotateY(fwd, Math.PI / 2);
		Vec3 center = c.pos().add(fwd.scale(2.5));
		int width = (int) Math.round(c.num("a2.width", 5.0));
		int dur = c.ticks("a2.duration", 8.0);
		Vec3 g = KitUtil.groundBelow(level, center.add(0, 2, 0), 6);
		if (g != null) center = g;
		int placed = 0;
		BlockState ice = Blocks.PACKED_ICE.defaultBlockState();
		for (int i = 0; i < width; i++) {
			Vec3 col = center.add(side.scale(i - (width - 1) / 2.0));
			for (int h = 0; h < 3; h++) {
				BlockPos bp = BlockPos.containing(col.x, center.y + h + 0.01, col.z);
				final int delay = h * 2 + Math.abs(i - width / 2);
				final int life = dur - delay;
				Scheduler.later(1 + delay, () -> {
					if (TempBlocks.place(level, bp, ice, life)) {
						level.sendParticles(new BlockParticleOption(ParticleTypes.BLOCK, ice), bp.getX() + 0.5, bp.getY() + 0.5, bp.getZ() + 0.5, 6, 0.3, 0.3, 0.3, 0.05);
						Fx.at(level, ParticleTypes.SNOWFLAKE, Vec3.atCenterOf(bp), 4, 0.4, 0.02);
					}
				});
				placed++;
			}
		}
		if (placed == 0) return false;
		Vec3 cAt = center;
		for (LivingEntity e : c.enemies(cAt.add(0, 1, 0), width / 2.0 + 0.5)) {
			Ctx.knockFrom(e, c.pos(), 0.9, 0.3);
			c.control(e, MobEffects.SLOWNESS, 40, 1);
		}
		Fx.sound(level, cAt, SoundEvents.GLASS_PLACE, 1.2f, 0.6f);
		Fx.sound(level, cAt, SoundEvents.POWDER_SNOW_PLACE, 1.2f, 0.6f);
		Fx.custom(level, cAt, "frozen_wall", 1f, 1f);
		Scheduler.later(dur, () -> Fx.sound(level, cAt, SoundEvents.GLASS_BREAK, 1f, 0.8f));
		return true;
	}

	private boolean nova(Ctx c) {
		ServerPlayer p = c.player;
		ServerLevel level = c.level;
		double r = c.num("a3.radius", 6.0);
		float dmg = c.dmg("a3.damage", 4.0);
		Vec3 at = c.pos();
		Fx.sound(level, at, SoundEvents.POWDER_SNOW_BREAK, 1.5f, 0.5f);
		Fx.sound(level, at, SoundEvents.AMETHYST_BLOCK_RESONATE, 1.5f, 0.6f);
		Fx.custom(level, at, "frozen_nova", 1.4f, 1f);
		Fx.flash(level, c.center());
		for (int i = 0; i < 5; i++) {
			final int k = i;
			Scheduler.later(1 + i, () -> {
				double rr = r * (k + 1) / 5.0;
				Fx.ring(level, Fx.dust(k % 2 == 0 ? ICE : WHITE, 1.6f), at.add(0, 0.2 + k * 0.1, 0), rr, (int) (rr * 9));
				Fx.ring(level, ParticleTypes.SNOWFLAKE, at.add(0, 0.5, 0), rr, (int) (rr * 4));
			});
		}
		Fx.sphere(level, Fx.dust(ICE, 1.2f), c.center(), 1.5, 50);
		int hits = 0;
		for (LivingEntity e : c.enemies(at, r)) {
			if (iceHit(c, e, dmg)) hits++;
			c.control(e, MobEffects.SLOWNESS, 60, 3);
			e.setTicksFrozen(Math.max(e.getTicksFrozen(), e.getTicksRequiredToFreeze()));
			if (e instanceof ServerPlayer sp) Fx.frostScreen(sp, 140);
			level.sendParticles(new BlockParticleOption(ParticleTypes.BLOCK, Blocks.ICE.defaultBlockState()), e.getX(), e.getY() + 1, e.getZ(), 16, 0.3, 0.5, 0.3, 0.1);
			if (c.flag("frozen.prison")) prison(level, e, 30);
		}
		if (hits >= 4) Mastery.feat(p, c.type, "nova4");
		return true;
	}

	/** A shell of ice around (never inside) the target's space. */
	private void prison(ServerLevel level, LivingEntity e, int ticks) {
		BlockPos feet = e.blockPosition();
		BlockState ice = Blocks.ICE.defaultBlockState();
		int[][] ring = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
		for (int y = 0; y < 2; y++) for (int[] o : ring) TempBlocks.place(level, feet.offset(o[0], y, o[1]), ice, ticks);
		TempBlocks.place(level, feet.above(2), ice, ticks);
	}

	private boolean absoluteZero(Ctx c) {
		long now = c.level.getGameTime();
		int dur = c.ticks("a4.duration", 8.0);
		c.state.startTimer("zero", now + dur);
		c.state.var("zeroActive", 1);
		c.state.var("zeroKills", 0);
		c.state.var("zx", c.player.getX());
		c.state.var("zy", c.player.getY());
		c.state.var("zz", c.player.getZ());
		Combat.buff(c.player, MobEffects.RESISTANCE, dur, 0);
		Fx.far(c.level, ParticleTypes.EXPLOSION_EMITTER, c.center(), 1, 0, 0);
		Fx.shockRing(c.level, Fx.dust(WHITE, 2.2f), c.pos().add(0, 0.3, 0), 0.5, 70, 0.7);
		Fx.sound(c.level, c.pos(), SoundEvents.ELDER_GUARDIAN_CURSE, 0.8f, 1.6f);
		Fx.sound(c.level, c.pos(), SoundEvents.POWDER_SNOW_BREAK, 2f, 0.4f);
		Fx.custom(c.level, c.pos(), "frozen_blizzard", 2f, 1f);
		Fx.title(c.player, net.minecraft.network.chat.Component.empty(), net.minecraft.network.chat.Component.literal("❄ Absolute Zero").withStyle(c.type.style().withBold(true)), 2, 30, 10);
		return true;
	}

	private void zeroTick(Ctx c, long t) {
		ServerLevel level = c.level;
		Vec3 center = c.pos();
		double r = c.num("a4.radius", 10.0);
		// Blizzard: snow whipping around in a vortex.
		if (t % 2 == 0) {
			for (int i = 0; i < 14; i++) {
				double a = level.random.nextDouble() * Math.PI * 2;
				double d = Math.sqrt(level.random.nextDouble()) * r;
				Vec3 q = center.add(Math.cos(a) * d, 0.3 + level.random.nextDouble() * 4, Math.sin(a) * d);
				Vec3 tangent = new Vec3(-Math.sin(a), -0.1, Math.cos(a));
				Fx.directed(level, i % 3 == 0 ? ParticleTypes.WHITE_ASH : ParticleTypes.SNOWFLAKE, q, tangent, 0.4);
			}
			Fx.ring(level, Fx.dust(ICE, 1.3f), center.add(0, 0.2, 0), r, (int) (r * 5), t * 0.08);
		}
		if (t % 20 == 0) Fx.sound(level, center, SoundEvents.POWDER_SNOW_STEP, 1.5f, 0.5f);
		if (c.flag("frozen.heart")) {
			c.player.removeEffect(MobEffects.SLOWNESS);
			if (t % 20 == 0) c.player.heal(1);
		}
		if (t % 10 == 0) {
			for (LivingEntity e : c.enemies(center, r)) {
				iceHit(c, e, c.dmg("a4.damage", 1.5));
				c.control(e, MobEffects.SLOWNESS, 20, 1);
				e.setTicksFrozen(Math.min(e.getTicksRequiredToFreeze() + 40, e.getTicksFrozen() + 40));
				if (e instanceof ServerPlayer sp) Fx.frostScreen(sp, 200);
			}
		}
		if (t % 20 == 0) {
			List<LivingEntity> targets = c.enemies(center, r);
			ServerPlayer p = c.player;
			for (int i = 0; i < Math.min(3, targets.size()); i++) {
				Vec3 spot = targets.get(i).position();
				Fx.ring(level, Fx.dust(DEEP, 1.4f), spot.add(0, 0.1, 0), 1.2, 14);
				Scheduler.later(10, () -> spike(p, level, spot));
			}
		}
	}

	private void spike(ServerPlayer p, ServerLevel level, Vec3 at) {
		Ctx cc = AbilityManager.ctx(p);
		if (cc == null || cc.type != HeartType.FROZEN) return;
		Display.BlockDisplay d = Displays.block(level, at.add(0, -1.2, 0), Blocks.BLUE_ICE.defaultBlockState(), 1f, true);
		if (d != null) {
			Displays.transform(d, new Vector3f(-0.35f, 0, -0.35f), new Quaternionf().rotateY(level.random.nextFloat() * 6f), new Vector3f(0.7f, 0.2f, 0.7f), 0);
			Scheduler.later(1, () -> Displays.transform(d, new Vector3f(-0.35f, 0, -0.35f), new Quaternionf().rotateY(0.5f), new Vector3f(0.7f, 3.4f, 0.7f), 3));
			Scheduler.later(25, () -> Displays.transform(d, new Vector3f(-0.35f, 0, -0.35f), new Quaternionf(), new Vector3f(0.7f, 0f, 0.7f), 8));
			Scheduler.later(34, d::discard);
		}
		level.sendParticles(new BlockParticleOption(ParticleTypes.BLOCK, Blocks.BLUE_ICE.defaultBlockState()), at.x, at.y + 0.5, at.z, 30, 0.4, 0.8, 0.4, 0.15);
		Fx.sound(level, at, SoundEvents.GLASS_BREAK, 1f, 0.5f);
		Fx.sound(level, at, SoundEvents.POINTED_DRIPSTONE_LAND, 1f, 0.6f);
		for (LivingEntity e : cc.enemies(at.add(0, 1, 0), 1.6)) {
			iceHit(cc, e, cc.dmg("a4.spike", 5.0));
			Ctx.setVelocity(e, e.getDeltaMovement().add(0, 0.8, 0));
		}
	}
}
