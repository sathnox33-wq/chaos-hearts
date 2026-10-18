package net.chaoshearts.skill;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Three branches of four nodes plus a capstone each. Nodes in a branch unlock in order; only
 * one capstone per tree.
 */
public final class SkillTree {
	public record Branch(String name, String description, int color, List<SkillNode> nodes) {}

	private final List<Branch> branches = new ArrayList<>();
	private final Map<String, SkillNode> byId = new LinkedHashMap<>();
	private final String prefix;

	public SkillTree(String prefix) {
		this.prefix = prefix;
	}

	/** Costs follow the standard 1/2/2/3 + capstone 4 shape. */
	public SkillTree branch(String name, String description, int color, SkillNode... nodes) {
		List<SkillNode> list = List.of(nodes);
		int b = branches.size();
		for (int i = 0; i < list.size(); i++) {
			SkillNode n = list.get(i);
			n.branch = b;
			n.tier = i;
			byId.put(n.id, n);
		}
		branches.add(new Branch(name, description, color, list));
		return this;
	}

	public static int standardCost(int tier) {
		return switch (tier) {
			case 0 -> 1;
			case 1, 2 -> 2;
			case 3 -> 3;
			default -> 4;
		};
	}

	/** Shorthand used by the kits: node(tier, key, name, description). */
	public SkillNode node(int tier, String key, String name, String description) {
		return new SkillNode(prefix + "." + key, name, description, standardCost(tier), tier == 4);
	}

	public List<Branch> branches() {
		return branches;
	}

	public SkillNode get(String id) {
		return byId.get(id);
	}

	public SkillNode previous(SkillNode n) {
		if (n.tier == 0) return null;
		return branches.get(n.branch).nodes().get(n.tier - 1);
	}
}
