package net.chaoshearts.ability.hearts;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import net.minecraft.core.particles.ParticleOptions;
import net.minecraft.core.particles.ParticleTypes;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.effect.MobEffects;
import net.minecraft.world.entity.LivingEntity;
import net.minecraft.world.entity.projectile.Projectile;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.Items;
import net.minecraft.world.phys.AABB;
import net.minecraft.world.phys.Vec3;

/** Infernal: fireballs, burning walls, eruptions, and becoming the fire. */
public final class InfernalKit extends HeartKit {
	private static final int ORANGE = 0xFF7A1A, DEEP = 0x8C1C00, SOUL = 0x3FE0E8, YELLOW = 0xFFD23F;

	private final SkillTree tree;
	/** target -> [owner, until gametime] for burns this heart started. */
	private final Map<UUID, Object[]> ignitedBy = new HashMap<>();

	public InfernalKit() {
		super(HeartType.INFERNAL);
		ability(0, "Fireball Volley", "Hurl three fireballs that burst and set targets alight.", 8, this::volley);
		ability(1, "Flame Wall", "Raise a wall of fire that burns enemies and incinerates projectiles.", 22, this::flameWall);
		ability(2, "Magma Eruption", "Mark the ground; a second later it erupts in a geyser of magma.", 28, this::eruption);
		ability(3, "Inferno Avatar", "Become a living blaze: a burning aura and fireballs that seek your foes.", 120, this::avatar);

		feat("burn20", "Cremation", "Kill 20 enemies while they burn", 400);
		feat("volley3", "Triple Threat", "Hit one target with every fireball of a Volley", 300);
		feat("firewall", "Firewall", "Incinerate 10 projectiles with Flame Wall", 400);
		feat("avatar3", "Living Inferno", "Get 3 kills during one Inferno Avatar", 700);

		SkillTree t = new SkillTree("infernal");
		t.branch("Pyromancer", "Rain fire", ORANGE,
				t.node(0, "hotter_cores", "Hotter Cores", "+20% fireball damage").mod("a1.damage", 0.2),
				t.node(1, "extra_fuel", "Extra Fuel", "Volley throws 5 fireballs").flag("infernal.five"),
				t.node(2, "seeking_flame", "Seeking Flame", "Fireballs curve toward the enemy you aim at").flag("infernal.homing"),
				t.node(3, "scorch", "Scorch", "Burning enemies take 15% more ability damage from you").flag("infernal.scorch"),
				t.node(4, "meteor", "Meteor", "CAPSTONE: the last fireball of each Volley is a meteor that explodes in a 3-block blast").flag("infernal.meteor"));
		t.branch("Flamewarden", "Control the battlefield", DEEP,
				t.node(0, "wider_wall", "Wider Wall", "+40% Flame Wall width").mod("a2.width", 0.4),
				t.node(1, "lingering_heat", "Lingering Heat", "+40% Flame Wall duration").mod("a2.duration", 0.4),
				t.node(2, "cinder_shield", "Cinder Shield", "Standing near your Flame Wall grants Resistance I").flag("infernal.cinder"),
				t.node(3, "magma_surge", "Magma Surge", "+30% Magma Eruption radius").mod("a3.radius", 0.3),
				t.node(4, "ring_of_fire", "Ring of Fire", "CAPSTONE: Flame Wall becomes a full ring of fire around you").flag("infernal.ring"));
		t.branch("Ashbringer", "Burn bright, burn long", YELLOW,
				t.node(0, "kindling", "Kindling", "Your melee burns last twice as long").flag("infernal.kindling"),
				t.node(1, "ember", "Phoenix Ember", "Heal 1 heart when an enemy you set alight dies").flag("infernal.ember"),
				t.node(2, "bigger_blaze", "Bigger Blaze", "+30% Inferno Avatar aura radius").mod("a4.radius", 0.3),
				t.node(3, "endless_pyre", "Endless Pyre", "Kills during Inferno Avatar extend it by 2 seconds").flag("infernal.pyre"),
				t.node(4, "phoenix", "Phoenix", "CAPSTONE: once every 3 minutes, lethal damage makes you explode in flame and rise with 6 hearts").flag("infernal.phoenix"));
		tree = t;
	}

