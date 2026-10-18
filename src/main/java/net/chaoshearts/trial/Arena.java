package net.chaoshearts.trial;

import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import net.minecraft.core.BlockPos;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.util.RandomSource;
import net.minecraft.world.level.block.Block;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.world.level.block.state.BlockState;
import net.minecraft.world.phys.AABB;
import net.minecraft.world.phys.Vec3;

/**
 * One arena instance in the trials dimension. Blocks are queued, then placed and later removed a
 * few thousand per tick so a trial never stalls the server.
 */
public final class Arena {
	public static final int FLOOR_Y = 100;
	public static final int CEILING = 28;

	/** Blocks to place, in order. Later entries for the same position replace earlier ones. */
	private final LinkedHashMap<BlockPos, BlockState> plan = new LinkedHashMap<>();
	private Iterator<Map.Entry<BlockPos, BlockState>> building;
	private final ArrayDeque<BlockPos> clearing = new ArrayDeque<>();
	private final List<BlockPos> placed = new ArrayList<>();

	public final ServerLevel level;
	public final BlockPos center;
	public final int radius;
	public final RandomSource random;

	public Arena(ServerLevel level, BlockPos center, int radius, long seed) {
		this.level = level;
		this.center = center;
		this.radius = radius;
		this.random = RandomSource.create(seed);
	}

	public static BlockPos centerForSlot(int slot) {
		int s = Math.floorMod(slot, 4000);
		return new BlockPos(2048 * (s % 64) + 1024, FLOOR_Y, 2048 * (s / 64) + 1024);
	}

	// ---------------------------------------------------------------- planning

	public void set(int dx, int dy, int dz, BlockState state) {
		plan.put(center.offset(dx, dy, dz), state);
	}

	public void setAbs(BlockPos pos, BlockState state) {
		plan.put(pos.immutable(), state);
	}

	public boolean planned(int dx, int dy, int dz) {
		return plan.containsKey(center.offset(dx, dy, dz));
	}

	public BlockState pick(Palette.Weighted w) {
		return w.pick(random);
	}

	/** The common layout: floor, rim, crenellated wall, cover pillars, light, sigil and the invisible cage. */
	public void planBase(Palette p, int pillars) {
		int r = radius;
		for (int dx = -r - 3; dx <= r + 3; dx++) {
			for (int dz = -r - 3; dz <= r + 3; dz++) {
				double d = Math.sqrt(dx * dx + dz * dz);
				if (d <= r + 0.5) {
					set(dx, 0, dz, d > r - 1.5 ? p.edge() : pick(p.floor()));
					set(dx, -1, dz, pick(p.under()));
					if (d > r - 4) set(dx, -2, dz, pick(p.under()));
					if (d > r - 2 && random.nextFloat() < 0.35f) set(dx, -3, dz, pick(p.under()));
				}
				if (d > r - 0.5 && d <= r + 0.5) {
					set(dx, 1, dz, p.wall());
					if (Math.floorMod(dx + dz, 3) == 0) set(dx, 2, dz, p.wall());
				}
				// Invisible cage just outside the wall and a lid, so nobody flies, pearls or falls out.
				if (d > r + 0.5 && d <= r + 2.5) {
					for (int y = 0; y <= CEILING; y++) set(dx, y, dz, Blocks.BARRIER.defaultBlockState());
				}
				if (d <= r + 2.5) set(dx, CEILING, dz, Blocks.BARRIER.defaultBlockState());
			}
		}
		// Sigil in the middle.
		for (int i = 0; i < 64; i++) {
			double a = Math.PI * 2 * i / 64;
			set((int) Math.round(Math.cos(a) * 6), 0, (int) Math.round(Math.sin(a) * 6), p.accent());
		}
		for (int i = -5; i <= 5; i++) {
			set(i, 0, 0, p.accent());
			set(0, 0, i, p.accent());
		}
		set(0, 0, 0, p.light());
		// Cover pillars.
		for (int i = 0; i < pillars; i++) {
			double a = Math.PI * 2 * i / pillars + Math.PI / pillars;
			int px = (int) Math.round(Math.cos(a) * (r - 6));
			int pz = (int) Math.round(Math.sin(a) * (r - 6));
			int h = 5 + random.nextInt(4);
			for (int y = 1; y <= h; y++) {
				for (int ox = -1; ox <= 1; ox++) for (int oz = -1; oz <= 1; oz++) {
					if (ox != 0 && oz != 0 && y > 1 && y < h) continue;
					set(px + ox, y, pz + oz, y == h ? p.light() : p.pillar());
				}
			}
		}
		// Hidden light sources above the floor so the arena is readable in the dark dimension.
		BlockState light = Blocks.LIGHT.defaultBlockState();
		for (int dx = -r + 2; dx <= r - 2; dx += 6) {
			for (int dz = -r + 2; dz <= r - 2; dz += 6) {
				if (dx * dx + dz * dz <= (r - 2) * (r - 2) && !planned(dx, 5, dz)) set(dx, 5, dz, light);
			}
		}
	}

