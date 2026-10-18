package net.chaoshearts.gui;

import java.util.ArrayList;
import java.util.List;

import net.chaoshearts.ability.Ability;
import net.chaoshearts.ability.AbilityManager;
import net.chaoshearts.ability.HeartKit;
import net.chaoshearts.ability.HeartKits;
import net.chaoshearts.data.DataStore;
import net.chaoshearts.data.PlayerData;
import net.chaoshearts.fx.Fx;
import net.chaoshearts.heart.HeartManager;
import net.chaoshearts.heart.HeartType;
import net.chaoshearts.mastery.Mastery;
import net.chaoshearts.skill.SkillManager;
import net.chaoshearts.skill.SkillNode;
import net.chaoshearts.skill.SkillTree;
import net.chaoshearts.trial.TrialManager;
import net.minecraft.ChatFormatting;
import net.minecraft.core.component.DataComponents;
import net.minecraft.network.chat.Component;
import net.minecraft.network.chat.MutableComponent;
import net.minecraft.network.chat.Style;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.world.item.Item;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.Items;
import net.minecraft.world.item.component.CustomModelData;
import net.minecraft.world.item.component.ItemLore;

/** The /hearts menu, the skill tree and the feat list. */
public final class Menus {
	private Menus() {}

	static Style plain(ChatFormatting f) {
		return Style.EMPTY.withColor(f).withItalic(false);
	}

	static ItemStack icon(Item item, Component name, List<Component> lore, boolean glint) {
		ItemStack s = new ItemStack(item);
		s.set(DataComponents.CUSTOM_NAME, name.copy().withStyle(st -> st.withItalic(false)));
		if (!lore.isEmpty()) s.set(DataComponents.LORE, new ItemLore(lore));
		if (glint) s.set(DataComponents.ENCHANTMENT_GLINT_OVERRIDE, true);
		return s;
	}

	static ItemStack heartIcon(HeartType t, Component name, List<Component> lore, boolean glint, boolean awakened) {
		ItemStack s = icon(Items.HEART_OF_THE_SEA, name, lore, glint);
		s.set(DataComponents.CUSTOM_MODEL_DATA, new CustomModelData(List.of(), List.of(), List.of("chaoshearts:focus_" + t.id() + (awakened ? "_awakened" : "")), List.of(t.color)));
		return s;
	}

	static Component line(String s, ChatFormatting f) {
		return Component.literal(s).withStyle(plain(f));
	}

	static String bar(double frac, int len) {
		int n = (int) Math.round(Math.max(0, Math.min(1, frac)) * len);
		return "■".repeat(n) + "□".repeat(len - n);
	}

	private static ItemStack filler() {
		return icon(Items.BLACK_STAINED_GLASS_PANE, Component.literal(" "), List.of(), false);
	}

	private static void click(ServerPlayer p) {
		Fx.soundTo(p, SoundEvents.UI_BUTTON_CLICK.value(), 0.5f, 1.2f);
	}

	// ---------------------------------------------------------------- hearts

