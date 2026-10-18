package net.chaoshearts.ability.hearts;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
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
import net.minecraft.ChatFormatting;
import net.minecraft.core.particles.ParticleTypes;
import net.minecraft.network.chat.Component;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.effect.MobEffectInstance;
import net.minecraft.world.effect.MobEffects;
import net.minecraft.world.entity.EntitySpawnReason;
import net.minecraft.world.entity.EntityType;
import net.minecraft.world.entity.EquipmentSlot;
import net.minecraft.world.entity.LivingEntity;
import net.minecraft.world.entity.ai.attributes.Attributes;
import net.minecraft.world.entity.monster.Husk;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.Items;
import net.minecraft.world.phys.Vec3;

/** Corruption: plague clouds, rotting ground, infections that burst, and a pandemic. */
public final class CorruptionKit extends HeartKit {
	private static final int GREEN = 0x7BD13A, PURPLE = 0x3D1A52, SICK = 0xB8E05A, BILE = 0x4A6B1E;

	private final SkillTree tree;
	/** target -> blight stacks and last hit */
	private final Map<UUID, long[]> blight = new HashMap<>();
	/** infected targets with pending bursts: target uuid -> generation */
	private final Map<UUID, Integer> infected = new HashMap<>();

	public CorruptionKit() {
		super(HeartType.CORRUPTION);
		ability(0, "Plague Bolt", "A bolt of rot that bursts into a lingering poison cloud.", 9, this::plagueBolt);
		ability(1, "Rot Ground", "Corrupt the earth: everything standing on it withers.", 22, this::rotGround);
		ability(2, "Infest", "Plant an infection in a target. It bursts a few seconds later, spreading.", 30, this::infestCast);
		ability(3, "Pandemic", "Infect every enemy near you and raise Rotlings to fight for you.", 150, this::pandemic);

		feat("zero5", "Patient Zero", "Poison 5 enemies with one Plague Bolt cloud", 400);
		feat("rot10", "Decomposition", "Kill 10 enemies standing in your Rot Ground", 400);
		feat("burst3", "Contagion", "Hit 3 enemies with one Infest burst", 500);
		feat("outbreak5", "Outbreak", "Infect 5 enemies with one Pandemic", 800);

		SkillTree t = new SkillTree("corruption");
		t.branch("Plaguebringer", "Fill the air with rot", GREEN,
				t.node(0, "virulent", "Virulent", "+25% Plague Bolt damage").mod("a1.damage", 0.25),
				t.node(1, "spreading_cloud", "Spreading Cloud", "+40% plague cloud radius").mod("a1.radius", 0.4),
				t.node(2, "miasma", "Lingering Miasma", "Plague clouds last 50% longer").mod("a1.duration", 0.5),
				t.node(3, "necrosis", "Necrosis", "Poisoned enemies take 15% more damage from your abilities").flag("corruption.necrosis"),
				t.node(4, "plague_rain", "Plague Rain", "CAPSTONE: Plague Bolt bursts into four bolts that rain around the impact").flag("corruption.rain"));
		t.branch("Rotmother", "The dead serve", PURPLE,
				t.node(0, "deep_rot", "Deep Rot", "+30% Rot Ground radius").mod("a2.radius", 0.3),
				t.node(1, "withering", "Withering", "Rot Ground inflicts Wither II").flag("corruption.wither2"),
				t.node(2, "mire", "Sticky Mire", "Rot Ground slows enemies more").flag("corruption.mire"),
				t.node(3, "brood", "Brood", "Pandemic raises 2 more Rotlings").flag("corruption.brood"),
				t.node(4, "hive_mind", "Hive Mind", "CAPSTONE: Rotlings last 50% longer and burst into plague clouds when they fall").flag("corruption.hive"));
		t.branch("Contagion", "It spreads", SICK,
				t.node(0, "short_fuse", "Short Fuse", "Infest bursts a second sooner").flag("corruption.fuse"),
				t.node(1, "bigger_burst", "Bigger Burst", "+40% Infest burst radius").mod("a3.radius", 0.4),
				t.node(2, "feverish", "Feverish", "Blight becomes Poison II after 2 hits instead of 3").flag("corruption.fever"),
				t.node(3, "carrier", "Carrier", "When Infest bursts, it jumps to the nearest enemy").flag("corruption.carrier"),
				t.node(4, "black_death", "Black Death", "CAPSTONE: every enemy hit by an Infest burst becomes infested too").flag("corruption.blackdeath"));
		tree = t;
	}

