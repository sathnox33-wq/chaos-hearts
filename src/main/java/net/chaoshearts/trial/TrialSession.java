package net.chaoshearts.trial;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import net.chaoshearts.heart.HeartType;
import net.minecraft.server.level.ServerBossEvent;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.world.entity.LivingEntity;
import net.minecraft.world.entity.Mob;
import net.minecraft.world.phys.Vec3;

/** One player's run of one trial. */
public final class TrialSession {
	public enum State {
		/** Arena blocks are being placed; the player is still in the overworld. */
		BUILDING,
		INTRO,
		WAVES,
		BOSS_INTRO,
		BOSS,
		VICTORY,
		/** Finished; blocks and entities are being removed. */
		CLEANUP
	}

	/** A damaging area on the floor. */
	public static final class Zone {
		public Vec3 pos;
		public double radius;
		public int ticksLeft;
		public float damagePerSecond;
		public int color;
		public java.util.function.Consumer<LivingEntity> onTouch;

		public Zone(Vec3 pos, double radius, int ticks, float dps, int color) {
			this.pos = pos;
			this.radius = radius;
			this.ticksLeft = ticks;
			this.damagePerSecond = dps;
			this.color = color;
		}
	}

	public final UUID id = UUID.randomUUID();
	public final UUID player;
	public final HeartType type;
	public final Trial trial;
	public final Arena arena;
	public final ServerLevel level;
	public final boolean forced;

	public State state = State.BUILDING;
	/** Ticks since the current state began. */
	public int stateAge;
	/** Ticks since the fight began (after the intro). */
	public int fightAge;
	public long fightStartMillis;
	public int timeLimitTicks;

	public int wave = -1;
	/** Ticks until the next wave spawns, -1 when waiting for the current one to die. */
	public int waveDelay = -1;
	public final Set<UUID> adds = new LinkedHashSet<>();
	public UUID boss;
	/** 2 = fight, 3 = enraged (half health), 4 = last stand. */
	public int phase = 1;
	public ServerBossEvent bar;
	public Cinematic cinematic;
	/** Where to put the player back after a mid-fight camera shot. */
	public Vec3 resumePos;
	public float resumeYaw, resumePitch;

	public final List<Zone> zones = new ArrayList<>();
	/** Free-form timers and values for trial scripts. */
	public final Map<String, Long> vars = new HashMap<>();
	public long nextMusicTick;
	public String endReason;
	public boolean won;

	TrialSession(UUID player, HeartType type, Trial trial, Arena arena, boolean forced) {
		this.player = player;
		this.type = type;
		this.trial = trial;
		this.arena = arena;
		this.level = arena.level;
		this.forced = forced;
	}

	public ServerPlayer player() {
		return net.chaoshearts.heart.HeartManager.online(player);
	}

	public Mob boss() {
		if (boss == null) return null;
		return level.getEntity(boss) instanceof Mob m && m.isAlive() ? m : null;
	}

	public boolean active() {
		return state != State.CLEANUP && TrialManager.session(player) == this;
	}

	public boolean fighting() {
		return state == State.WAVES || state == State.BOSS;
	}

	public String tag() {
		return TrialManager.TAG + "." + id;
	}

	public long var(String key) {
		return vars.getOrDefault(key, 0L);
	}

	public void var(String key, long value) {
		vars.put(key, value);
	}

	/** True once every interval ticks of the fight, staggered by offset. */
	public boolean every(int interval, int offset) {
		return interval > 0 && fightAge % interval == offset % interval;
	}

	/** Cooldown helper for boss abilities: true and resets if ready. */
	public boolean ready(String key, int cooldownTicks) {
		long now = fightAge;
		long at = vars.getOrDefault("cd." + key, (long) (cooldownTicks / 2));
		if (now < at) return false;
		vars.put("cd." + key, now + cooldownTicks);
		return true;
	}
}