	@Override public String passive1Name() { return "Fireproof"; }
	@Override public String passive1Description() { return "Permanent Fire Resistance."; }
	@Override public String passive2Name() { return "Searing"; }
	@Override public String passive2Description() { return "Your melee hits set enemies on fire."; }
	@Override public String awakenedName() { return "Hellfire"; }
	@Override public String awakenedDescription() { return "Your flames burn blue with soul fire and deal 1 extra damage per second to burning enemies."; }
	@Override public SkillTree tree() { return tree; }

	private ParticleOptions flame(Ctx c) {
		return c.awakened ? ParticleTypes.SOUL_FIRE_FLAME : ParticleTypes.FLAME;
	}

	private int color(Ctx c) {
		return c.awakened ? SOUL : ORANGE;
	}

	private void ignite(Ctx c, LivingEntity e, float seconds) {
		e.igniteForSeconds(seconds);
		ignitedBy.put(e.getUUID(), new Object[] {c.player.getUUID(), c.level.getGameTime() + (long) (seconds * 20) + 20});
	}

	private boolean burningByMe(Ctx c, LivingEntity e) {
		Object[] o = ignitedBy.get(e.getUUID());
		return o != null && c.player.getUUID().equals(o[0]) && (long) o[1] > c.level.getGameTime();
	}

	@Override
	public void tick(Ctx c, long t) {
		ServerPlayer p = c.player;
		long now = c.level.getGameTime();
		if (t % 20 == 0) {
			if (!p.hasEffect(MobEffects.FIRE_RESISTANCE) || p.getEffect(MobEffects.FIRE_RESISTANCE).getDuration() < 60) Combat.buff(p, MobEffects.FIRE_RESISTANCE, 220, 0);
			if (ignitedBy.size() > 256) ignitedBy.values().removeIf(o -> (long) o[1] < now);
		}
		// Hellfire: extra burn damage on enemies we ignited.
		if (c.awakened && t % 20 == 10) {
			for (LivingEntity e : c.enemies(c.pos(), 32)) {
				if (e.isOnFire() && burningByMe(c, e)) {
					Combat.damage(p, e, 1f, true);
					Fx.at(c.level, ParticleTypes.SOUL_FIRE_FLAME, e.position().add(0, 1, 0), 4, 0.25, 0.02);
				}
			}
		}
		if (c.state.timer("avatar", now)) avatarTick(c, t);
	}

	@Override
	public void aura(Ctx c, long t) {
		Fx.at(c.level, flame(c), c.pos().add(0, 0.1, 0), 1, 0.3, 0.01);
		if (t % 8 == 0) Fx.at(c.level, ParticleTypes.SMOKE, c.center(), 1, 0.2, 0.01);
	}

	@Override
	public float outgoing(Ctx c, LivingEntity target, DamageSource s, float amount) {
		if (Combat.inAbilityDamage() && c.flag("infernal.scorch") && target.isOnFire()) amount *= 1.15f;
		return amount;
	}

	@Override
	public void afterHit(Ctx c, LivingEntity target, float amount, boolean ability) {
		if (!ability && c.unlocked(Mastery.LVL_PASSIVE2) && target.isAlive()) {
			ignite(c, target, c.flag("infernal.kindling") ? 6 : 3);
			Fx.at(c.level, flame(c), target.position().add(0, 1, 0), 6, 0.3, 0.03);
		}
	}

