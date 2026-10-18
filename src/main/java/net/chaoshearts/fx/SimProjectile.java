package net.chaoshearts.fx;

import java.util.HashSet;
import java.util.Set;
import java.util.UUID;
import java.util.function.BiConsumer;
import java.util.function.Consumer;
import java.util.function.Predicate;

import net.minecraft.server.level.ServerLevel;
import net.minecraft.world.entity.Display;
import net.minecraft.world.entity.Entity;
import net.minecraft.world.entity.LivingEntity;
import net.minecraft.world.level.ClipContext;
import net.minecraft.world.phys.AABB;
import net.minecraft.world.phys.BlockHitResult;
import net.minecraft.world.phys.HitResult;
import net.minecraft.world.phys.Vec3;

/**
 * A projectile simulated by the server: swept collision against blocks and entities every tick,
 * drawn with particles and an optional display entity. Needs no client support.
 */
public final class SimProjectile {
	public final ServerLevel level;
	public Vec3 pos;
	public Vec3 vel;
	public double gravity = 0;
	public double radius = 0.4;
	public int maxTicks = 60;
	public int pierce = 0;
	/** Steers toward this entity each tick (0 = no homing). */
	public LivingEntity homingTarget;
	public double homingStrength = 0;
	public Display display;
	public Entity owner;

	private Predicate<LivingEntity> canHit = e -> true;
	private Consumer<SimProjectile> onTick = p -> {};
	private BiConsumer<SimProjectile, LivingEntity> onEntity = (p, e) -> {};
	private BiConsumer<SimProjectile, Vec3> onEnd = (p, at) -> {};
	private final Set<UUID> hit = new HashSet<>();
	private int age;
	private boolean done;

	public SimProjectile(ServerLevel level, Vec3 pos, Vec3 vel) {
		this.level = level;
		this.pos = pos;
		this.vel = vel;
	}

	public SimProjectile canHit(Predicate<LivingEntity> p) {
		canHit = p;
		return this;
	}

	/** Visuals each tick. */
	public SimProjectile onTick(Consumer<SimProjectile> c) {
		onTick = c;
		return this;
	}

	/** Called once for each entity hit. */
	public SimProjectile onEntity(BiConsumer<SimProjectile, LivingEntity> c) {
		onEntity = c;
		return this;
	}

	/** Called once when the projectile stops: block impact, out of pierce, or timeout. */
	public SimProjectile onEnd(BiConsumer<SimProjectile, Vec3> c) {
		onEnd = c;
		return this;
	}

	public int age() {
		return age;
	}

	public SimProjectile launch() {
		Scheduler.repeat(0, 1, 0, i -> step());
		return this;
	}

	public void stop() {
		finish(pos);
	}

	private boolean step() {
		if (done) return false;
		if (age++ >= maxTicks || !level.isLoaded(net.minecraft.core.BlockPos.containing(pos))) {
			finish(pos);
			return false;
		}
		if (homingTarget != null && homingTarget.isAlive() && homingStrength > 0) {
			Vec3 want = homingTarget.position().add(0, homingTarget.getBbHeight() / 2, 0).subtract(pos).normalize().scale(vel.length());
			vel = vel.lerp(want, homingStrength);
		}
		vel = vel.add(0, -gravity, 0);
		Vec3 next = pos.add(vel);

		BlockHitResult bh = level.clip(new ClipContext(pos, next, ClipContext.Block.COLLIDER, ClipContext.Fluid.NONE, owner == null ? net.minecraft.world.phys.shapes.CollisionContext.empty() : net.minecraft.world.phys.shapes.CollisionContext.of(owner)));
		Vec3 end = bh.getType() == HitResult.Type.MISS ? next : bh.getLocation();

		AABB sweep = new AABB(pos, end).inflate(radius + 1);
		for (LivingEntity e : level.getEntitiesOfClass(LivingEntity.class, sweep, e -> e.isAlive() && e != owner && !hit.contains(e.getUUID()) && canHit.test(e))) {
			AABB bb = e.getBoundingBox().inflate(radius);
			if (bb.contains(pos) || bb.clip(pos, end).isPresent()) {
				hit.add(e.getUUID());
				onEntity.accept(this, e);
				if (done) return false;
				if (hit.size() > pierce) {
					Vec3 at = bb.clip(pos, end).orElse(e.position().add(0, e.getBbHeight() / 2, 0));
					pos = at;
					finish(at);
					return false;
				}
			}
		}

		pos = end;
		if (display != null && display.isAlive()) Displays.move(display, pos.subtract(0, 0.25, 0));
		onTick.accept(this);
		if (bh.getType() != HitResult.Type.MISS) {
			finish(end);
			return false;
		}
		return true;
	}

	private void finish(Vec3 at) {
		if (done) return;
		done = true;
		if (display != null) display.discard();
		onEnd.accept(this, at);
	}
}
