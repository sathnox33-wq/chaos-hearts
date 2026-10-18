package net.chaoshearts.ability;

import java.util.ArrayList;
import java.util.List;

import net.chaoshearts.ChaosHearts;
import net.chaoshearts.heart.HeartType;
import net.chaoshearts.skill.SkillTree;
import net.minecraft.core.Holder;
import net.minecraft.resources.Identifier;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.entity.LivingEntity;
import net.minecraft.world.entity.ai.attributes.Attribute;
import net.minecraft.world.entity.ai.attributes.AttributeInstance;
import net.minecraft.world.entity.ai.attributes.AttributeModifier;

/**
 * A heart's whole kit: four abilities, two passives plus the awakened passive, its feats and
 * skill tree, and hooks into combat. One instance per heart type, stateless (state lives in
 * {@link PlayerState}).
 */
public abstract class HeartKit {
	public record Feat(String id, String name, String description, int xp) {}

	public final HeartType type;
	private final Ability[] abilities = new Ability[4];
	private final List<Feat> feats = new ArrayList<>();
	private final List<Identifier> modifierIds = new ArrayList<>();

	protected HeartKit(HeartType type) {
		this.type = type;
	}

	protected final void ability(int slot, String name, String description, double cooldown, Ability.Caster caster) {
		abilities[slot] = new Ability("a" + (slot + 1), name, description, slot, cooldown, caster);
	}

	protected final void feat(String id, String name, String description, int xp) {
		feats.add(new Feat(id, name, description, xp));
	}

	public final Ability ability(int slot) {
		return abilities[slot];
	}

	public final List<Feat> feats() {
		return feats;
	}

	public final Feat feat(String id) {
		for (Feat f : feats) if (f.id().equals(id)) return f;
		return null;
	}

	public abstract String passive1Name();

	public abstract String passive1Description();

	public abstract String passive2Name();

	public abstract String passive2Description();

	public abstract String awakenedName();

	public abstract String awakenedDescription();

	public abstract SkillTree tree();

	// ---------------------------------------------------------------- hooks (all optional)

	/** Every tick while this heart is the player's active heart. */
	public void tick(Ctx c, long tick) {}

	/** Ambient aura particles, called every 4 ticks from mastery 90 or when awakened. */
	public void aura(Ctx c, long tick) {}

	/** Damage the owner deals to target (melee or ability). Return the new amount. */
	public float outgoing(Ctx c, LivingEntity target, DamageSource source, float amount) {
		return amount;
	}

	/** Damage the owner takes. Return the new amount. */
	public float incoming(Ctx c, DamageSource source, float amount) {
		return amount;
	}

	/** After the owner damaged target. ability is true when an ability dealt it. */
	public void afterHit(Ctx c, LivingEntity target, float amount, boolean ability) {}

	/** After the owner took damage. */
	public void afterHurt(Ctx c, DamageSource source, float amount) {}

	public void onKill(Ctx c, LivingEntity victim) {}

	/** Lethal damage is about to kill the owner. Return true to keep them alive (and heal them yourself). */
	public boolean preventDeath(Ctx c, DamageSource source) {
		return false;
	}

	/** Extra action-bar segment, such as a meter. */
	public String hud(Ctx c, long tick) {
		return null;
	}

	/** Called when the heart stops being active (swap, loss, logout). Remove lasting effects here. */
	public void deactivate(ServerPlayer p) {
		for (Identifier id : modifierIds) removeModifierEverywhere(p, id);
	}

	// ---------------------------------------------------------------- attribute helpers

	protected final Identifier modifierId(String name) {
		Identifier id = ChaosHearts.id(type.id() + "_" + name);
		if (!modifierIds.contains(id)) modifierIds.add(id);
		return id;
	}

	/** Keeps a transient attribute modifier at the given amount (adds, updates or removes when amount is 0). */
	protected static void keepModifier(ServerPlayer p, Holder<Attribute> attr, Identifier id, double amount, AttributeModifier.Operation op) {
		AttributeInstance inst = p.getAttribute(attr);
		if (inst == null) return;
		AttributeModifier existing = inst.getModifier(id);
		if (amount == 0) {
			if (existing != null) inst.removeModifier(id);
			return;
		}
		if (existing != null && existing.amount() == amount && existing.operation() == op) return;
		if (existing != null) inst.removeModifier(id);
		inst.addTransientModifier(new AttributeModifier(id, amount, op));
	}

	private static void removeModifierEverywhere(ServerPlayer p, Identifier id) {
		for (Holder<Attribute> a : TRACKED_ATTRIBUTES) {
			AttributeInstance inst = p.getAttribute(a);
			if (inst != null && inst.getModifier(id) != null) inst.removeModifier(id);
		}
		if (p.getHealth() > p.getMaxHealth()) p.setHealth(p.getMaxHealth());
	}

	private static final List<Holder<Attribute>> TRACKED_ATTRIBUTES = List.of(
			net.minecraft.world.entity.ai.attributes.Attributes.MAX_HEALTH,
			net.minecraft.world.entity.ai.attributes.Attributes.MOVEMENT_SPEED,
			net.minecraft.world.entity.ai.attributes.Attributes.ATTACK_DAMAGE,
			net.minecraft.world.entity.ai.attributes.Attributes.ATTACK_SPEED,
			net.minecraft.world.entity.ai.attributes.Attributes.KNOCKBACK_RESISTANCE,
			net.minecraft.world.entity.ai.attributes.Attributes.SCALE,
			net.minecraft.world.entity.ai.attributes.Attributes.ENTITY_INTERACTION_RANGE,
			net.minecraft.world.entity.ai.attributes.Attributes.BLOCK_INTERACTION_RANGE,
			net.minecraft.world.entity.ai.attributes.Attributes.ARMOR,
			net.minecraft.world.entity.ai.attributes.Attributes.STEP_HEIGHT,
			net.minecraft.world.entity.ai.attributes.Attributes.SAFE_FALL_DISTANCE,
			net.minecraft.world.entity.ai.attributes.Attributes.JUMP_STRENGTH,
			net.minecraft.world.entity.ai.attributes.Attributes.GRAVITY);
}
