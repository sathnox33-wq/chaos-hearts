package net.chaoshearts.ability;

import java.util.HashMap;
import java.util.Map;

import net.minecraft.network.chat.Component;

/** Runtime (not saved) per-player state: cooldowns, meters and timers. Survives relogs. */
public final class PlayerState {
	/** ability key ("rage.a1") -> epoch ms when ready. */
	final Map<String, Long> readyAt = new HashMap<>();
	/** ability keys whose "ready" chime is still owed. */
	final Map<String, Boolean> chimePending = new HashMap<>();
	private final Map<String, Double> vars = new HashMap<>();
	/** name -> server tick until which a timed state is active. */
	private final Map<String, Long> timers = new HashMap<>();

	public long lastIndicatorTick;
	long lastCastTick = -100;
	Component hudFlash;
	long hudFlashUntil;
	String lastFocusSignature = "";

	public double var(String k) {
		return vars.getOrDefault(k, 0.0);
	}

	public void var(String k, double v) {
		vars.put(k, v);
	}

	public double addVar(String k, double d) {
		double v = var(k) + d;
		vars.put(k, v);
		return v;
	}

	public void startTimer(String name, long untilTick) {
		timers.put(name, untilTick);
	}

	public boolean timer(String name, long nowTick) {
		Long t = timers.get(name);
		return t != null && t > nowTick;
	}

	public long timerLeft(String name, long nowTick) {
		Long t = timers.get(name);
		return t == null ? 0 : Math.max(0, t - nowTick);
	}

	public void stopTimer(String name) {
		timers.remove(name);
	}

	public void hudFlash(Component c, int ticks) {
		hudFlash = c;
		hudFlashUntil = System.currentTimeMillis() + ticks * 50L;
	}

	public void resetCooldowns() {
		readyAt.clear();
		chimePending.clear();
	}

	/** Clears meters and timers, e.g. when the active heart changes or after death. */
	public void resetCombatState() {
		vars.clear();
		timers.clear();
	}
}