	@Override
	public void onKill(Ctx c, LivingEntity victim) {
		long now = c.level.getGameTime();
		if (victim.isOnFire() || burningByMe(c, victim)) {
			if (Mastery.counter(c.player, c.type, "burn_kills", 1) >= 20) Mastery.feat(c.player, c.type, "burn20");
			if (c.flag("infernal.ember") && burningByMe(c, victim)) {
				c.player.heal(2);
				Fx.implode(c.level, Fx.dust(YELLOW, 1.2f), c.center(), 1.5, 16, 0.2);
			}
		}
		if (c.state.timer("avatar", now)) {
			if (c.state.addVar("avatarKills", 1) >= 3) Mastery.feat(c.player, c.type, "avatar3");
			if (c.flag("infernal.pyre")) c.state.startTimer("avatar", now + c.state.timerLeft("avatar", now) + 40);
		}
	}

	@Override
	public boolean preventDeath(Ctx c, DamageSource s) {
		long now = c.level.getGameTime();
		if (!c.flag("infernal.phoenix") || c.state.timer("phoenix_cd", now)) return false;
		c.state.startTimer("phoenix_cd", now + 3600);
		c.player.setHealth(12);
		c.player.clearFire();
		Vec3 at = c.center();
		Fx.far(c.level, ParticleTypes.EXPLOSION_EMITTER, at, 1, 0, 0);
		Fx.sphere(c.level, Fx.dust(YELLOW, 2.5f), at, 3, 120);
		Fx.at(c.level, flame(c), at, 120, 1.5, 0.2);
		Fx.sound(c.level, at, SoundEvents.TOTEM_USE, 1f, 0.8f);
		Fx.sound(c.level, at, SoundEvents.BLAZE_DEATH, 1f, 0.5f);
		Fx.custom(c.level, at, "infernal_phoenix", 1.5f, 1f);
		for (LivingEntity e : c.enemies(at, 4)) {
			c.hit(e, c.dmg("p.phoenix", 8));
			ignite(c, e, 5);
			Ctx.knockFrom(e, at, 1.2, 0.5);
		}
		return true;
	}

	@Override
	public String hud(Ctx c, long t) {
		long now = c.level.getGameTime();
		if (c.state.timer("avatar", now)) return "🔥 INFERNO " + (c.state.timerLeft("avatar", now) / 20 + 1) + "s";
		return null;
	}

	// ---------------------------------------------------------------- abilities

	private SimProjectile fireball(Ctx c, Vec3 from, Vec3 dir, float dmg, boolean meteor, LivingEntity homing, Map<UUID, Integer> hits) {
		ServerLevel level = c.level;
		ServerPlayer p = c.player;
		SimProjectile pr = new SimProjectile(level, from, dir.normalize().scale(meteor ? 1.1 : 1.45));
		pr.owner = p;
		pr.radius = meteor ? 0.7 : 0.45;
		pr.maxTicks = 40;
		pr.display = Displays.item(level, from, new ItemStack(meteor ? Items.MAGMA_BLOCK : Items.FIRE_CHARGE), meteor ? 1.1f : 0.6f, true);
		if (homing != null) {
			pr.homingTarget = homing;
			pr.homingStrength = 0.12;
		}
		ParticleOptions fl = flame(c);
		int col = color(c);
		pr.canHit(e -> Combat.canTarget(p, e));
		pr.onTick(s -> {
			Fx.at(level, fl, s.pos, 3, 0.08, 0.01);
			Fx.at(level, Fx.dust(col, meteor ? 2.2f : 1.3f), s.pos, 2, 0.1, 0);
			if (s.age() % 2 == 0) Fx.at(level, ParticleTypes.SMOKE, s.pos, 1, 0.05, 0.01);
			if (meteor && s.age() % 2 == 0) Fx.at(level, ParticleTypes.LAVA, s.pos, 1, 0.1, 0);
		});
		pr.onEntity((s, e) -> {
			Ctx cc = AbilityManager.ctx(p);
			if (cc == null) return;
			if (cc.hit(e, dmg)) {
				ignite(cc, e, 3);
				if (hits != null && hits.merge(e.getUUID(), 1, Integer::sum) >= 3) Mastery.feat(p, HeartType.INFERNAL, "volley3");
			}
		});
		pr.onEnd((s, at) -> {
			Fx.at(level, ParticleTypes.EXPLOSION, at, meteor ? 3 : 1, meteor ? 0.8 : 0, 0);
			Fx.at(level, fl, at, meteor ? 50 : 15, meteor ? 1.2 : 0.4, 0.08);
			Fx.at(level, ParticleTypes.LAVA, at, meteor ? 10 : 3, 0.4, 0);
			Fx.sound(level, at, SoundEvents.FIRECHARGE_USE, 0.8f, meteor ? 0.5f : 1.2f);
			if (meteor) {
				Fx.sound(level, at, SoundEvents.GENERIC_EXPLODE, 1f, 0.8f);
				Fx.custom(level, at, "infernal_meteor", 1.2f, 1f);
				Ctx cc = AbilityManager.ctx(p);
				if (cc != null) for (LivingEntity e : cc.enemies(at, 3)) {
					cc.hit(e, dmg * 1.5f);
					ignite(cc, e, 4);
					Ctx.knockFrom(e, at, 0.8, 0.4);
				}
			}
		});
		return pr.launch();
	}