	@Override public String passive1Name() { return "Plagueborn"; }
	@Override public String passive1Description() { return "Immune to Poison and Wither."; }
	@Override public String passive2Name() { return "Blight"; }
	@Override public String passive2Description() { return "Melee hits poison; repeated hits make the poison stronger."; }
	@Override public String awakenedName() { return "Blight Lord"; }
	@Override public String awakenedDescription() { return "If an infested target dies before it bursts, the infection jumps to another enemy."; }
	@Override public SkillTree tree() { return tree; }

	@Override
	public void tick(Ctx c, long t) {
		ServerPlayer p = c.player;
		if (p.hasEffect(MobEffects.POISON)) p.removeEffect(MobEffects.POISON);
		if (p.hasEffect(MobEffects.WITHER)) p.removeEffect(MobEffects.WITHER);
		long now = c.level.getGameTime();
		if (t % 100 == 0) blight.values().removeIf(v -> now - v[1] > 200);
	}

	@Override
	public void aura(Ctx c, long t) {
		Fx.at(c.level, Fx.dust(GREEN, 0.8f), c.pos().add(0, 0.1, 0), 2, 0.4, 0);
		if (t % 8 == 0) Fx.at(c.level, ParticleTypes.SCULK_SOUL, c.center(), 1, 0.3, 0.01);
		if (c.awakened) Fx.at(c.level, ParticleTypes.SPORE_BLOSSOM_AIR, c.center(), 1, 0.5, 0);
	}

	@Override
	public float outgoing(Ctx c, LivingEntity target, DamageSource s, float amount) {
		if (Combat.inAbilityDamage() && c.flag("corruption.necrosis") && target.hasEffect(MobEffects.POISON)) amount *= 1.15f;
		return amount;
	}

	@Override
	public void afterHit(Ctx c, LivingEntity target, float amount, boolean ability) {
		if (ability || !c.unlocked(Mastery.LVL_PASSIVE2) || !target.isAlive()) return;
		long now = c.level.getGameTime();
		long[] st = blight.computeIfAbsent(target.getUUID(), u -> new long[] {0, now});
		if (now - st[1] > 100) st[0] = 0;
		st[0]++;
		st[1] = now;
		int need = c.flag("corruption.fever") ? 2 : 3;
		Combat.debuff(target, MobEffects.POISON, 60, st[0] >= need ? 1 : 0, c.player);
		Fx.at(c.level, Fx.dust(GREEN, 1.1f), target.getEyePosition(), 6, 0.3, 0);
	}

	@Override
	public void onKill(Ctx c, LivingEntity victim) {
		if (c.state.var("rotActive") > 0 && victim.position().distanceTo(new Vec3(c.state.var("rotX"), c.state.var("rotY"), c.state.var("rotZ"))) <= c.state.var("rotR") + 0.5) {
			if (Mastery.counter(c.player, c.type, "rot_kills", 1) >= 10) Mastery.feat(c.player, c.type, "rot10");
		}
		Integer gen = infected.remove(victim.getUUID());
		if (gen != null && c.awakened) {
			for (LivingEntity e : c.enemies(victim.position(), 8)) {
				if (e == victim || infected.containsKey(e.getUUID())) continue;
				Fx.line(c.level, Fx.dust(SICK, 1.2f), victim.position().add(0, 1, 0), e.position().add(0, 1, 0), 0.4);
				infest(c, e, gen);
				break;
			}
		}
	}

	// ---------------------------------------------------------------- shared

