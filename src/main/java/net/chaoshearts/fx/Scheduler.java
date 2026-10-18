package net.chaoshearts.fx;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import net.chaoshearts.ChaosHearts;

/** Tiny tick scheduler for ability sequences. Runs on the server thread. */
public final class Scheduler {
	/** Return false to stop a repeating task. */
	@FunctionalInterface
	public interface Repeating {
		boolean run(int iteration);
	}

	private static final class Task {
		long nextTick;
		final int interval;
		final int maxRuns;
		int runs;
		final Repeating body;

		Task(long nextTick, int interval, int maxRuns, Repeating body) {
			this.nextTick = nextTick;
			this.interval = interval;
			this.maxRuns = maxRuns;
			this.body = body;
		}
	}

	private static final List<Task> TASKS = new ArrayList<>();
	private static final List<Task> PENDING = new ArrayList<>();

	private Scheduler() {}

	public static void later(int delayTicks, Runnable r) {
		PENDING.add(new Task(ChaosHearts.tick() + Math.max(1, delayTicks), 1, 1, i -> {
			r.run();
			return false;
		}));
	}

	/** Runs body every interval ticks, up to maxRuns times (0 = until it returns false). */
	public static void repeat(int delayTicks, int interval, int maxRuns, Repeating body) {
		PENDING.add(new Task(ChaosHearts.tick() + Math.max(0, delayTicks), Math.max(1, interval), maxRuns, body));
	}

	public static void tick() {
		if (!PENDING.isEmpty()) {
			TASKS.addAll(PENDING);
			PENDING.clear();
		}
		long now = ChaosHearts.tick();
		Iterator<Task> it = TASKS.iterator();
		while (it.hasNext()) {
			Task t = it.next();
			if (t.nextTick > now) continue;
			boolean keep;
			try {
				keep = t.body.run(t.runs);
			} catch (Throwable e) {
				ChaosHearts.LOGGER.error("Chaos Hearts task failed", e);
				keep = false;
			}
			t.runs++;
			if (!keep || (t.maxRuns > 0 && t.runs >= t.maxRuns)) {
				it.remove();
			} else {
				t.nextTick = now + t.interval;
			}
		}
	}

	public static void clear() {
		TASKS.clear();
		PENDING.clear();
	}
}