	private boolean volley(Ctx c) {
		int count = c.flag("infernal.five") ? 5 : 3;
		float dmg = c.dmg("a1.damage", 5.0);
		LivingEntity homing = c.flag("infernal.homing") ? c.aimEntity(32, 1.5) : null;
		Map<UUID, Integer> hits = new HashMap<>();
		ServerPlayer p = c.player;
		Fx.sound(c.level, c.pos(), SoundEvents.BLAZE_SHOOT, 1f, 0.8f);
		Fx.custom(c.level, c.pos(), "infernal_volley", 1f, 1f);
		for (int i = 0; i < count; i++) {
			final int k = i;
			double spread = Math.toRadians((k - (count - 1) / 2.0) * (count == 5 ? 6 : 8));
			boolean meteor = c.flag("infernal.meteor") && k == count - 1;
			Scheduler.later(1 + k * 3, () -> {
				Ctx cc = AbilityManager.ctx(p);
				if (cc == null || cc.type != HeartType.INFERNAL) return;
				Vec3 dir = KitUtil.rotateY(cc.look(), spread);
				Vec3 from = cc.eye().add(dir.scale(0.8)).subtract(0, 0.2, 0);
				fireball(cc, from, dir, dmg, meteor, homing, hits);
				Fx.sound(cc.level, from, SoundEvents.GHAST_SHOOT, 0.4f, 1.6f);
				Fx.at(cc.level, flame(cc), from, 6, 0.1, 0.05);
			});
		}
		return true;
	}

