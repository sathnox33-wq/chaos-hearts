package net.chaoshearts.heart;

import java.util.Locale;
import java.util.Optional;

import net.minecraft.ChatFormatting;
import net.minecraft.network.chat.Component;
import net.minecraft.network.chat.MutableComponent;
import net.minecraft.network.chat.Style;
import net.minecraft.network.chat.TextColor;

public enum HeartType {
	RAGE("Rage", 0xE0262B, 0x5A0A0A, ChatFormatting.RED, "Fury given form. It grows stronger the longer the fight lasts."),
	SPEED("Speed", 0xF5E142, 0x29D3F2, ChatFormatting.YELLOW, "A heart that never stops racing. Time bends around it."),
	INFERNAL("Infernal", 0xFF7A1A, 0x8C1C00, ChatFormatting.GOLD, "Forged in the deepest lava. It burns everything it touches."),
	VOID("Void", 0x8A3CFF, 0x14002B, ChatFormatting.DARK_PURPLE, "A hole in the world, beating. Space folds at its will."),
	FROZEN("Frozen", 0x9BE7FF, 0x2F6FA8, ChatFormatting.AQUA, "So cold it hurts to hold. It stills blood and breath."),
	STORM("Storm", 0x4FA8FF, 0xE8F6FF, ChatFormatting.BLUE, "Thunder trapped in a chamber of glass, begging to be let out."),
	BLOOD("Blood", 0x9E0B1F, 0x2B0006, ChatFormatting.DARK_RED, "It hungers. Every wound you deal feeds it, and you."),
	TITAN("Titan", 0xC9A45C, 0x5B5348, ChatFormatting.GRAY, "The heart of a mountain. Unmoving, unbreakable, enormous."),
	CELESTIAL("Celestial", 0xFFF2B0, 0xFFC94A, ChatFormatting.WHITE, "A fallen star that still remembers the sky."),
	CORRUPTION("Corruption", 0x7BD13A, 0x3D1A52, ChatFormatting.GREEN, "Rot that thinks. It spreads from host to host.");

	public final String displayName;
	public final int color;
	public final int secondaryColor;
	public final ChatFormatting chatColor;
	public final String lore;

	HeartType(String displayName, int color, int secondaryColor, ChatFormatting chatColor, String lore) {
		this.displayName = displayName;
		this.color = color;
		this.secondaryColor = secondaryColor;
		this.chatColor = chatColor;
		this.lore = lore;
	}

	public String id() {
		return name().toLowerCase(Locale.ROOT);
	}

	public Style style() {
		return Style.EMPTY.withColor(TextColor.fromRgb(color));
	}

	/** "Rage Heart" in the heart's colour. */
	public MutableComponent title() {
		return Component.literal(displayName + " Heart").withStyle(style());
	}

	public MutableComponent label() {
		return Component.literal(displayName).withStyle(style());
	}

	public static Optional<HeartType> byId(String id) {
		if (id == null) return Optional.empty();
		for (HeartType t : values()) {
			if (t.id().equalsIgnoreCase(id) || t.displayName.equalsIgnoreCase(id)) return Optional.of(t);
		}
		return Optional.empty();
	}
}
