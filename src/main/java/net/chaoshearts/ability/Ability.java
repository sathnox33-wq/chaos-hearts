package net.chaoshearts.ability;

import net.chaoshearts.mastery.Mastery;

/**
 * One castable ability. Slot 0..3 maps to right-click, sneak + right-click, swap-hands and
 * sneak + swap-hands. Every number an ability uses goes through {@link Ctx#num}.
 */
public final class Ability {
	@FunctionalInterface
	public interface Caster {
		/** Returns false if nothing happened (no target, blocked); no cooldown is spent then. */
		boolean cast(Ctx c);
	}

	private final String key;
	private final String name;
	private final String description;
	private final int slot;
	private final double cooldownSeconds;
	private final Caster caster;

	public Ability(String key, String name, String description, int slot, double cooldownSeconds, Caster caster) {
		this.key = key;
		this.name = name;
		this.description = description;
		this.slot = slot;
		this.cooldownSeconds = cooldownSeconds;
		this.caster = caster;
	}

	/** "a1".."a4". */
	public String key() {
		return key;
	}

	public String name() {
		return name;
	}

	public String description() {
		return description;
	}

	public int slot() {
		return slot;
	}

	public int unlockLevel() {
		return switch (slot) {
			case 0 -> 0;
			case 1 -> Mastery.LVL_A2;
			case 2 -> Mastery.LVL_A3;
			default -> Mastery.LVL_ULT;
		};
	}

	public double baseCooldown() {
		return cooldownSeconds;
	}

	public boolean cast(Ctx c) {
		return caster.cast(c);
	}
}