	private boolean flameWall(Ctx c) {
		ServerPlayer p = c.player;
		ServerLevel level = c.level;
		int dur = c.ticks("a2.duration", 6.0);
		float dmg = c.dmg("a2.damage", 2.0);
		boolean ring = c.flag("infernal.ring");
		Vec3 fwd = c.flatLook();
		Vec3 side = KitUtil.rotateY(fwd, Math.PI / 2);
		Vec3 center = ring ? c.pos() : c.pos().add(fwd.scale(3));
		double width = c.num("a2.width", 7.0);
		int points = ring ? 28 : (int) Math.ceil(width / 0.7);
		Vec3[] posts = new Vec3[points];
		for (int i = 0; i < points; i++) {
			Vec3 q;
			if (ring) {
				double a = Math.PI * 2 * i / points;
				q = center.add(Math.cos(a) * 4.5, 0, Math.sin(a) * 4.5);
			} else {
				q = center.add(side.scale(-width / 2 + width * i / (points - 1)));
			}
			Vec3 g = KitUtil.groundBelow(level, q.add(0, 2, 0), 5);
			posts[i] = g == null ? q : g;
		}
		Fx.sound(level, center, SoundEvents.BLAZE_SHOOT, 1f, 0.5f);
		Fx.sound(level, center, SoundEvents.FIRECHARGE_USE, 1f, 0.6f);
		Fx.custom(level, center, "infernal_flamewall", 1.2f, 1f);
		ParticleOptions fl = flame(c);
		int col = color(c);
		int[] burned = {0};
		Scheduler.repeat(0, 2, dur / 2, i -> {
			Ctx cc = AbilityManager.ctx(p);
			if (cc == null || cc.type != HeartType.INFERNAL) return false;
			double rise = Math.min(1, i / 5.0) * 3.2;
			for (Vec3 q : posts) {
				Fx.at(level, fl, q.add(0, rise * 0.5, 0), 2, 0.15, rise * 0.25, 0.15, 0.01);
				if (i % 3 == 0) Fx.at(level, Fx.dust(col, 1.4f), q.add(0, rise, 0), 1, 0.1, 0);
				if (i % 5 == 0) Fx.at(level, ParticleTypes.LARGE_SMOKE, q.add(0, rise + 0.3, 0), 1, 0.1, 0.02);
			}
			if (i % 10 == 0) Fx.sound(level, center, SoundEvents.FIRE_AMBIENT, 1.2f, 0.8f);
			if (i % 5 == 0) {
				for (Vec3 q : posts) {
					for (LivingEntity e : cc.enemies(q.add(0, 1, 0), 1.0)) {
						cc.hit(e, dmg);
						ignite(cc, e, 4);
					}
				}
				if (cc.flag("infernal.cinder") && p.position().distanceTo(center) < (ring ? 6 : width / 2 + 2)) Combat.buff(p, MobEffects.RESISTANCE, 15, 0);
			}
			// Incinerate projectiles crossing the wall.
			AABB box = new AABB(posts[0], posts[posts.length - 1]).inflate(ring ? 5 : 1, 3.5, ring ? 5 : 1);
			for (Projectile pr : level.getEntitiesOfClass(Projectile.class, box, pr -> pr.getOwner() != p)) {
				for (Vec3 q : posts) {
					if (pr.position().distanceToSqr(q.add(0, 1.5, 0)) < 2.6) {
						Fx.at(level, ParticleTypes.LAVA, pr.position(), 3, 0.1, 0);
						Fx.sound(level, pr.position(), SoundEvents.FIRE_EXTINGUISH, 0.6f, 1.4f);
						pr.discard();
						burned[0]++;
						if (Mastery.counter(p, HeartType.INFERNAL, "burned_proj", 1) >= 10) Mastery.feat(p, HeartType.INFERNAL, "firewall");
						break;
					}
				}
			}
			return true;
		});
		return true;
	}

	private boolean eruption(Ctx c) {
		ServerPlayer p = c.player;
		ServerLevel level = c.level;
		Vec3 aim = c.aimPoint(c.num("a3.range", 20.0));
		Vec3 g = KitUtil.groundBelow(level, aim.add(0, 1, 0), 8);
		Vec3 at = g == null ? aim : g;
		double r = c.num("a3.radius", 3.5);
		float dmg = c.dmg("a3.damage", 8.0);
		int col = color(c);
		Fx.sound(level, at, SoundEvents.LAVA_AMBIENT, 1.5f, 0.6f);
		Fx.custom(level, at, "infernal_rumble", 1.2f, 1f);
		Scheduler.repeat(0, 2, 10, i -> {
			double rr = r * (i + 1) / 10.0;
			Fx.ring(level, Fx.dust(col, 1.3f), at.add(0, 0.1, 0), rr, (int) (rr * 8) + 6);
			Fx.ring(level, Fx.dust(DEEP, 1.0f), at.add(0, 0.1, 0), r, (int) (r * 8));
			Fx.disc(level, ParticleTypes.SMOKE, at.add(0, 0.1, 0), r, 6);
			Fx.at(level, ParticleTypes.DRIPPING_LAVA, at.add(0, 0.5, 0), 4, r * 0.4, 0.1, r * 0.4, 0);
			if (i == 4) Fx.sound(level, at, SoundEvents.BASALT_BREAK, 1.5f, 0.5f);
			if (i == 9) {
				Ctx cc = AbilityManager.ctx(p);
				Fx.far(level, ParticleTypes.EXPLOSION_EMITTER, at.add(0, 0.5, 0), 1, 0, 0);
				Fx.pillar(level, flame(c), at, 7, 60, 0.4);
				Fx.at(level, ParticleTypes.LAVA, at.add(0, 0.5, 0), 40, r * 0.4, 0.3, r * 0.4, 0);
				Fx.at(level, ParticleTypes.LARGE_SMOKE, at.add(0, 2, 0), 30, r * 0.4, 1.5, r * 0.4, 0.05);
				KitUtil.debris(level, at, r * 0.5, 60);
				Fx.sound(level, at, SoundEvents.GENERIC_EXPLODE, 1.3f, 0.6f);
				Fx.sound(level, at, SoundEvents.MAGMA_CUBE_SQUISH, 1.5f, 0.5f);
				Fx.custom(level, at, "infernal_eruption", 1.5f, 1f);
				if (cc != null) for (LivingEntity e : cc.enemies(at.add(0, 1, 0), r)) {
					cc.hit(e, dmg);
					ignite(cc, e, 5);
					Ctx.setVelocity(e, e.getDeltaMovement().add(0, 1.0, 0));
				}
				return false;
			}
			return true;
		});
		return true;
	}