	/** A poison cloud that only harms the caster's enemies. Returns how many enemies it touched. */
	private Set<UUID> cloud(ServerPlayer owner, ServerLevel level, Vec3 at, double r, int ticks) {
		Set<UUID> touched = new HashSet<>();
		Scheduler.repeat(0, 5, Math.max(1, ticks / 5), i -> {
			Ctx cc = AbilityManager.ctx(owner);
			if (cc == null) return false;
			Fx.disc(level, Fx.dust(GREEN, 1.6f), at.add(0, 0.4, 0), r, (int) (r * 6));
			Fx.disc(level, Fx.dust(PURPLE, 1.3f), at.add(0, 1.0, 0), r * 0.8, (int) (r * 3));
			Fx.at(level, ParticleTypes.SNEEZE, at.add(0, 0.6, 0), 3, r * 0.4, 0.3, r * 0.4, 0.01);
			for (LivingEntity e : cc.enemies(at.add(0, 0.6, 0), r)) {
				Combat.debuff(e, MobEffects.POISON, 40, 0, owner);
				if (touched.add(e.getUUID())) cc.rewardHit(e);
			}
			return true;
		});
		return touched;
	}

	// ---------------------------------------------------------------- abilities

	private void bolt(Ctx c, Vec3 from, Vec3 vel, boolean child) {
		ServerPlayer p = c.player;
		ServerLevel level = c.level;
		float dmg = c.dmg("a1.damage", 4.0) * (child ? 0.5f : 1f);
		double r = c.num("a1.radius", 3.0) * (child ? 0.7 : 1);
		int dur = c.ticks("a1.duration", 4.0);
		SimProjectile pr = new SimProjectile(level, from, vel);
		pr.owner = p;
		pr.radius = 0.4;
		pr.gravity = child ? 0.05 : 0.015;
		pr.maxTicks = 50;
		if (!child) pr.display = Displays.item(level, from, new ItemStack(Items.FERMENTED_SPIDER_EYE), 0.6f, true);
		pr.canHit(e -> Combat.canTarget(p, e));
		pr.onTick(s -> {
			Fx.at(level, Fx.dust(GREEN, 1.3f), s.pos, 3, 0.08, 0);
			if (s.age() % 2 == 0) Fx.at(level, ParticleTypes.SNEEZE, s.pos, 1, 0.05, 0.01);
		});
		pr.onEntity((s, e) -> {
			Ctx cc = AbilityManager.ctx(p);
			if (cc != null) cc.hit(e, dmg);
		});
		pr.onEnd((s, at) -> {
			Fx.at(level, Fx.dust(BILE, 2f), at, 30, 0.6, 0);
			Fx.sound(level, at, SoundEvents.SPLASH_POTION_BREAK, 1f, 0.6f);
			Fx.sound(level, at, SoundEvents.SLIME_SQUISH, 0.8f, 0.5f);
			if (!child) Fx.custom(level, at, "corruption_bolt", 1f, 1f);
			Set<UUID> touched = cloud(p, level, at, r, dur);
			Scheduler.later(dur, () -> {
				if (touched.size() >= 5) Mastery.feat(p, HeartType.CORRUPTION, "zero5");
			});
			Ctx cc = AbilityManager.ctx(p);
			if (!child && cc != null && cc.flag("corruption.rain")) {
				for (int i = 0; i < 4; i++) {
					double a = Math.PI / 2 * i + 0.4;
					bolt(cc, at.add(0, 0.6, 0), new Vec3(Math.cos(a) * 0.35, 0.55, Math.sin(a) * 0.35), true);
				}
			}
		});
		pr.launch();
	}

	private boolean plagueBolt(Ctx c) {
		bolt(c, c.eye().add(c.look().scale(0.7)).subtract(0, 0.2, 0), c.look().scale(1.3), false);
		Fx.sound(c.level, c.pos(), SoundEvents.WITCH_THROW, 1f, 0.6f);
		Fx.sound(c.level, c.pos(), SoundEvents.SPIDER_AMBIENT, 0.4f, 0.6f);
		return true;
	}

