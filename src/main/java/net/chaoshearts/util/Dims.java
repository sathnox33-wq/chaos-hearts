package net.chaoshearts.util;

import net.minecraft.core.registries.Registries;
import net.minecraft.resources.Identifier;
import net.minecraft.resources.ResourceKey;
import net.minecraft.server.MinecraftServer;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.world.level.Level;

/** Dimension key helpers, kept in one place. */
public final class Dims {
	private Dims() {}

	public static String id(Level level) {
		return id(level.dimension());
	}

	public static String id(ResourceKey<Level> key) {
		return key.identifier().toString();
	}

	public static ResourceKey<Level> key(String id) {
		return ResourceKey.create(Registries.DIMENSION, Identifier.parse(id));
	}

	public static ServerLevel level(MinecraftServer server, String id) {
		if (id == null) return null;
		try {
			return server.getLevel(key(id));
		} catch (Exception e) {
			return null;
		}
	}
}
