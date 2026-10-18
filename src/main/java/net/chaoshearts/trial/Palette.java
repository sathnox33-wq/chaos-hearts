package net.chaoshearts.trial;

import java.util.ArrayList;
import java.util.List;

import net.minecraft.util.RandomSource;
import net.minecraft.world.level.block.Block;
import net.minecraft.world.level.block.state.BlockState;

/** The blocks an arena is made of. */
public record Palette(Weighted floor, Weighted under, BlockState edge, BlockState wall, BlockState pillar, BlockState accent, BlockState light) {

	public static final class Weighted {
		private final List<BlockState> states = new ArrayList<>();
		private final List<Integer> weights = new ArrayList<>();
		private int total;

		public Weighted add(Block b, int weight) {
			return add(b.defaultBlockState(), weight);
		}

		public Weighted add(BlockState s, int weight) {
			states.add(s);
			weights.add(weight);
			total += weight;
			return this;
		}

		public BlockState pick(RandomSource r) {
			int n = r.nextInt(total);
			for (int i = 0; i < states.size(); i++) {
				n -= weights.get(i);
				if (n < 0) return states.get(i);
			}
			return states.get(0);
		}
	}

	public static Weighted of(Object... blocksAndWeights) {
		Weighted w = new Weighted();
		for (int i = 0; i < blocksAndWeights.length; i += 2) {
			Object o = blocksAndWeights[i];
			int weight = (Integer) blocksAndWeights[i + 1];
			if (o instanceof Block b) w.add(b, weight);
			else w.add((BlockState) o, weight);
		}
		return w;
	}
}
