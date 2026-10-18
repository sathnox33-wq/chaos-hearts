package net.chaoshearts.fx;

import net.chaoshearts.ChaosHearts;
import net.minecraft.core.Holder;
import net.minecraft.core.particles.DustColorTransitionOptions;
import net.minecraft.core.particles.DustParticleOptions;
import net.minecraft.core.particles.ParticleOptions;
import net.minecraft.network.chat.Component;
import net.minecraft.network.protocol.game.ClientboundSetSubtitleTextPacket;
import net.minecraft.network.protocol.game.ClientboundSetTitleTextPacket;
import net.minecraft.network.protocol.game.ClientboundSetTitlesAnimationPacket;
import net.minecraft.network.protocol.game.ClientboundSoundPacket;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.sounds.SoundEvent;
import net.minecraft.sounds.SoundSource;
import net.minecraft.util.Mth;
import net.minecraft.world.phys.Vec3;

/** Particle shapes and sound helpers used by every ability, trial and the Eye. */
public final class Fx {
	private Fx() {}

	public static DustParticleOptions dust(int rgb, float scale) {
		return new DustParticleOptions(rgb, scale);
	}

	public static DustColorTransitionOptions dust(int from, int to, float scale) {
		return new DustColorTransitionOptions(from, to, scale);
	}

	public static void at(ServerLevel level, ParticleOptions p, Vec3 pos, int count, double spread, double speed) {
		level.sendParticles(p, pos.x, pos.y, pos.z, count, spread, spread, spread, speed);
	}

	public static void at(ServerLevel level, ParticleOptions p, Vec3 pos, int count, double sx, double sy, double sz, double speed) {
		level.sendParticles(p, pos.x, pos.y, pos.z, count, sx, sy, sz, speed);
	}

	/** Visible from far away (up to 512 blocks) — for big set pieces only. */
	public static void far(ServerLevel level, ParticleOptions p, Vec3 pos, int count, double spread, double speed) {
		level.sendParticles(p, true, false, pos.x, pos.y, pos.z, count, spread, spread, spread, speed);
	}

	/** One particle with a direction: count 0 makes dx/dy/dz a velocity. */
	public static void directed(ServerLevel level, ParticleOptions p, Vec3 pos, Vec3 dir, double speed) {
		level.sendParticles(p, pos.x, pos.y, pos.z, 0, dir.x, dir.y, dir.z, speed);
	}

	/** A bright burst of light. */
	public static void flash(ServerLevel level, Vec3 pos) {
		level.sendParticles(net.minecraft.core.particles.ParticleTypes.END_ROD, true, false, pos.x, pos.y, pos.z, 14, 0.05, 0.05, 0.05, 0.25);
		level.sendParticles(dust(0xFFFFFF, 3.5f), true, false, pos.x, pos.y, pos.z, 6, 0.15, 0.15, 0.15, 0);
	}

	public static void ring(ServerLevel level, ParticleOptions p, Vec3 c, double radius, int points) {
		ring(level, p, c, radius, points, 0);
	}

	public static void ring(ServerLevel level, ParticleOptions p, Vec3 c, double radius, int points, double phase) {
		for (int i = 0; i < points; i++) {
			double a = phase + Math.PI * 2 * i / points;
			level.sendParticles(p, c.x + Math.cos(a) * radius, c.y, c.z + Math.sin(a) * radius, 1, 0, 0, 0, 0);
		}
	}

	/** Ring whose particles fly outward. */
	public static void shockRing(ServerLevel level, ParticleOptions p, Vec3 c, double radius, int points, double speed) {
		for (int i = 0; i < points; i++) {
			double a = Math.PI * 2 * i / points;
			double cx = Math.cos(a), cz = Math.sin(a);
			level.sendParticles(p, c.x + cx * radius, c.y, c.z + cz * radius, 0, cx, 0.05, cz, speed);
		}
	}

	public static void disc(ServerLevel level, ParticleOptions p, Vec3 c, double radius, int points) {
		for (int i = 0; i < points; i++) {
			double r = radius * Math.sqrt(level.random.nextDouble());
			double a = level.random.nextDouble() * Math.PI * 2;
			level.sendParticles(p, c.x + Math.cos(a) * r, c.y, c.z + Math.sin(a) * r, 1, 0, 0, 0, 0);
		}
	}

	public static void sphere(ServerLevel level, ParticleOptions p, Vec3 c, double radius, int points) {
		double golden = Math.PI * (3 - Math.sqrt(5));
		for (int i = 0; i < points; i++) {
			double y = 1 - (i / (double) (points - 1)) * 2;
			double r = Math.sqrt(1 - y * y);
			double t = golden * i;
			level.sendParticles(p, c.x + Math.cos(t) * r * radius, c.y + y * radius, c.z + Math.sin(t) * r * radius, 1, 0, 0, 0, 0);
		}
	}