	private boolean rotGround(Ctx c) {
		ServerPlayer p = c.player;
		ServerLevel level = c.level;
		Vec3 aim = c.aimPoint(c.num("a2.range", 12.0));
		Vec3 g = KitUtil.groundBelow(level, aim.add(0, 1, 0), 8);
		Vec3 at = g == null ? aim : g;
		double r = c.num("a2.radius", 5.0);
		int dur = c.ticks("a2.duration", 6.0);
		boolean wither2 = c.flag("corruption.wither2"), mire = c.flag("corruption.mire");
		c.state.var("rotActive", 1);
		c.state.var("rotX", at.x);
		c.state.var("rotY", at.y);
		c.state.var("rotZ", at.z);
		c.state.var("rotR", r);
		Fx.sound(level, at, SoundEvents.SCULK_BLOCK_SPREAD, 1.5f, 0.5f);
		Fx.sound(level, at, SoundEvents.WITHER_AMBIENT, 0.4f, 1.6f);
		Fx.custom(level, at, "corruption_rot", 1.2f, 1f);
		Scheduler.repeat(0, 5, dur / 5, i -> {
			Ctx cc = AbilityManager.ctx(p);
			if (cc == null || cc.type != HeartType.CORRUPTION) return false;
			double grow = Math.min(1, (i + 1) / 4.0) * r;
			Fx.disc(level, Fx.dust(i % 2 == 0 ? PURPLE : BILE, 1.5f), at.add(0, 0.08, 0), grow, (int) (grow * 7));
			Fx.disc(level, ParticleTypes.SCULK_CHARGE_POP, at.add(0, 0.1, 0), grow, 5);
			Fx.ring(level, Fx.dust(GREEN, 1.2f), at.add(0, 0.1, 0), grow, (int) (grow * 6), i * 0.2);
			if (i % 4 == 0) Fx.at(level, ParticleTypes.SCULK_SOUL, at.add(0, 0.3, 0), 3, grow * 0.5, 0.1, grow * 0.5, 0.02);
			for (LivingEntity e : cc.enemies(at.add(0, 0.5, 0), grow)) {
				if (Math.abs(e.getY() - at.y) > 1.5) continue;
				Combat.debuff(e, MobEffects.WITHER, 30, wither2 ? 1 : 0, p);
				cc.control(e, MobEffects.SLOWNESS, 25, mire ? 1 : 0);
				if (i % 4 == 0) cc.rewardHit(e);
			}
			if (i == dur / 5 - 1) cc.state.var("rotActive", 0);
			return true;
		});
		return true;
	}

	private void infest(Ctx c, LivingEntity target, int generation) {
		ServerPlayer p = c.player;
		ServerLevel level = c.level;
		infected.put(target.getUUID(), generation);
		int fuse = c.flag("corruption.fuse") ? 60 : 80;
		Fx.sound(level, target.position(), SoundEvents.SILVERFISH_AMBIENT, 1f, 0.6f);
		Scheduler.repeat(0, 2, fuse / 2 + 1, i -> {
			if (!infected.containsKey(target.getUUID())) return false;
			Ctx cc = AbilityManager.ctx(p);
			if (cc == null || !target.isAlive()) {
				return false;
			}
			Vec3 at = target.position().add(0, target.getBbHeight() * 0.6, 0);
			Fx.at(level, Fx.dust(SICK, 1.0f), at, 3, 0.3, 0.4, 0.3, 0);
			Fx.at(level, ParticleTypes.SNEEZE, at, 1, 0.2, 0.01);
			int left = fuse - i * 2;
			if (left > 0 && (left <= 20 ? i % 2 == 0 : i % 6 == 0)) Fx.sound(level, at, SoundEvents.NOTE_BLOCK_BASEDRUM.value(), 0.6f, 2f - left / 60f);
			if (left <= 0) {
				infected.remove(target.getUUID());
				burst(cc, target, generation);
				return false;
			}
			return true;
		});
	}

