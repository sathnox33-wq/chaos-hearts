package net.chaoshearts.skill;

import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.Map;
import java.util.Set;

/**
 * One node of a heart's tree. Modifiers are fractions applied to the matching ability number
 * ("a1.damage" 0.2 = +20%, "a1.cooldown" -0.2 = 20% shorter). Flags switch on special behaviour
 * that the ability code checks.
 */
public final class SkillNode {
	public final String id;
	public final String name;
	public final String description;
	public final int cost;
	public final boolean capstone;
	public final Map<String, Double> mods = new LinkedHashMap<>();
	public final Set<String> flags = new LinkedHashSet<>();
	int branch;
	int tier;

	public SkillNode(String id, String name, String description, int cost, boolean capstone) {
		this.id = id;
		this.name = name;
		this.description = description;
		this.cost = cost;
		this.capstone = capstone;
	}

	public SkillNode mod(String key, double value) {
		mods.merge(key, value, Double::sum);
		return this;
	}

	public SkillNode flag(String f) {
		flags.add(f);
		return this;
	}

	public int branch() {
		return branch;
	}

	public int tier() {
		return tier;
	}
}
