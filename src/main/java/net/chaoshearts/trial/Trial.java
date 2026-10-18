package net.chaoshearts.trial;

import net.chaoshearts.heart.HeartType;
import net.minecraft.world.BossEvent;
import net.minecraft.world.entity.Mob;
import net.minecraft.world.phys.Vec3;

/**
 * One heart's Awakening Trial: its arena, its waves and its boss. The flow (build, intro camera,
 * waves, boss intro, three boss phases, victory or failure) is run by {@link TrialManager}.
 */
public abstract class Trial {
	public final HeartType type;

	protected Trial(HeartType type) {
		this.type = type;
	}

	/** Shown in the intro, e.g. "The Crucible of Fury". */
	public abstract String title();

	/** One line under the title. */
	public abstract String tagline();

	public abstract String bossName();

	public abstract Palette palette();

	public int radius() {
		return 22;
	}

	public int pillars() {
		return 6;
	}

	public int waves() {
		return 2;
	}

	public BossEvent.BossBarColor barColor() {
		return BossEvent.BossBarColor.RED;
	}

	/** Theme structures on top of the base layout. */
	public abstract void decorate(Arena a);

	/** Spawns wave n (0-based). n == waves() is the reinforcement wave when the boss is enraged. */
	public abstract void spawnWave(TrialSession s, int wave);

	/** Creates the boss at the pedestal. It is held still and invulnerable until its entrance ends. */
	public abstract Mob spawnBoss(TrialSession s, Vec3 at);

	/** Entrance effects, called once when the boss appears. */
	public abstract void bossEntrance(TrialSession s, Mob boss);

	/** The boss's scripted attacks, every tick of the fight. */
	public abstract void bossTick(TrialSession s, Mob boss);

	/** Phase change: 3 at half health (enraged), 4 at a fifth (last stand). */
	public void onPhase(TrialSession s, Mob boss, int phase) {}

	/** Damage the boss takes from the player, after their heart has modified it. */
	public float bossIncoming(TrialSession s, Mob boss, float amount) {
		return amount;
	}

	/** Atmosphere particles, every 10 ticks while the player is in the arena. */
	public void ambient(TrialSession s) {}
}