	private boolean avatar(Ctx c) {
		long now = c.level.getGameTime();
		c.state.startTimer("avatar", now + c.ticks("a4.duration", 10.0));
		c.state.var("avatarKills", 0);
		Vec3 at = c.pos();
		Fx.shockRing(c.level, flame(c), at.add(0, 0.2, 0), 0.5, 80, 0.5);
		Fx.pillar(c.level, flame(c), at, 6, 50, 0.3);
		Fx.far(c.level, ParticleTypes.EXPLOSION_EMITTER, at.add(0, 1, 0), 1, 0, 0);
		Fx.sound(c.level, at, SoundEvents.BLAZE_AMBIENT, 1.5f, 0.5f);
		Fx.sound(c.level, at, SoundEvents.GHAST_SCREAM, 0.8f, 0.6f);
		Fx.custom(c.level, at, "infernal_avatar", 1.5f, 1f);
		for (LivingEntity e : c.enemies(at, 4)) Ctx.knockFrom(e, at, 0.9, 0.3);
		return true;
	}

	private void avatarTick(Ctx c, long t) {
		double r = c.num("a4.radius", 4.0);
		ParticleOptions fl = flame(c);
		if (t % 2 == 0) {
			double a = t * 0.3;
			for (int k = 0; k < 3; k++) {
				double aa = a + k * Math.PI * 2 / 3;
				Fx.at(c.level, fl, c.pos().add(Math.cos(aa) * 1.1, 1 + Math.sin(t * 0.2 + k) * 0.4, Math.sin(aa) * 1.1), 2, 0.05, 0.01);
			}
			Fx.ring(c.level, Fx.dust(color(c), 1.1f), c.pos().add(0, 0.15, 0), r, (int) (r * 6), -a);
		}
		if (t % 10 == 0) {
			for (LivingEntity e : c.enemies(c.pos(), r)) {
				c.hit(e, c.dmg("a4.damage", 1.0));
				ignite(c, e, 3);
			}
		}
		if (t % 20 == 0) {
			List<LivingEntity> near = c.enemies(c.center(), 16);
			if (!near.isEmpty()) {
				LivingEntity target = near.get(0);
				Vec3 from = c.center().add(0, 1.2, 0);
				Vec3 dir = target.position().add(0, target.getBbHeight() / 2, 0).subtract(from);
				SimProjectile pr = fireball(c, from, dir, c.dmg("a1.damage", 5.0) * 0.6f, false, target, null);
				pr.homingStrength = 0.2;
				Fx.sound(c.level, from, SoundEvents.BLAZE_SHOOT, 0.6f, 1.3f);
			}
		}
	}
}