	public static void hearts(ServerPlayer p) {
		PlayerData pd = DataStore.get(p);
		ChestGui g = new ChestGui(6, Component.literal("Chaos Hearts").withStyle(ChatFormatting.DARK_PURPLE, ChatFormatting.BOLD));

		g.set(4, 0, icon(Items.NETHER_STAR, Component.literal("Your Hearts").withStyle(ChatFormatting.LIGHT_PURPLE, ChatFormatting.BOLD), List.of(
				line("Hearts you hold: " + pd.hearts.size(), ChatFormatting.GRAY),
				line("Active: " + (pd.active == null ? "none" : pd.active.displayName), ChatFormatting.GRAY),
				Component.empty(),
				line("Click a heart you hold to make it active.", ChatFormatting.DARK_GRAY),
				line("Lose a PvP fight and your newest heart drops.", ChatFormatting.DARK_GRAY),
				line("Your mastery always stays with you.", ChatFormatting.DARK_GRAY)), false), null);

		// Every heart type with this player's mastery, owned or not.
		HeartType[] types = HeartType.values();
		for (int i = 0; i < types.length; i++) {
			HeartType t = types[i];
			PlayerData.HeartProgress prog = pd.progress(t);
			int lvl = Mastery.level(prog.xp);
			boolean owned = pd.owns(t);
			boolean active = pd.active == t;
			List<Component> lore = new ArrayList<>();
			lore.add(line(t.lore, ChatFormatting.DARK_GRAY));
			lore.add(Component.empty());
			lore.add(Component.literal("Mastery " + lvl + "/100  ").withStyle(plain(ChatFormatting.GRAY)).append(Component.literal(bar(lvl / 100.0, 10)).withStyle(t.style().withItalic(false))));
			if (lvl < 100) lore.add(line("Next level: " + Math.round(Mastery.levelProgress(prog.xp) * 100) + "%", ChatFormatting.DARK_GRAY));
			if (prog.awakened) lore.add(line("✦ AWAKENED", ChatFormatting.GOLD));
			lore.add(line("Feats " + prog.feats.size() + "/" + HeartKits.get(t).feats().size(), ChatFormatting.GRAY));
			lore.add(Component.empty());
			if (active) lore.add(line("▶ Active heart", ChatFormatting.GREEN));
			else if (owned) lore.add(line("Click to make active", ChatFormatting.YELLOW));
			else lore.add(line("You do not hold this heart", ChatFormatting.DARK_GRAY));
			lore.add(line("Right-click for abilities", ChatFormatting.DARK_GRAY));
			MutableComponent name = t.title().withStyle(st -> st.withBold(owned));
			ItemStack ic = owned ? heartIcon(t, name, lore, active, prog.awakened) : icon(Items.GRAY_DYE, name, lore, false);
			int slot = (i < 5 ? 9 * 2 + 2 + i : 9 * 3 + 2 + (i - 5));
			g.set(slot, ic, c -> {
				click(p);
				if (c.right()) {
					abilities(p, t);
					return;
				}
				if (!owned) return;
				String err = HeartManager.setActive(p, t, false);
				if (err != null) Fx.actionBar(p, Component.literal(err).withStyle(ChatFormatting.RED));
				hearts(p);
			});
		}

		g.set(1, 5, icon(Items.HEART_OF_THE_SEA, Component.literal("Get a Focus").withStyle(ChatFormatting.AQUA), List.of(line("The item you cast with.", ChatFormatting.GRAY)), false), c -> {
			click(p);
			AbilityManager.ensureFocus(p);
		});
		g.set(3, 5, icon(Items.ENCHANTED_BOOK, Component.literal("Skill Tree").withStyle(ChatFormatting.GOLD), List.of(line("Spend skill points on your active heart.", ChatFormatting.GRAY), line("Unlocks when the heart is awakened.", ChatFormatting.DARK_GRAY)), false), c -> {
			click(p);
			if (pd.active != null) tree(p, pd.active);
		});
		g.set(5, 5, icon(Items.GOLDEN_APPLE, Component.literal("Feats").withStyle(ChatFormatting.YELLOW), List.of(line("Challenges that grant mastery.", ChatFormatting.GRAY)), false), c -> {
			click(p);
			if (pd.active != null) feats(p, pd.active);
		});
		g.set(7, 5, icon(Items.END_CRYSTAL, Component.literal("Awakening Trial").withStyle(ChatFormatting.LIGHT_PURPLE), List.of(line("Reach 100 mastery to face it.", ChatFormatting.GRAY)), false), c -> {
			click(p);
			if (pd.active == null) return;
			p.closeContainer();
			String err = TrialManager.start(p, pd.active, false);
			if (err != null) p.sendSystemMessage(Component.literal(err).withStyle(ChatFormatting.RED));
		});
		g.fill(filler());
		g.open(p);
	}

