package net.chaoshearts.data;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import net.chaoshearts.heart.HeartType;

/** Everything the mod remembers about one player. Serialized with Gson. */
public final class PlayerData {
	public UUID uuid;
	public String lastName = "";
	public boolean starterGiven;

	/** Hearts this player holds, oldest first. The last entry is the most recently acquired. */
	public List<OwnedHeart> hearts = new ArrayList<>();
	public HeartType active;
	public long lastSwapMillis;

	public Map<HeartType, HeartProgress> progress = new HashMap<>();

	public String xpDay = "";
	public long xpToday;

	/** victim uuid -> epoch ms of the last PvP kill that granted mastery. */
	public Map<UUID, Long> pvpKillTimes = new HashMap<>();

	public TrialReturn trialReturn;
	public long trialRetryAtMillis;

	public boolean eyeActive;
	/** Messages to show the next time the player is online. */
	public List<String> pendingMessages = new ArrayList<>();

	public static final class OwnedHeart {
		public UUID heartId;
		public HeartType type;
		public long acquiredAt;

		public OwnedHeart() {}

		public OwnedHeart(UUID heartId, HeartType type, long acquiredAt) {
			this.heartId = heartId;
			this.type = type;
			this.acquiredAt = acquiredAt;
		}
	}

	public static final class HeartProgress {
		/** Total mastery XP ever earned for this heart type, including after level 100. */
		public long xp;
		public boolean awakened;
		/** Skill node ids unlocked. */
		public Set<String> nodes = new LinkedHashSet<>();
		public int bonusPoints;
		public Set<String> feats = new LinkedHashSet<>();
		public Map<String, Long> counters = new HashMap<>();
		public long awakenedAtXp;
		public long bestTrialMillis;
		public int respecs;
		public long lastRespecMillis;
	}

	/** Where to put a player back after a trial. */
	public static final class TrialReturn {
		public String dimension;
		public double x, y, z;
		public float yaw, pitch;
		public String gameMode;
		public String heart;
	}

	public HeartProgress progress(HeartType type) {
		return progress.computeIfAbsent(type, t -> new HeartProgress());
	}

	public boolean owns(HeartType type) {
		for (OwnedHeart h : hearts) if (h.type == type) return true;
		return false;
	}

	public OwnedHeart latest() {
		return hearts.isEmpty() ? null : hearts.get(hearts.size() - 1);
	}

	public void sanitize() {
		if (hearts == null) hearts = new ArrayList<>();
		hearts.removeIf(h -> h == null || h.type == null || h.heartId == null);
		hearts.sort((a, b) -> Long.compare(a.acquiredAt, b.acquiredAt));
		if (progress == null) progress = new HashMap<>();
		progress.values().forEach(p -> {
			if (p.nodes == null) p.nodes = new LinkedHashSet<>();
			if (p.feats == null) p.feats = new LinkedHashSet<>();
			if (p.counters == null) p.counters = new HashMap<>();
		});
		if (pvpKillTimes == null) pvpKillTimes = new HashMap<>();
		if (pendingMessages == null) pendingMessages = new ArrayList<>();
		if (active != null && !owns(active)) active = null;
		if (active == null && !hearts.isEmpty()) active = latest().type;
	}
}
