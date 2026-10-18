package net.chaoshearts.gui;

import java.util.HashMap;
import java.util.Map;
import java.util.function.Consumer;

import net.minecraft.network.chat.Component;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.world.Container;
import net.minecraft.world.SimpleContainer;
import net.minecraft.world.SimpleMenuProvider;
import net.minecraft.world.entity.player.Inventory;
import net.minecraft.world.entity.player.Player;
import net.minecraft.world.inventory.ChestMenu;
import net.minecraft.world.inventory.ClickType;
import net.minecraft.world.inventory.MenuType;
import net.minecraft.world.item.ItemStack;

/**
 * A server-side chest menu with buttons. Nothing can be taken out of it; every click is routed
 * to the button's action. Works with vanilla clients.
 */
public class ChestGui {
	public record Click(ServerPlayer player, ClickType type, int button) {
		public boolean right() {
			return button == 1;
		}

		public boolean shift() {
			return type == ClickType.QUICK_MOVE;
		}
	}

	private final int rows;
	private final Component title;
	private final SimpleContainer container;
	private final Map<Integer, Consumer<Click>> actions = new HashMap<>();

	public ChestGui(int rows, Component title) {
		this.rows = rows;
		this.title = title;
		this.container = new SimpleContainer(rows * 9);
	}

	public ChestGui set(int slot, ItemStack icon, Consumer<Click> action) {
		container.setItem(slot, icon);
		if (action != null) actions.put(slot, action);
		else actions.remove(slot);
		return this;
	}

	public ChestGui set(int col, int row, ItemStack icon, Consumer<Click> action) {
		return set(row * 9 + col, icon, action);
	}

	public void fill(ItemStack filler) {
		for (int i = 0; i < container.getContainerSize(); i++) {
			if (container.getItem(i).isEmpty()) container.setItem(i, filler.copy());
		}
	}

	public void clear() {
		container.clearContent();
		actions.clear();
	}

	public void open(ServerPlayer player) {
		MenuType<ChestMenu> type = switch (rows) {
			case 1 -> MenuType.GENERIC_9x1;
			case 2 -> MenuType.GENERIC_9x2;
			case 3 -> MenuType.GENERIC_9x3;
			case 4 -> MenuType.GENERIC_9x4;
			case 5 -> MenuType.GENERIC_9x5;
			default -> MenuType.GENERIC_9x6;
		};
		player.openMenu(new SimpleMenuProvider((id, inv, p) -> new Menu(type, id, inv, container, rows, this), title));
	}

	void handle(int slot, int button, ClickType type, Player player) {
		Consumer<Click> a = actions.get(slot);
		if (a != null && player instanceof ServerPlayer sp) a.accept(new Click(sp, type, button));
	}

	private static final class Menu extends ChestMenu {
		private final ChestGui gui;
		private final int size;

		Menu(MenuType<?> type, int id, Inventory inv, Container container, int rows, ChestGui gui) {
			super(type, id, inv, container, rows);
			this.gui = gui;
			this.size = rows * 9;
		}

		@Override
		public void clicked(int slotId, int button, ClickType clickType, Player player) {
			// Never move items; just run the button and resync the client's view.
			if (slotId >= 0 && slotId < size) gui.handle(slotId, button, clickType, player);
			sendAllDataToRemote();
		}

		@Override
		public ItemStack quickMoveStack(Player player, int index) {
			return ItemStack.EMPTY;
		}

		@Override
		public boolean stillValid(Player player) {
			return true;
		}
	}
}
