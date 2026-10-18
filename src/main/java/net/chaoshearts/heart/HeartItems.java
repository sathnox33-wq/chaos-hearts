package net.chaoshearts.heart;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import net.chaoshearts.ability.HeartKit;
import net.chaoshearts.ability.HeartKits;
import net.chaoshearts.mastery.Mastery;
import net.minecraft.ChatFormatting;
import net.minecraft.core.component.DataComponents;
import net.minecraft.nbt.CompoundTag;
import net.minecraft.network.chat.Component;
import net.minecraft.network.chat.MutableComponent;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.Items;
import net.minecraft.world.item.Rarity;
import net.minecraft.world.item.component.CustomData;
import net.minecraft.world.item.component.CustomModelData;
import net.minecraft.world.item.component.ItemLore;

/**
 * Builds and reads the two kinds of Chaos Hearts item stacks. Both are heart_of_the_sea stacks
 * so players without the resource pack still see something sensible.
 * <ul>
 * <li><b>Focus</b>: the caster. Holds nothing of value; bound to its owner.</li>
 * <li><b>Heart token</b>: only ever exists as a dropped item entity waiting to be collected.</li>
 * </ul>
 */
public final class HeartItems {
	public static final String ROOT = "chaoshearts";

	private HeartItems() {}

	public static ItemStack focus(UUID owner, HeartType type, int mastery, boolean awakened) {
		ItemStack s = new ItemStack(Items.HEART_OF_THE_SEA);
		CompoundTag inner = new CompoundTag();
		inner.putString("kind", "focus");
		inner.putString("owner", owner.toString());
		inner.putString("heart", type.id());
		inner.putBoolean("awakened", awakened);
		inner.putInt("tier", Mastery.visualTier(mastery, awakened));
		inner.putInt("mastery", mastery);
		CompoundTag tag = new CompoundTag();
		tag.put(ROOT, inner);
		s.set(DataComponents.CUSTOM_DATA, CustomData.of(tag));
		s.set(DataComponents.MAX_STACK_SIZE, 1);
		s.set(DataComponents.RARITY, awakened ? Rarity.EPIC : Rarity.RARE);
		s.set(DataComponents.CUSTOM_MODEL_DATA, new CustomModelData(List.of(), List.of(),
				List.of("chaoshearts:focus_" + type.id() + (awakened ? "_awakened" : "")), List.of(type.color)));
		if (mastery >= 25 || awakened) s.set(DataComponents.ENCHANTMENT_GLINT_OVERRIDE, true);

		MutableComponent name = Component.literal(awakened ? "Awakened " : "").withStyle(type.style().withBold(awakened).withItalic(false))
				.append(Component.literal(type.displayName + " Heart").withStyle(type.style().withItalic(false)));
		s.set(DataComponents.CUSTOM_NAME, name);

		List<Component> lore = new ArrayList<>();
		lore.add(line(type.lore, ChatFormatting.DARK_GRAY, true));
		lore.add(Component.empty());
		lore.add(Component.literal("Mastery ").withStyle(s0(ChatFormatting.GRAY)).append(Component.literal(mastery + "/100").withStyle(type.style().withItalic(false))));
		HeartKit kit = HeartKits.get(type);
		if (kit != null) {
			for (int slot = 0; slot < 4; slot++) {
				var ab = kit.ability(slot);
				boolean unlocked = mastery >= ab.unlockLevel();
				String key = switch (slot) {
					case 0 -> "Right-click";
					case 1 -> "Sneak + Right-click";
					case 2 -> "Swap Hands (F)";
					default -> "Sneak + Swap Hands";
				};
				MutableComponent l = Component.literal((unlocked ? "◆ " : "◇ ") + ab.name()).withStyle(unlocked ? type.style().withItalic(false) : s0(ChatFormatting.DARK_GRAY))
						.append(Component.literal("  " + key).withStyle(s0(ChatFormatting.DARK_GRAY)));
				if (!unlocked) l.append(Component.literal("  (mastery " + ab.unlockLevel() + ")").withStyle(s0(ChatFormatting.DARK_GRAY)));
				lore.add(l);
			}
		}
		lore.add(Component.empty());
		lore.add(line("Bound to its owner. Your hearts live in your soul,", ChatFormatting.DARK_PURPLE, true));
		lore.add(line("not in this item: /hearts to manage them.", ChatFormatting.DARK_PURPLE, true));
		s.set(DataComponents.LORE, new ItemLore(lore));
		return s;
	}

	public static ItemStack token(UUID heartId, HeartType type, String collectorName) {
		ItemStack s = new ItemStack(Items.HEART_OF_THE_SEA);
		CompoundTag inner = new CompoundTag();
		inner.putString("kind", "heart");
		inner.putString("id", heartId.toString());
		inner.putString("heart", type.id());
		CompoundTag tag = new CompoundTag();
		tag.put(ROOT, inner);
		s.set(DataComponents.CUSTOM_DATA, CustomData.of(tag));
		s.set(DataComponents.MAX_STACK_SIZE, 1);
		s.set(DataComponents.RARITY, Rarity.EPIC);
		s.set(DataComponents.ENCHANTMENT_GLINT_OVERRIDE, true);
		s.set(DataComponents.CUSTOM_MODEL_DATA, new CustomModelData(List.of(), List.of(), List.of("chaoshearts:heart_" + type.id()), List.of(type.color)));
		s.set(DataComponents.CUSTOM_NAME, type.title().withStyle(st -> st.withItalic(false).withBold(true)));
		List<Component> lore = new ArrayList<>();
		lore.add(line(type.lore, ChatFormatting.DARK_GRAY, true));
		if (collectorName != null) lore.add(line("Claimable by " + collectorName, ChatFormatting.GOLD, false));
		s.set(DataComponents.LORE, new ItemLore(lore));
		return s;
	}

	private static net.minecraft.network.chat.Style s0(ChatFormatting f) {
		return net.minecraft.network.chat.Style.EMPTY.withColor(f).withItalic(false);
	}

	private static Component line(String text, ChatFormatting color, boolean italic) {
		return Component.literal(text).withStyle(net.minecraft.network.chat.Style.EMPTY.withColor(color).withItalic(italic));
	}

	private static CompoundTag data(ItemStack s) {
		if (s == null || s.isEmpty()) return null;
		CustomData cd = s.get(DataComponents.CUSTOM_DATA);
		if (cd == null) return null;
		CompoundTag t = cd.copyTag();
		if (!t.contains(ROOT)) return null;
		return t.getCompoundOrEmpty(ROOT);
	}

	public static boolean isFocus(ItemStack s) {
		CompoundTag t = data(s);
		return t != null && "focus".equals(t.getStringOr("kind", ""));
	}

	public static boolean isToken(ItemStack s) {
		CompoundTag t = data(s);
		return t != null && "heart".equals(t.getStringOr("kind", ""));
	}

	public static UUID focusOwner(ItemStack s) {
		CompoundTag t = data(s);
		return t == null ? null : parse(t.getStringOr("owner", ""));
	}

	public static String focusSignature(ItemStack s) {
		CompoundTag t = data(s);
		if (t == null) return "";
		return t.getStringOr("heart", "") + "|" + t.getBooleanOr("awakened", false) + "|" + t.getIntOr("mastery", 0);
	}

	public static UUID tokenId(ItemStack s) {
		CompoundTag t = data(s);
		return t == null ? null : parse(t.getStringOr("id", ""));
	}

	private static UUID parse(String s) {
		try {
			return UUID.fromString(s);
		} catch (Exception e) {
			return null;
		}
	}
}
