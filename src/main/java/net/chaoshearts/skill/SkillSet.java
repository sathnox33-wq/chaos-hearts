package net.chaoshearts.skill;

import java.util.Map;
import java.util.Set;

/** The summed modifiers and flags of the nodes a player unlocked for one heart. */
public record SkillSet(Map<String, Double> mods, Set<String> flags) {
	public static final SkillSet EMPTY = new SkillSet(Map.of(), Set.of());

	public double mod(String key) {
		return mods.getOrDefault(key, 0.0);
	}

	public boolean flag(String flag) {
		return flags.contains(flag);
	}
}