	public static void abilities(ServerPlayer p, HeartType t) {
		HeartKit kit = HeartKits.get(t);
		PlayerData.HeartProgress prog = DataStore.get(p).progress(t);
		int lvl = Mastery.level(prog.xp);
		ChestGui g = new ChestGui(3, t.title().append(Component.literal(" abilities").withStyle(ChatFormatting.DARK_GRAY)));
		for (int s = 0; s < 4; s++) {
			Ability a = kit.ability(s);
			boolean ok = lvl >= a.unlockLevel() || prog.awakened;
			g.set(1 + s * 2, 1, icon(ok ? Items.BLAZE_POWDER : Items.GUNPOWDER, Component.literal(a.name()).withStyle(ok ? t.style().withBold(true) : plain(ChatFormatting.DARK_GRAY)), List.of(
					line(a.description(), ChatFormatting.GRAY),
					Component.empty(),
					line(AbilityManager.SLOT_KEYS[s] + " with the Focus", ChatFormatting.YELLOW),
					line("Cooldown " + (int) a.baseCooldown() + "s", ChatFormatting.DARK_GRAY),
					line(ok ? "Unlocked" : "Unlocks at mastery " + a.unlockLevel(), ok ? ChatFormatting.GREEN : ChatFormatting.RED)), false), null);
		}
		g.set(0, 0, icon(Items.GLOWSTONE_DUST, Component.literal(kit.passive1Name()).withStyle(t.style()), List.of(line(kit.passive1Description(), ChatFormatting.GRAY), line("Passive, from mastery 0", ChatFormatting.DARK_GRAY)), false), null);
		g.set(8, 0, icon(Items.GLOWSTONE_DUST, Component.literal(kit.passive2Name()).withStyle(t.style()), List.of(line(kit.passive2Description(), ChatFormatting.GRAY), line("Passive, from mastery " + Mastery.LVL_PASSIVE2, ChatFormatting.DARK_GRAY)), lvl >= Mastery.LVL_PASSIVE2), null);
		g.set(4, 0, icon(Items.NETHER_STAR, Component.literal("Awakened: " + kit.awakenedName()).withStyle(ChatFormatting.GOLD), List.of(line(kit.awakenedDescription(), ChatFormatting.GRAY), line(prog.awakened ? "Awakened" : "Complete the trial to awaken", prog.awakened ? ChatFormatting.GREEN : ChatFormatting.DARK_GRAY)), prog.awakened), null);
		g.set(4, 2, icon(Items.ARROW, Component.literal("Back").withStyle(ChatFormatting.GRAY), List.of(), false), c -> hearts(p));
		g.fill(filler());
		g.open(p);
	}

	// ---------------------------------------------------------------- skill tree