	private void burst(Ctx c, LivingEntity target, int generation) {
		ServerLevel level = c.level;
		Vec3 at = target.position().add(0, target.getBbHeight() / 2, 0);
		double r = c.num("a3.radius", 3.0);
		float dmg = c.dmg("a3.damage", 6.0);
		Fx.sphere(level, Fx.dust(GREEN, 2f), at, r * 0.6, 70);
		Fx.at(level, Fx.dust(PURPLE, 2.2f), at, 40, r * 0.4, 0);
		Fx.at(level, ParticleTypes.EXPLOSION, at, 1, 0, 0);
		Fx.sound(level, at, SoundEvents.SLIME_DEATH, 1.2f, 0.5f);
		Fx.sound(level, at, SoundEvents.GENERIC_EXPLODE, 0.6f, 1.4f);
		Fx.custom(level, at, "corruption_burst", 1.2f, 1f);
		c.hit(target, dmg);
		Combat.debuff(target, MobEffects.POISON, 80, 1, c.player);
		int others = 0;
		LivingEntity nearest = null;
		for (LivingEntity e : c.enemies(at, r)) {
			if (e == target) continue;
			if (c.hit(e, dmg * 0.75f)) others++;
			Combat.debuff(e, MobEffects.POISON, 80, 1, c.player);
			if (nearest == null) nearest = e;
			if (c.flag("corruption.blackdeath") && generation < 1 && !infected.containsKey(e.getUUID())) infest(c, e, generation + 1);
		}
		if (others + 1 >= 3) Mastery.feat(c.player, c.type, "burst3");
		if (c.flag("corruption.carrier") && generation < 2 && nearest != null && !infected.containsKey(nearest.getUUID())) {
			Fx.line(level, Fx.dust(SICK, 1.2f), at, nearest.position().add(0, 1, 0), 0.4);
			infest(c, nearest, generation + 1);
		}
	}

	private boolean infestCast(Ctx c) {
		LivingEntity target = c.aimEntity(c.num("a3.range", 16.0), 1.0);
		if (target == null) {
			Fx.actionBar(c.player, Component.literal("No host in sight.").withStyle(ChatFormatting.GRAY));
			return false;
		}
		Fx.line(c.level, Fx.dust(GREEN, 1.2f), c.eye(), target.getEyePosition(), 0.3);
		Fx.sound(c.level, c.pos(), SoundEvents.EVOKER_CAST_SPELL, 0.8f, 0.6f);
		Fx.custom(c.level, c.pos(), "corruption_infest", 1f, 1f);
		if (target instanceof ServerPlayer sp) Fx.title(sp, Component.empty(), Component.literal("You have been infested").withStyle(ChatFormatting.DARK_GREEN), 2, 30, 8);
		c.rewardHit(target);
		infest(c, target, 0);
		return true;
	}

	private boolean pandemic(Ctx c) {
		ServerPlayer p = c.player;
		ServerLevel level = c.level;
		List<LivingEntity> targets = c.enemies(c.pos(), c.num("a4.radius", 15.0));
		int n = 0;
		for (LivingEntity e : targets) {
			if (infected.containsKey(e.getUUID())) continue;
			final int delay = n * 3;
			Scheduler.later(1 + delay, () -> {
				Ctx cc = AbilityManager.ctx(p);
				if (cc != null && e.isAlive()) {
					Fx.line(level, Fx.dust(GREEN, 1f), cc.center(), e.position().add(0, 1, 0), 0.5);
					infest(cc, e, 0);
				}
			});
			n++;
		}
		if (n >= 5) Mastery.feat(p, c.type, "outbreak5");
		int minions = 3 + (c.flag("corruption.brood") ? 2 : 0);
		int life = (int) (c.ticks("a4.duration", 15.0) * (c.flag("corruption.hive") ? 1.5 : 1));
		for (int i = 0; i < minions; i++) {
			double a = Math.PI * 2 * i / minions;
			Vec3 spot = c.pos().add(Math.cos(a) * 2, 0, Math.sin(a) * 2);
			Scheduler.later(5 + i * 4, () -> raise(p, level, spot, life));
		}
		Fx.far(level, ParticleTypes.EXPLOSION_EMITTER, c.center(), 1, 0, 0);
		Fx.shockRing(level, Fx.dust(GREEN, 2.2f), c.pos().add(0, 0.2, 0), 0.5, 60, 0.6);
		Fx.sound(level, c.pos(), SoundEvents.WITHER_SPAWN, 0.6f, 1.4f);
		Fx.sound(level, c.pos(), SoundEvents.ZOMBIE_INFECT, 1.5f, 0.5f);
		Fx.custom(level, c.pos(), "corruption_pandemic", 2f, 1f);
		Fx.title(p, Component.empty(), Component.literal("☣ Pandemic").withStyle(c.type.style().withBold(true)), 2, 30, 10);
		return true;
	}

