package net.chaoshearts.config;

import java.io.IOException;
import java.io.Reader;
import java.io.Writer;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.Map;
import java.util.TreeMap;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import net.chaoshearts.ChaosHearts;
import net.fabricmc.loader.api.FabricLoader;

/**
 * All tunable values. Lives in config/chaoshearts.json. Unknown keys are kept, missing keys are
 * filled with defaults the first time the game asks for them, so the file always lists every
 * number the mod uses.
 */
public final class ChaosConfig {
	private static final Gson GSON = new GsonBuilder().setPrettyPrinting().disableHtmlEscaping().create();
	private static Values values = new Values();
	private static boolean dirty;

	public static final class Values {
		// --- Ownership ---
		/** "random": every new player gets one random heart on first join. "none": nobody starts with one. */
		public String starterMode = "random";
		/** When true each heart type exists at most once on the server. */
		public boolean uniqueHearts = false;
		/** 0 = unlimited. */
		public int maxHeartsPerPlayer = 0;
		/** How long only the killer can collect a dropped heart before it returns to its previous owner. */
		public int collectWindowSeconds = 300;
		public int combatTagSeconds = 15;
		/** "drop_heart", "kill" or "off". */
		public String combatLogAction = "drop_heart";
		public int heartSwapCooldownSeconds = 30;

		// --- Mastery ---
		public double masteryXpMultiplier = 1.0;
		public int dailySoftCap = 2500;
		public double softCapMultiplier = 0.25;
		public int xpAbilityHitPlayer = 15;
		public int xpAbilityHitMob = 5;
		public int xpAbilityKillMob = 8;
		public int xpPvpKill = 150;
		public int pvpKillRepeatMinutes = 30;
		public int xpBossKill = 400;
		public int sameTargetWindowSeconds = 60;

		// --- PvP balance ---
		public double pvpDamageMultiplier = 0.75;
		public double pvpCrowdControlMultiplier = 0.5;
		public int crowdControlImmunitySeconds = 3;
		public double abilityDamageMultiplier = 1.0;
		public double cooldownMultiplier = 1.0;
		public double maxSkillDamageBonus = 0.40;

		// --- Skill trees ---
		public int skillPointsOnAwaken = 3;
		public int ascensionXpPerPoint = 1000;
		public int maxSkillPoints = 15;
		public int respecCostLevels = 20;
		public int respecCooldownHours = 24;

		// --- Trials ---
		public int trialRetryCooldownMinutes = 10;
		public double trialDifficulty = 1.0;
		public int trialTimeLimitMinutes = 15;
		/** Blocks placed per tick while building or clearing an arena. */
		public int trialBuildBlocksPerTick = 6000;

		// --- Resource pack ---
		/** Host the bundled resource pack from the mod's own HTTP server and offer it on join. */
		public boolean packServeBuiltin = true;
		public int packPort = 25580;
		/** Address players use to reach the pack, e.g. http://play.example.com:25580/pack.zip. Leave blank to use server-ip. */
		public String packPublicUrl = "";
		/** Offer an externally hosted pack instead (needs packSha1). */
		public String packExternalUrl = "";
		public String packExternalSha1 = "";
		public boolean packRequired = false;

		// --- The Eye ---
		public double eyeDefaultScale = 4.0;
		public float eyeFlySpeed = 0.08f;
		/** Players within this many blocks of the Eye are wrapped in darkness. 0 turns it off. */
		public double eyeShroudRadius = 20;
		/** Turn the eye model if your resource pack's model faces another way. */
		public float eyeModelYawOffset = 0f;

		/** Every ability number, keyed like "rage.a1.cooldown". */
		public Map<String, Double> balance = new TreeMap<>();
	}

	private ChaosConfig() {}

	public static Values get() {
		return values;
	}

	private static Path path() {
		return FabricLoader.getInstance().getConfigDir().resolve("chaoshearts.json");
	}

	public static void load() {
		Path p = path();
		if (Files.exists(p)) {
			try (Reader r = Files.newBufferedReader(p, StandardCharsets.UTF_8)) {
				Values v = GSON.fromJson(r, Values.class);
				if (v != null) {
					if (v.balance == null) v.balance = new TreeMap<>();
					else v.balance = new TreeMap<>(v.balance);
					values = v;
				}
			} catch (Exception e) {
				ChaosHearts.LOGGER.error("Could not read {}, using defaults (the broken file is kept as .broken)", p, e);
				try {
					Files.copy(p, p.resolveSibling("chaoshearts.json.broken"), StandardCopyOption.REPLACE_EXISTING);
				} catch (IOException ignored) {
				}
				values = new Values();
			}
		}
		dirty = true;
		saveIfDirty();
	}

	public static void saveIfDirty() {
		if (!dirty) return;
		dirty = false;
		Path p = path();
		try {
			Files.createDirectories(p.getParent());
			Path tmp = p.resolveSibling("chaoshearts.json.tmp");
			try (Writer w = Files.newBufferedWriter(tmp, StandardCharsets.UTF_8)) {
				GSON.toJson(values, w);
			}
			Files.move(tmp, p, StandardCopyOption.REPLACE_EXISTING, StandardCopyOption.ATOMIC_MOVE);
		} catch (IOException e) {
			ChaosHearts.LOGGER.error("Could not write {}", p, e);
		}
	}

	/** Balance value for key, registering the default if the file does not have it yet. */
	public static double num(String key, double def) {
		Double v = values.balance.get(key);
		if (v == null) {
			values.balance.put(key, def);
			dirty = true;
			return def;
		}
		return v;
	}
}
