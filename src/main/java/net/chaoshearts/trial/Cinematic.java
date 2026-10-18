package net.chaoshearts.trial;

import java.util.ArrayList;
import java.util.List;

import net.chaoshearts.fx.Displays;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.util.Mth;
import net.minecraft.world.entity.Display;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.phys.Vec3;

/**
 * A camera flight. The player is put in spectator mode and their view is attached to an invisible
 * display entity that follows keyframes; vanilla clients interpolate its movement smoothly.
 */
public final class Cinematic {
	public record Key(int tick, Vec3 pos, Vec3 lookAt) {}

	private final List<Key> keys = new ArrayList<>();
	private Display.ItemDisplay camera;
	private int age;
	private boolean attached;

	public Cinematic key(int tick, Vec3 pos, Vec3 lookAt) {
		keys.add(new Key(tick, pos, lookAt));
		return this;
	}

	/** Adds keyframes circling a point. */
	public Cinematic orbit(int fromTick, int toTick, Vec3 center, double radius, double height0, double height1, double angle0, double angle1, Vec3 lookAt) {
		int steps = Math.max(2, (toTick - fromTick) / 8);
		for (int i = 0; i <= steps; i++) {
			double t = i / (double) steps;
			double a = angle0 + (angle1 - angle0) * t;
			double h = height0 + (height1 - height0) * t;
			key(fromTick + (int) Math.round((toTick - fromTick) * t), center.add(Math.cos(a) * radius, h, Math.sin(a) * radius), lookAt);
		}
		return this;
	}

	public int length() {
		return keys.isEmpty() ? 0 : keys.get(keys.size() - 1).tick();
	}

	public int age() {
		return age;
	}

	public boolean finished() {
		return age > length();
	}

	public void start(ServerLevel level) {
		keys.sort((a, b) -> Integer.compare(a.tick(), b.tick()));
		Key first = keys.get(0);
		camera = Displays.item(level, first.pos(), ItemStack.EMPTY, 0.01f, false);
		if (camera != null) {
			Displays.teleportDuration(camera, 3);
			float[] rot = lookAngles(first.pos(), first.lookAt());
			Displays.move(camera, first.pos(), rot[0], rot[1]);
		}
	}

	/** Advances one tick. Attaches the view once the client has had time to receive the camera entity. */
	public void tick(ServerPlayer viewer) {
		if (camera == null) {
			age++;
			return;
		}
		Vec3[] pose = sample(age);
		float[] rot = lookAngles(pose[0], pose[1]);
		Displays.move(camera, pose[0], rot[0], rot[1]);
		if (viewer != null) {
			if (age >= 3 && viewer.getCamera() != camera) {
				viewer.setCamera(camera);
				attached = true;
			}
		}
		age++;
	}

	public void stop(ServerPlayer viewer) {
		if (viewer != null && attached && viewer.getCamera() == camera) viewer.setCamera(viewer);
		if (camera != null) camera.discard();
		camera = null;
	}

	private Vec3[] sample(int t) {
		Key a = keys.get(0), b = keys.get(keys.size() - 1);
		if (t <= a.tick()) return new Vec3[] {a.pos(), a.lookAt()};
		if (t >= b.tick()) return new Vec3[] {b.pos(), b.lookAt()};
		for (int i = 0; i < keys.size() - 1; i++) {
			Key k0 = keys.get(i), k1 = keys.get(i + 1);
			if (t >= k0.tick() && t <= k1.tick()) {
				double f = (t - k0.tick()) / (double) Math.max(1, k1.tick() - k0.tick());
				// Catmull-Rom through neighbouring keys keeps orbits round and starts and stops soft.
				Key km = keys.get(Math.max(0, i - 1)), kp = keys.get(Math.min(keys.size() - 1, i + 2));
				Vec3 pos = catmull(km.pos(), k0.pos(), k1.pos(), kp.pos(), f);
				Vec3 look = k0.lookAt().lerp(k1.lookAt(), smooth(f));
				return new Vec3[] {pos, look};
			}
		}
		return new Vec3[] {b.pos(), b.lookAt()};
	}

	private static double smooth(double f) {
		return f * f * (3 - 2 * f);
	}

	private static Vec3 catmull(Vec3 p0, Vec3 p1, Vec3 p2, Vec3 p3, double t) {
		double t2 = t * t, t3 = t2 * t;
		return new Vec3(
				0.5 * (2 * p1.x + (-p0.x + p2.x) * t + (2 * p0.x - 5 * p1.x + 4 * p2.x - p3.x) * t2 + (-p0.x + 3 * p1.x - 3 * p2.x + p3.x) * t3),
				0.5 * (2 * p1.y + (-p0.y + p2.y) * t + (2 * p0.y - 5 * p1.y + 4 * p2.y - p3.y) * t2 + (-p0.y + 3 * p1.y - 3 * p2.y + p3.y) * t3),
				0.5 * (2 * p1.z + (-p0.z + p2.z) * t + (2 * p0.z - 5 * p1.z + 4 * p2.z - p3.z) * t2 + (-p0.z + 3 * p1.z - 3 * p2.z + p3.z) * t3));
	}

	/** Yaw and pitch, in Minecraft's convention, for looking from one point at another. */
	public static float[] lookAngles(Vec3 from, Vec3 to) {
		Vec3 d = to.subtract(from);
		double h = Math.sqrt(d.x * d.x + d.z * d.z);
		float yaw = (float) (Mth.atan2(d.z, d.x) * Mth.RAD_TO_DEG) - 90f;
		float pitch = (float) (-(Mth.atan2(d.y, h) * Mth.RAD_TO_DEG));
		return new float[] {Mth.wrapDegrees(yaw), pitch};
	}
}