	/** Particles from the sphere surface flying inward (implosion) or outward (negative speed). */
	public static void implode(ServerLevel level, ParticleOptions p, Vec3 c, double radius, int points, double speed) {
		for (int i = 0; i < points; i++) {
			Vec3 d = randomDir(level);
			Vec3 pos = c.add(d.scale(radius));
			level.sendParticles(p, pos.x, pos.y, pos.z, 0, -d.x, -d.y, -d.z, speed);
		}
	}

	public static void line(ServerLevel level, ParticleOptions p, Vec3 from, Vec3 to, double step) {
		Vec3 d = to.subtract(from);
		double len = d.length();
		if (len < 1e-4) return;
		int n = Math.min(200, (int) Math.ceil(len / step));
		for (int i = 0; i <= n; i++) {
			Vec3 q = from.add(d.scale(i / (double) n));
			level.sendParticles(p, q.x, q.y, q.z, 1, 0, 0, 0, 0);
		}
	}

	/** Jagged lightning line. */
	public static void bolt(ServerLevel level, ParticleOptions p, Vec3 from, Vec3 to, double jitter) {
		Vec3 prev = from;
		int segs = Math.max(3, (int) (from.distanceTo(to) / 1.5));
		for (int i = 1; i <= segs; i++) {
			Vec3 q = from.lerp(to, i / (double) segs);
			if (i < segs) q = q.add(randomDir(level).scale(jitter * level.random.nextDouble()));
			line(level, p, prev, q, 0.25);
			prev = q;
		}
	}

	public static void helix(ServerLevel level, ParticleOptions p, Vec3 base, double radius, double height, int turns, int points, double phase) {
		for (int i = 0; i < points; i++) {
			double t = i / (double) points;
			double a = phase + t * turns * Math.PI * 2;
			level.sendParticles(p, base.x + Math.cos(a) * radius, base.y + t * height, base.z + Math.sin(a) * radius, 1, 0, 0, 0, 0);
		}
	}

	/** Column rising from c. */
	public static void pillar(ServerLevel level, ParticleOptions p, Vec3 c, double height, int points, double spread) {
		for (int i = 0; i < points; i++) {
			double y = height * i / points;
			level.sendParticles(p, c.x, c.y + y, c.z, 1, spread, 0.05, spread, 0.01);
		}
	}

	public static Vec3 randomDir(ServerLevel level) {
		double u = level.random.nextDouble() * 2 - 1;
		double t = level.random.nextDouble() * Math.PI * 2;
		double s = Math.sqrt(1 - u * u);
		return new Vec3(s * Math.cos(t), u, s * Math.sin(t));
	}

	// ---------------------------------------------------------------- sounds

	public static void sound(ServerLevel level, Vec3 pos, SoundEvent s, float volume, float pitch) {
		level.playSound(null, pos.x, pos.y, pos.z, s, SoundSource.PLAYERS, volume, pitch);
	}

	public static void sound(ServerLevel level, Vec3 pos, Holder<SoundEvent> s, float volume, float pitch) {
		level.playSound(null, pos.x, pos.y, pos.z, s, SoundSource.PLAYERS, volume, pitch);
	}

	public static Holder<SoundEvent> custom(String name) {
		return Holder.direct(SoundEvent.createVariableRangeEvent(ChaosHearts.id(name)));
	}

	/** A sound from the Chaos Hearts resource pack; silent for players without the pack. */
	public static void custom(ServerLevel level, Vec3 pos, String name, float volume, float pitch) {
		level.playSound(null, pos.x, pos.y, pos.z, custom(name), SoundSource.PLAYERS, volume, pitch);
	}

	public static void soundTo(ServerPlayer player, Holder<SoundEvent> s, SoundSource src, float volume, float pitch) {
		player.connection.send(new ClientboundSoundPacket(s, src, player.getX(), player.getY(), player.getZ(), volume, pitch, player.getRandom().nextLong()));
	}

	public static void soundTo(ServerPlayer player, SoundEvent s, float volume, float pitch) {
		soundTo(player, Holder.direct(s), SoundSource.PLAYERS, volume, pitch);
	}

	public static void customTo(ServerPlayer player, String name, SoundSource src, float volume, float pitch) {
		soundTo(player, custom(name), src, volume, pitch);
	}

	// ---------------------------------------------------------------- text

	public static void title(ServerPlayer p, Component title, Component subtitle, int in, int stay, int out) {
		p.connection.send(new ClientboundSetTitlesAnimationPacket(in, stay, out));
		p.connection.send(new ClientboundSetSubtitleTextPacket(subtitle == null ? Component.empty() : subtitle));
		p.connection.send(new ClientboundSetTitleTextPacket(title == null ? Component.empty() : title));
	}

	public static void actionBar(ServerPlayer p, Component c) {
		p.displayClientMessage(c, true);
	}

	/** Frost vignette on the player's screen for a moment (no damage below the freeze threshold). */
	public static void frostScreen(ServerPlayer p, int amount) {
		p.setTicksFrozen(Mth.clamp(Math.max(p.getTicksFrozen(), amount), 0, p.getTicksRequiredToFreeze() - 1));
	}
}