	private void raise(ServerPlayer owner, ServerLevel level, Vec3 spot, int life) {
		Ctx c = AbilityManager.ctx(owner);
		if (c == null) return;
		Vec3 g = KitUtil.groundBelow(level, spot.add(0, 2, 0), 5);
		Vec3 at = g == null ? spot : g;
		if (!KitUtil.safeSpot(level, at)) at = owner.position();
		Husk m = EntityType.HUSK.create(level, EntitySpawnReason.MOB_SUMMONED);
		if (m == null) return;
		m.snapTo(at.x, at.y, at.z, level.random.nextFloat() * 360, 0);
		m.setCustomName(Component.literal("Rotling").withStyle(ChatFormatting.DARK_GREEN));
		m.addTag("chaoshearts.ally." + owner.getUUID());
		Displays.track(m);
		m.setItemSlot(EquipmentSlot.HEAD, new ItemStack(Items.MOSS_CARPET));
		m.setDropChance(EquipmentSlot.HEAD, 0);
		m.setDropChance(EquipmentSlot.MAINHAND, 0);
		var scale = m.getAttribute(Attributes.SCALE);
		if (scale != null) scale.setBaseValue(0.85);
		m.setPersistenceRequired();
		m.addEffect(new MobEffectInstance(MobEffects.SPEED, life, 0, false, false));
		level.addFreshEntity(m);
		Fx.at(level, Fx.dust(PURPLE, 1.8f), at.add(0, 1, 0), 30, 0.4, 0.8, 0.4, 0);
		KitUtil.debris(level, at, 0.6, 30);
		Fx.sound(level, at, SoundEvents.ZOMBIE_AMBIENT, 1f, 0.6f);
		Scheduler.repeat(0, 10, life / 10, i -> {
			if (!m.isAlive()) {
				Ctx cc = AbilityManager.ctx(owner);
				if (cc != null && cc.flag("corruption.hive")) cloud(owner, level, m.position(), 2.5, 60);
				return false;
			}
			Ctx cc = AbilityManager.ctx(owner);
			if (cc == null) {
				m.discard();
				return false;
			}
			// Follow orders: attack the summoner's enemies, never the summoner.
			LivingEntity tgt = m.getTarget();
			if (tgt == null || !tgt.isAlive() || tgt == owner || !Combat.canTarget(owner, tgt)) {
				List<LivingEntity> near = cc.enemies(m.position(), 12);
				near.removeIf(e -> e.getTags().contains("chaoshearts.ally." + owner.getUUID()));
				m.setTarget(near.isEmpty() ? null : near.get(0));
				if (near.isEmpty() && m.distanceTo(owner) > 6) m.getNavigation().moveTo(owner, 1.2);
			}
			Fx.at(level, Fx.dust(GREEN, 0.9f), m.position().add(0, 1, 0), 2, 0.2, 0.4, 0.2, 0);
			if (i == life / 10 - 1) {
				Fx.at(level, ParticleTypes.SCULK_SOUL, m.position().add(0, 1, 0), 12, 0.3, 0.05);
				if (cc.flag("corruption.hive")) cloud(owner, level, m.position(), 2.5, 60);
				m.discard();
				return false;
			}
			return true;
		});
	}
}
