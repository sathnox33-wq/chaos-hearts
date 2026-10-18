package net.chaoshearts.ability;

import net.chaoshearts.combat.Combat;
import net.minecraft.core.BlockPos;
import net.minecraft.core.particles.BlockParticleOption;
import net.minecraft.core.particles.ParticleTypes;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.tags.DamageTypeTags;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.level.block.Blocks;
import net.minecraft.world.level.block.state.BlockState;
import net.minecraft.world.phys.Vec3;

/** Small helpers shared by the heart kits. */
public final class KitUtil {
	private KitUtil() {}

	/** A direct melee hit by the owner (not a projectile, not an ability). */
	public static boolean melee(Ctx c, DamageSource s) {
		return !Combat.inAbilityDamage() && s.getEntity() == c.player && s.getDirectEntity() == c.player;
	}

	public static boolean fall(DamageSource s) {
		return s.is(DamageTypeTags.IS_FALL);
	}

	public static BlockState ground(ServerLevel level, Vec3 pos) {
		BlockPos bp = BlockPos.containing(pos.x, pos.y - 0.2, pos.z);
		BlockState st = level.getBlockState(bp);
		if (st.isAir()) st = level.getBlockState(bp.below());
		return st.isAir() ? Blocks.STONE.defaultBlockState() : st;
	}

	/** Debris thrown up from the ground at pos. */
	public static void debris(ServerLevel level, Vec3 pos, double radius, int count) {
		BlockState st = ground(level, pos);
		level.sendParticles(new BlockParticleOption(ParticleTypes.BLOCK, st), pos.x, pos.y + 0.1, pos.z, count, radius, 0.1, radius, 0.3);
	}

	public static void dustOfBlock(ServerLevel level, Vec3 pos, double radius, int count) {
		BlockState st = ground(level, pos);
		level.sendParticles(new BlockParticleOption(ParticleTypes.DUST_PILLAR, st), pos.x, pos.y + 0.1, pos.z, count, radius, 0.05, radius, 0.2);
	}

	/** Finds the ground below pos (up to depth blocks), or null. */
	public static Vec3 groundBelow(ServerLevel level, Vec3 pos, int depth) {
		BlockPos bp = BlockPos.containing(pos);
		for (int i = 0; i < depth; i++) {
			BlockPos below = bp.below(i);
			if (!level.getBlockState(below).getCollisionShape(level, below).isEmpty()) {
				return new Vec3(pos.x, below.getY() + level.getBlockState(below).getCollisionShape(level, below).max(net.minecraft.core.Direction.Axis.Y), pos.z);
			}
		}
		return null;
	}

	/** Point at distance along the flat look direction, rotated by angle (radians). */
	public static Vec3 rotateY(Vec3 v, double angle) {
		double cos = Math.cos(angle), sin = Math.sin(angle);
		return new Vec3(v.x * cos - v.z * sin, v.y, v.x * sin + v.z * cos);
	}

	public static boolean safeSpot(ServerLevel level, Vec3 feet) {
		BlockPos bp = BlockPos.containing(feet);
		return level.getBlockState(bp).getCollisionShape(level, bp).isEmpty()
				&& level.getBlockState(bp.above()).getCollisionShape(level, bp.above()).isEmpty();
	}
}
