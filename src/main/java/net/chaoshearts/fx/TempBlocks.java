package net.chaoshearts.fx;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import net.chaoshearts.ChaosHearts;
import net.chaoshearts.data.DataStore;
import net.minecraft.core.BlockPos;
import net.minecraft.core.registries.BuiltInRegistries;
import net.minecraft.server.MinecraftServer;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.world.level.block.Block;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.world.level.block.state.BlockState;

/**
 * Blocks placed by abilities (ice walls and so on). They only ever replace air and always turn
 * back into air, also after a crash: pending blocks are saved with the player data.
 */
public final class TempBlocks {
	public static final class Entry {
		public String dimension;
		public int x, y, z;
		public String block;
		public long expiresTick;
		transient long expiresAt;
	}

	private static final List<Entry> ACTIVE = new ArrayList<>();

	private TempBlocks() {}

	public static boolean place(ServerLevel level, BlockPos pos, BlockState state, int ticks) {
		if (!level.isLoaded(pos) || !level.getBlockState(pos).isAir()) return false;
		if (!level.getWorldBorder().isWithinBounds(pos)) return false;
		level.setBlock(pos, state, Block.UPDATE_ALL);
		Entry e = new Entry();
		e.dimension = net.chaoshearts.util.Dims.id(level);
		e.x = pos.getX();
		e.y = pos.getY();
		e.z = pos.getZ();
		e.block = BuiltInRegistries.BLOCK.getKey(state.getBlock()).toString();
		e.expiresAt = ChaosHearts.tick() + ticks;
		ACTIVE.add(e);
		DataStore.root().tempBlocks = new ArrayList<>(ACTIVE);
		DataStore.markDirty();
		return true;
	}

	public static void tick(MinecraftServer server) {
		if (ACTIVE.isEmpty()) return;
		long now = ChaosHearts.tick();
		boolean changed = false;
		Iterator<Entry> it = ACTIVE.iterator();
		while (it.hasNext()) {
			Entry e = it.next();
			if (e.expiresAt > now) continue;
			restore(server, e);
			it.remove();
			changed = true;
		}
		if (changed) {
			DataStore.root().tempBlocks = new ArrayList<>(ACTIVE);
			DataStore.markDirty();
		}
	}

	private static void restore(MinecraftServer server, Entry e) {
		ServerLevel level = net.chaoshearts.util.Dims.level(server, e.dimension);
		if (level == null) return;
		BlockPos pos = new BlockPos(e.x, e.y, e.z);
		BlockState now = level.getBlockState(pos);
		if (BuiltInRegistries.BLOCK.getKey(now.getBlock()).toString().equals(e.block)) {
			level.setBlock(pos, Blocks.AIR.defaultBlockState(), Block.UPDATE_ALL);
		}
	}

	public static void restoreAll(MinecraftServer server) {
		for (Entry e : ACTIVE) restore(server, e);
		ACTIVE.clear();
		DataStore.root().tempBlocks = new ArrayList<>();
		DataStore.markDirty();
	}

	/** Called after data load: anything left from a crash is removed. */
	public static void cleanupFromSave(MinecraftServer server) {
		List<Entry> saved = DataStore.root().tempBlocks;
		if (saved == null || saved.isEmpty()) return;
		for (Entry e : saved) restore(server, e);
		ChaosHearts.LOGGER.info("Removed {} leftover ability blocks", saved.size());
		DataStore.root().tempBlocks = new ArrayList<>();
		DataStore.markDirty();
	}
}
