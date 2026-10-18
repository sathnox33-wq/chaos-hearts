package net.chaoshearts.combat;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import net.chaoshearts.ChaosHearts;
import net.chaoshearts.config.ChaosConfig;
import net.chaoshearts.eye.EyeManager;
import net.minecraft.core.Holder;
import net.minecraft.core.registries.Registries;
import net.minecraft.resources.ResourceKey;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.damagesource.DamageType;
import net.minecraft.world.effect.MobEffect;
import net.minecraft.world.effect.MobEffectInstance;
import net.minecraft.world.entity.Entity;
import net.minecraft.world.entity.LivingEntity;
import net.minecraft.world.entity.OwnableEntity;
import net.minecraft.world.entity.decoration.ArmorStand;
import net.minecraft.world.entity.player.Player;

/** Damage, combat tags and crowd-control rules shared by all abilities. */
public final class Combat {
	public static final ResourceKey<DamageType> ABILITY = ResourceKey.create(Registries.DAMAGE_TYPE, ChaosHearts.id("ability"));
	public static final ResourceKey<DamageType> TRUE_DAMAGE = ResourceKey.create(Registries.DAMAGE_TYPE, ChaosHearts.id("bleed"));

	private record Tag(UUID attacker, long untilMillis) {}

	private static final Map<UUID, Tag> TAGS = new HashMap<>();
	/** player -> effect id -> epoch ms until which that control cannot be reapplied. */
	private static final Map<UUID, Map<String, Long>> CC_IMMUNE = new HashMap<>();

	/** Set while an ability is dealing damage, so damage hooks know the source was an ability. */
	private static int abilityDepth;

	private Combat() {}

	public static boolean inAbilityDamage() {
		return abilityDepth > 0;
	}

	// ---------------------------------------------------------------- combat tag

	public static void tag(ServerPlayer victim, ServerPlayer attacker) {
		if (victim == attacker) return;
		long until = System.currentTimeMillis() + ChaosConfig.get().combatTagSeconds * 1000L;
		TAGS.put(victim.getUUID(), new Tag(attacker.getUUID(), until));
		TAGS.put(attacker.getUUID(), new Tag(victim.getUUID(), until));
	}

	public static boolean isTagged(ServerPlayer p) {
		Tag t = TAGS.get(p.getUUID());
		return t != null && t.untilMillis > System.currentTimeMillis();
	}

	/** The last player who hit this player within the combat window, if any. */
	public static UUID lastAttacker(UUID player) {
		Tag t = TAGS.get(player);
		return t != null && t.untilMillis > System.currentTimeMillis() ? t.attacker : null;
	}

	public static void clearTag(UUID player) {
		TAGS.remove(player);
	}

	// ---------------------------------------------------------------- targeting

	/** Whether an ability cast by caster may affect target. */
	public static boolean canTarget(ServerPlayer caster, Entity e) {
		if (!(e instanceof LivingEntity le) || e == caster || !le.isAlive()) return false;
		if (e.isSpectator() || e.isInvulnerable()) return false;
		if (e instanceof ArmorStand as && as.isMarker()) return false;
		if (e instanceof Player pl && (pl.isCreative() || EyeManager.isEye(pl))) return false;
		if (caster.isAlliedTo(e)) return false;
		if (e instanceof OwnableEntity own && own.getOwner() == caster) return false;
		if (e.getTags().contains("chaoshearts.decoy." + caster.getUUID())) return false;
		if (e.getTags().contains("chaoshearts.ally." + caster.getUUID())) return false;
		return true;
	}

	// ---------------------------------------------------------------- damage

	public static DamageSource source(ServerLevel level, ResourceKey<DamageType> type, Entity direct, Entity causing) {
		Holder<DamageType> h = level.registryAccess().lookupOrThrow(Registries.DAMAGE_TYPE).getOrThrow(type);
		return new DamageSource(h, direct, causing);
	}

	/**
	 * Deals ability damage from caster to target. Applies the global multiplier and the PvP
	 * multiplier. Returns true if the target took damage.
	 */
	public static boolean damage(ServerPlayer caster, LivingEntity target, float amount, boolean trueDamage) {
		if (amount <= 0 || !target.isAlive()) return false;
		var cfg = ChaosConfig.get();
		float a = (float) (amount * cfg.abilityDamageMultiplier);
		if (target instanceof Player) a *= (float) cfg.pvpDamageMultiplier;
		ServerLevel level = (ServerLevel) target.level();
		DamageSource src = source(level, trueDamage ? TRUE_DAMAGE : ABILITY, caster, caster);
		float before = target.getHealth() + target.getAbsorptionAmount();
		// Abilities hit through the normal invulnerability window so combos land.
		int savedInvul = target.invulnerableTime;
		target.invulnerableTime = 0;
		abilityDepth++;
		boolean hurt;
		try {
			hurt = target.hurtServer(level, src, a);
		} finally {
			abilityDepth--;
		}
		if (!hurt) target.invulnerableTime = savedInvul;
		return hurt && target.getHealth() + target.getAbsorptionAmount() < before;
	}

	// ---------------------------------------------------------------- crowd control

	/**
	 * Applies a harmful effect. On players the duration is scaled and a short immunity to the same
	 * effect follows, so control cannot be chained forever.
	 */
	public static boolean control(LivingEntity target, Holder<MobEffect> effect, int ticks, int amplifier, Entity source) {
		if (target instanceof ServerPlayer p) {
			var cfg = ChaosConfig.get();
			String key = effect.getRegisteredName();
			Map<String, Long> imm = CC_IMMUNE.computeIfAbsent(p.getUUID(), u -> new HashMap<>());
			long now = System.currentTimeMillis();
			Long until = imm.get(key);
			if (until != null && until > now) return false;
			ticks = Math.max(10, (int) (ticks * cfg.pvpCrowdControlMultiplier));
			imm.put(key, now + ticks * 50L + cfg.crowdControlImmunitySeconds * 1000L);
		}
		return target.addEffect(new MobEffectInstance(effect, ticks, amplifier, false, true, true), source);
	}

	/** A short debuff that is not crowd control (no immunity bookkeeping). */
	public static void debuff(LivingEntity target, Holder<MobEffect> effect, int ticks, int amplifier, Entity source) {
		target.addEffect(new MobEffectInstance(effect, ticks, amplifier, false, true, true), source);
	}

	public static void buff(LivingEntity target, Holder<MobEffect> effect, int ticks, int amplifier) {
		target.addEffect(new MobEffectInstance(effect, ticks, amplifier, false, false, true));
	}

	public static void forget(UUID player) {
		CC_IMMUNE.remove(player);
	}
}
