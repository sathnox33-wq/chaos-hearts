package net.chaoshearts.skill;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import net.chaoshearts.ability.AbilityManager;
import net.chaoshearts.ability.HeartKits;
import net.chaoshearts.config.ChaosConfig;
import net.chaoshearts.data.DataStore;
import net.chaoshearts.data.PlayerData;
import net.chaoshearts.heart.HeartType;
import net.minecraft.server.level.ServerPlayer;

/** Skill points, unlocking, respecs and the cached modifier sets abilities read. */
public final class SkillManager {
	private static final Map<UUID, Map<HeartType, SkillSet>> CACHE = new HashMap<>();

	public enum Result { OK, NOT_AWAKENED, UNKNOWN, OWNED, LOCKED, CAPSTONE_TAKEN, NO_POINTS }

	private SkillManager() {}

	public static int totalPoints(PlayerData.HeartProgress prog) {
		if (!prog.awakened) return 0;
		var cfg = ChaosConfig.get();
		long asc = Math.max(0, prog.xp - prog.awakenedAtXp);
		long pts = cfg.skillPointsOnAwaken + asc / Math.max(1, cfg.ascensionXpPerPoint) + prog.bonusPoints;
		return (int) Math.min(cfg.maxSkillPoints + prog.bonusPoints, pts);
	}

	public static int spent(HeartType type, PlayerData.HeartProgress prog) {
		SkillTree tree = HeartKits.get(type).tree();
		int s = 0;
		for (String id : prog.nodes) {
			SkillNode n = tree.get(id);
			if (n != null) s += n.cost;
		}
		return s;
	}

	public static int available(HeartType type, PlayerData.HeartProgress prog) {
		return totalPoints(prog) - spent(type, prog);
	}

	/** XP until the next ascension point, or -1 at the cap. */
	public static long xpToNextPoint(PlayerData.HeartProgress prog) {
		var cfg = ChaosConfig.get();
		if (!prog.awakened || totalPoints(prog) >= cfg.maxSkillPoints + prog.bonusPoints) return -1;
		long per = Math.max(1, cfg.ascensionXpPerPoint);
		long asc = Math.max(0, prog.xp - prog.awakenedAtXp);
		return per - asc % per;
	}

	public static Result check(PlayerData.HeartProgress prog, HeartType type, String nodeId) {
		if (!prog.awakened) return Result.NOT_AWAKENED;
		SkillTree tree = HeartKits.get(type).tree();
		SkillNode n = tree.get(nodeId);
		if (n == null) return Result.UNKNOWN;
		if (prog.nodes.contains(nodeId)) return Result.OWNED;
		SkillNode prev = tree.previous(n);
		if (prev != null && !prog.nodes.contains(prev.id)) return Result.LOCKED;
		if (n.capstone) {
			for (String id : prog.nodes) {
				SkillNode o = tree.get(id);
				if (o != null && o.capstone) return Result.CAPSTONE_TAKEN;
			}
		}
		if (available(type, prog) < n.cost) return Result.NO_POINTS;
		return Result.OK;
	}

	public static Result unlock(ServerPlayer p, HeartType type, String nodeId) {
		PlayerData.HeartProgress prog = DataStore.get(p).progress(type);
		Result r = check(prog, type, nodeId);
		if (r != Result.OK) return r;
		prog.nodes.add(nodeId);
		invalidate(p.getUUID());
		DataStore.markDirty();
		AbilityManager.refreshFocus(p);
		return Result.OK;
	}

	/** Returns null on success or the reason it was refused. */
	public static String respec(ServerPlayer p, HeartType type, boolean free) {
		PlayerData.HeartProgress prog = DataStore.get(p).progress(type);
		if (prog.nodes.isEmpty()) return "You have not spent any points on this heart.";
		var cfg = ChaosConfig.get();
		long now = System.currentTimeMillis();
		if (!free && prog.respecs > 0) {
			long next = prog.lastRespecMillis + cfg.respecCooldownHours * 3600_000L;
			if (now < next) {
				long mins = (next - now) / 60000;
				return "You can reset this tree again in " + (mins / 60) + "h " + (mins % 60) + "m.";
			}
			if (p.experienceLevel < cfg.respecCostLevels && !p.isCreative()) return "Resetting costs " + cfg.respecCostLevels + " experience levels.";
			if (!p.isCreative()) p.giveExperienceLevels(-cfg.respecCostLevels);
		}
		prog.nodes.clear();
		prog.respecs++;
		prog.lastRespecMillis = now;
		invalidate(p.getUUID());
		DataStore.markDirty();
		AbilityManager.refreshFocus(p);
		return null;
	}

	public static SkillSet set(UUID player, HeartType type) {
		if (type == null) return SkillSet.EMPTY;
		return CACHE.computeIfAbsent(player, u -> new HashMap<>()).computeIfAbsent(type, t -> build(player, t));
	}

	private static SkillSet build(UUID player, HeartType type) {
		PlayerData pd = DataStore.find(player);
		if (pd == null) return SkillSet.EMPTY;
		PlayerData.HeartProgress prog = pd.progress(type);
		if (!prog.awakened || prog.nodes.isEmpty()) return SkillSet.EMPTY;
		SkillTree tree = HeartKits.get(type).tree();
		Map<String, Double> mods = new HashMap<>();
		Set<String> flags = new HashSet<>();
		for (String id : prog.nodes) {
			SkillNode n = tree.get(id);
			if (n == null) continue;
			n.mods.forEach((k, v) -> mods.merge(k, v, Double::sum));
			flags.addAll(n.flags);
		}
		return new SkillSet(mods, flags);
	}

	public static void invalidate(UUID player) {
		CACHE.remove(player);
	}
}