	public static void tree(ServerPlayer p, HeartType t) {
		PlayerData.HeartProgress prog = DataStore.get(p).progress(t);
		SkillTree tree = HeartKits.get(t).tree();
		ChestGui g = new ChestGui(6, t.title().append(Component.literal(" — Skill Tree").withStyle(ChatFormatting.DARK_GRAY)));
		int avail = SkillManager.available(t, prog);
		int total = SkillManager.totalPoints(prog);
		long next = SkillManager.xpToNextPoint(prog);
		List<SkillTree.Branch> branches = tree.branches();
		int[] cols = {1, 4, 7};
		for (int b = 0; b < branches.size(); b++) {
			SkillTree.Branch br = branches.get(b);
			for (int tier = 0; tier < br.nodes().size(); tier++) {
				SkillNode n = br.nodes().get(tier);
				SkillManager.Result r = SkillManager.check(prog, t, n.id);
				boolean owned = prog.nodes.contains(n.id);
				Item item;
				ChatFormatting state;
				String status;
				if (owned) {
					item = n.capstone ? Items.NETHER_STAR : Items.LIME_STAINED_GLASS_PANE;
					state = ChatFormatting.GREEN;
					status = "Unlocked";
				} else if (r == SkillManager.Result.OK) {
					item = n.capstone ? Items.END_CRYSTAL : Items.YELLOW_STAINED_GLASS_PANE;
					state = ChatFormatting.YELLOW;
					status = "Click to unlock (" + n.cost + " point" + (n.cost > 1 ? "s" : "") + ")";
				} else {
					item = n.capstone ? Items.FIREWORK_STAR : Items.GRAY_STAINED_GLASS_PANE;
					state = ChatFormatting.DARK_GRAY;
					status = switch (r) {
						case NOT_AWAKENED -> "Awaken this heart first";
						case LOCKED -> "Unlock the node above first";
						case CAPSTONE_TAKEN -> "You already own a capstone";
						case NO_POINTS -> "Needs " + n.cost + " points";
						default -> "Locked";
					};
				}
				List<Component> lore = new ArrayList<>();
				lore.add(line(n.description, ChatFormatting.GRAY));
				lore.add(Component.empty());
				lore.add(line(br.name() + " · tier " + (tier + 1) + (n.capstone ? " · CAPSTONE" : ""), ChatFormatting.DARK_GRAY));
				lore.add(line(status, state));
				String nodeId = n.id;
				g.set(cols[b], tier, icon(item, Component.literal(n.name).withStyle(owned ? Style.EMPTY.withColor(br.color()).withBold(true) : plain(state)), lore, owned), c -> {
					SkillManager.Result res = SkillManager.unlock(p, t, nodeId);
					if (res == SkillManager.Result.OK) {
						Fx.soundTo(p, SoundEvents.PLAYER_LEVELUP, 0.8f, 1.6f);
						Fx.customTo(p, "skill_unlock", net.minecraft.sounds.SoundSource.MASTER, 1f, 1f);
					} else {
						Fx.soundTo(p, SoundEvents.VILLAGER_NO, 0.6f, 1f);
					}
					tree(p, t);
				});
			}
			g.set(cols[b] + (b == 2 ? -1 : 1), 0, icon(Items.PAPER, Component.literal(br.name()).withStyle(Style.EMPTY.withColor(br.color()).withBold(true).withItalic(false)), List.of(line(br.description(), ChatFormatting.GRAY)), false), null);
		}
		g.set(4, 5, icon(Items.EXPERIENCE_BOTTLE, Component.literal("Skill points: " + avail + " / " + total).withStyle(ChatFormatting.GOLD, ChatFormatting.BOLD), List.of(
				line(prog.awakened ? "Earn more by gaining mastery XP after awakening." : "Awaken the heart to earn skill points.", ChatFormatting.GRAY),
				line(next > 0 ? "Next point in " + next + " XP" : (prog.awakened ? "Point cap reached" : ""), ChatFormatting.DARK_GRAY),
				line("Only one capstone per tree.", ChatFormatting.DARK_GRAY)), avail > 0), null);
		g.set(8, 5, icon(Items.BARRIER, Component.literal("Reset tree").withStyle(ChatFormatting.RED), List.of(
				line(prog.respecs == 0 ? "Your first reset is free." : "Costs " + net.chaoshearts.config.ChaosConfig.get().respecCostLevels + " levels, once a day.", ChatFormatting.GRAY),
				line("Shift-click to confirm.", ChatFormatting.DARK_GRAY)), false), c -> {
			if (!c.shift()) {
				Fx.actionBar(p, Component.literal("Shift-click to reset the tree.").withStyle(ChatFormatting.GRAY));
				return;
			}
			String err = SkillManager.respec(p, t, false);
			if (err != null) Fx.actionBar(p, Component.literal(err).withStyle(ChatFormatting.RED));
			else Fx.soundTo(p, SoundEvents.GRINDSTONE_USE, 0.8f, 1f);
			tree(p, t);
		});
		g.set(0, 5, icon(Items.ARROW, Component.literal("Back").withStyle(ChatFormatting.GRAY), List.of(), false), c -> hearts(p));
		g.fill(filler());
		g.open(p);
	}

	// ---------------------------------------------------------------- feats

	public static void feats(ServerPlayer p, HeartType t) {
		PlayerData.HeartProgress prog = DataStore.get(p).progress(t);
		HeartKit kit = HeartKits.get(t);
		ChestGui g = new ChestGui(3, t.title().append(Component.literal(" — Feats").withStyle(ChatFormatting.DARK_GRAY)));
		int i = 0;
		for (HeartKit.Feat f : kit.feats()) {
			boolean done = prog.feats.contains(f.id());
			g.set(1 + i * 2, 1, icon(done ? Items.GOLD_BLOCK : Items.COAL, Component.literal((done ? "★ " : "☆ ") + f.name()).withStyle(done ? plain(ChatFormatting.GOLD) : plain(ChatFormatting.GRAY)), List.of(
					line(f.description(), ChatFormatting.GRAY),
					line("+" + f.xp() + " mastery XP", ChatFormatting.DARK_GREEN),
					line(done ? "Complete" : "Not yet", done ? ChatFormatting.GREEN : ChatFormatting.DARK_GRAY)), done), null);
			i++;
		}
		g.set(4, 2, icon(Items.ARROW, Component.literal("Back").withStyle(ChatFormatting.GRAY), List.of(), false), c -> hearts(p));
		g.fill(filler());
		g.open(p);
	}
}
