package net.chaoshearts.data;

import java.io.IOException;
import java.io.Reader;
import java.io.Writer;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import net.chaoshearts.ChaosHearts;
import net.minecraft.server.MinecraftServer;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.world.level.storage.LevelResource;

/**
 * Persistent state in &lt;world&gt;/chaoshearts/data.json. Writes are atomic and the previous good
 * file is kept as data.json.bak.
 */
public final class DataStore {
	private static final Gson GSON = new GsonBuilder().setPrettyPrinting().disableHtmlEscaping().create();
	private static final int AUTOSAVE_TICKS = 20 * 120;

	public static final class Root {
		public int version = 1;
		public Map<UUID, PlayerData> players = new HashMap<>();
		public Map<UUID, HeartRecord> hearts = new HashMap<>();
		public int trialSlotCounter;
		public java.util.List<net.chaoshearts.fx.TempBlocks.Entry> tempBlocks = new java.util.ArrayList<>();
	}

	private static Root root = new Root();
	private static Path dir;
	private static boolean dirty;
	private static boolean loaded;

	private DataStore() {}

	public static Root root() {
		return root;
	}

	public static boolean isLoaded() {
		return loaded;
	}

	public static void load(MinecraftServer server) {
		dir = server.getWorldPath(LevelResource.ROOT).resolve("chaoshearts");
		Path file = dir.resolve("data.json");
		Path bak = dir.resolve("data.json.bak");
		root = null;
		if (Files.exists(file)) {
			root = read(file);
			if (root == null) {
				ChaosHearts.LOGGER.error("chaoshearts/data.json is unreadable; keeping it as data.json.corrupt and loading the backup");
				try {
					Files.copy(file, dir.resolve("data.json.corrupt-" + System.currentTimeMillis()), StandardCopyOption.REPLACE_EXISTING);
				} catch (IOException ignored) {
				}
			}
		}
		if (root == null && Files.exists(bak)) root = read(bak);
		if (root == null) root = new Root();
		if (root.players == null) root.players = new HashMap<>();
		if (root.hearts == null) root.hearts = new HashMap<>();
		root.players.values().forEach(PlayerData::sanitize);
		reconcile();
		loaded = true;
		ChaosHearts.LOGGER.info("Chaos Hearts data loaded: {} players, {} hearts", root.players.size(), root.hearts.size());
	}

	private static Root read(Path p) {
		try (Reader r = Files.newBufferedReader(p, StandardCharsets.UTF_8)) {
			return GSON.fromJson(r, Root.class);
		} catch (Exception e) {
			ChaosHearts.LOGGER.error("Failed to read {}", p, e);
			return null;
		}
	}

	/**
	 * Makes the registry and the player lists agree. The registry is the source of truth for HELD
	 * hearts; a heart listed by two players is kept only by the registry's holder.
	 */
	private static void reconcile() {
		for (PlayerData pd : root.players.values()) {
			pd.hearts.removeIf(h -> {
				HeartRecord rec = root.hearts.get(h.heartId);
				if (rec == null) {
					// Listed by the player but missing from the registry: recreate the record.
					rec = new HeartRecord();
					rec.id = h.heartId;
					rec.type = h.type;
					rec.state = HeartRecord.State.HELD;
					rec.holder = pd.uuid;
					rec.createdAt = h.acquiredAt;
					root.hearts.put(rec.id, rec);
					return false;
				}
				boolean valid = rec.state == HeartRecord.State.HELD && pd.uuid.equals(rec.holder);
				if (!valid) ChaosHearts.LOGGER.warn("Removed stale heart {} from {}", h.heartId, pd.lastName);
				return !valid;
			});
		}
		for (HeartRecord rec : root.hearts.values()) {
			if (rec.state == HeartRecord.State.HELD) {
				PlayerData pd = root.players.get(rec.holder);
				if (pd == null || pd.hearts.stream().noneMatch(h -> h.heartId.equals(rec.id))) {
					if (pd == null) {
						pd = new PlayerData();
						pd.uuid = rec.holder;
						pd.starterGiven = true;
						root.players.put(pd.uuid, pd);
					}
					pd.hearts.add(new PlayerData.OwnedHeart(rec.id, rec.type, rec.createdAt));
					pd.sanitize();
				}
			}
		}
	}

	public static PlayerData get(UUID uuid) {
		return root.players.computeIfAbsent(uuid, u -> {
			PlayerData pd = new PlayerData();
			pd.uuid = u;
			dirty = true;
			return pd;
		});
	}

	public static PlayerData get(ServerPlayer player) {
		PlayerData pd = get(player.getUUID());
		String name = player.getName().getString();
		if (!name.equals(pd.lastName)) {
			pd.lastName = name;
			dirty = true;
		}
		return pd;
	}

	public static PlayerData find(UUID uuid) {
		return root.players.get(uuid);
	}

	public static void markDirty() {
		dirty = true;
	}

	public static void autosave(long tick) {
		if (dirty && tick % AUTOSAVE_TICKS == 0) save();
	}

	/** Saves now. Called after every heart ownership change. */
	public static synchronized void save() {
		if (!loaded || dir == null) return;
		try {
			Files.createDirectories(dir);
			Path file = dir.resolve("data.json");
			Path tmp = dir.resolve("data.json.tmp");
			try (Writer w = Files.newBufferedWriter(tmp, StandardCharsets.UTF_8)) {
				GSON.toJson(root, w);
			}
			if (Files.exists(file)) Files.copy(file, dir.resolve("data.json.bak"), StandardCopyOption.REPLACE_EXISTING);
			Files.move(tmp, file, StandardCopyOption.REPLACE_EXISTING, StandardCopyOption.ATOMIC_MOVE);
			dirty = false;
		} catch (IOException e) {
			ChaosHearts.LOGGER.error("Failed to save Chaos Hearts data", e);
		}
	}

	public static void unload() {
		loaded = false;
		root = new Root();
		dir = null;
	}
}