	/** A floating chunk of terrain outside the cage for scenery. */
	public void island(int dx, int dy, int dz, int size, Palette.Weighted top, BlockState under, BlockState glow) {
		for (int x = -size; x <= size; x++) {
			for (int z = -size; z <= size; z++) {
				double d = Math.sqrt(x * x + z * z);
				if (d > size + 0.3) continue;
				set(dx + x, dy, dz + z, pick(top));
				int depth = (int) Math.round((size - d) * 1.2) + 1;
				for (int y = 1; y <= depth; y++) set(dx + x, dy - y, dz + z, under);
			}
		}
		if (glow != null) set(dx, dy - 1, dz, glow);
	}

	/** Random point on the floor between two radii, standing height. */
	public Vec3 floorPoint(double minR, double maxR) {
		double a = random.nextDouble() * Math.PI * 2;
		double d = minR + random.nextDouble() * (maxR - minR);
		return new Vec3(center.getX() + 0.5 + Math.cos(a) * d, FLOOR_Y + 1, center.getZ() + 0.5 + Math.sin(a) * d);
	}

	public Vec3 centerTop() {
		return new Vec3(center.getX() + 0.5, FLOOR_Y + 1, center.getZ() + 0.5);
	}

	public Vec3 playerSpawn() {
		return new Vec3(center.getX() + 0.5, FLOOR_Y + 1, center.getZ() + 0.5 + radius - 5);
	}

	public Vec3 bossSpawn() {
		return new Vec3(center.getX() + 0.5, FLOOR_Y + 1, center.getZ() + 0.5 - 4);
	}

	public boolean inside(Vec3 pos, double margin) {
		double dx = pos.x - (center.getX() + 0.5), dz = pos.z - (center.getZ() + 0.5);
		return dx * dx + dz * dz <= (radius + margin) * (radius + margin) && pos.y > FLOOR_Y - 6 && pos.y < FLOOR_Y + CEILING + 2;
	}

	public AABB bounds() {
		return new AABB(center.getX() - radius - 24, FLOOR_Y - 30, center.getZ() - radius - 24, center.getX() + radius + 25, FLOOR_Y + CEILING + 10, center.getZ() + radius + 25);
	}

	// ---------------------------------------------------------------- building and clearing

	public int plannedCount() {
		return plan.size();
	}

	/** Places up to max blocks. Returns true when everything is placed. */
	public boolean buildStep(int max) {
		if (building == null) building = plan.entrySet().iterator();
		int n = 0;
		while (building.hasNext() && n < max) {
			Map.Entry<BlockPos, BlockState> e = building.next();
			level.setBlock(e.getKey(), e.getValue(), Block.UPDATE_CLIENTS | Block.UPDATE_KNOWN_SHAPE);
			placed.add(e.getKey());
			n++;
		}
		return !building.hasNext();
	}

	public double buildProgress() {
		return plan.isEmpty() ? 1 : placed.size() / (double) plan.size();
	}

	/** Starts removing every block this arena placed, plus anything players or mobs added inside. */
	public void beginClear() {
		clearing.clear();
		clearing.addAll(placed);
		// Sweep the playable volume for leftovers (fire, temporary blocks that were not restored).
		int r = radius + 1;
		for (int dx = -r; dx <= r; dx++) for (int dz = -r; dz <= r; dz++) {
			if (dx * dx + dz * dz > r * r) continue;
			for (int y = 1; y < CEILING; y++) {
				BlockPos pos = center.offset(dx, y, dz);
				if (!plan.containsKey(pos)) clearing.add(pos);
			}
		}
		placed.clear();
		building = null;
	}

	/** Removes up to max blocks. Returns true when done. */
	public boolean clearStep(int max) {
		// Budget: a block change costs 16, checking an already empty position costs 1.
		long budget = max == Integer.MAX_VALUE ? Long.MAX_VALUE : max * 16L;
		long spent = 0;
		while (!clearing.isEmpty() && spent < budget) {
			BlockPos pos = clearing.poll();
			if (!level.getBlockState(pos).isAir()) {
				level.setBlock(pos, Blocks.AIR.defaultBlockState(), Block.UPDATE_CLIENTS | Block.UPDATE_KNOWN_SHAPE | Block.UPDATE_SUPPRESS_DROPS);
				spent += 16;
			} else {
				spent++;
			}
		}
		return clearing.isEmpty();
	}

	/** Everything at once, for server shutdown. */
	public void clearNow() {
		if (clearing.isEmpty()) beginClear();
		while (!clearStep(Integer.MAX_VALUE)) {
			// keep going
		}
	}
}
