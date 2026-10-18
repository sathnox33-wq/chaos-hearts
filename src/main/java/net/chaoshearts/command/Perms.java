package net.chaoshearts.command;

import java.util.function.Predicate;

import net.minecraft.commands.CommandSourceStack;
import net.minecraft.server.permissions.Permission;
import net.minecraft.server.permissions.PermissionLevel;

/** The one place that knows how 1.21.11 checks operator levels. */
public final class Perms {
	/** Admin commands and the Eye need gamemaster level (2), like /give. */
	public static final int ADMIN = 2;

	private Perms() {}

	public static boolean has(CommandSourceStack source, int level) {
		return source.permissions().hasPermission(new Permission.HasCommandLevel(PermissionLevel.byId(level)));
	}

	public static Predicate<CommandSourceStack> require(int level) {
		return s -> has(s, level);
	}
}
