package net.chaoshearts.command;

import java.util.Arrays;
import java.util.Collection;
import java.util.UUID;

import com.mojang.brigadier.CommandDispatcher;
import com.mojang.brigadier.arguments.BoolArgumentType;
import com.mojang.brigadier.arguments.FloatArgumentType;
import com.mojang.brigadier.arguments.IntegerArgumentType;
import com.mojang.brigadier.arguments.LongArgumentType;
import com.mojang.brigadier.arguments.StringArgumentType;
import com.mojang.brigadier.builder.RequiredArgumentBuilder;
import com.mojang.brigadier.context.CommandContext;
import com.mojang.brigadier.exceptions.CommandSyntaxException;
import com.mojang.brigadier.exceptions.SimpleCommandExceptionType;

import net.chaoshearts.ability.Ability;
import net.chaoshearts.ability.AbilityManager;
import net.chaoshearts.ability.HeartKit;
import net.chaoshearts.ability.HeartKits;
import net.chaoshearts.config.ChaosConfig;
import net.chaoshearts.data.DataStore;
import net.chaoshearts.data.HeartRecord;
import net.chaoshearts.data.PlayerData;
import net.chaoshearts.eye.EyeManager;
import net.chaoshearts.gui.Menus;
import net.chaoshearts.heart.HeartManager;
import net.chaoshearts.heart.HeartType;
import net.chaoshearts.mastery.Mastery;
import net.chaoshearts.skill.SkillManager;
import net.chaoshearts.trial.TrialManager;
import net.minecraft.ChatFormatting;
import net.minecraft.commands.CommandBuildContext;
import net.minecraft.commands.CommandSourceStack;
import net.minecraft.commands.Commands;
import net.minecraft.commands.SharedSuggestionProvider;
import net.minecraft.commands.arguments.EntityArgument;
import net.minecraft.network.chat.Component;
import net.minecraft.network.chat.MutableComponent;
import net.minecraft.server.level.ServerPlayer;

/** /hearts for players, /chaos cast for keybind mods, /chaosadmin and /eye for operators. */
public final class ChaosCommands {
	private static final SimpleCommandExceptionType UNKNOWN_HEART = new SimpleCommandExceptionType(Component.literal("Unknown heart. Use one of: " + String.join(", ", Arrays.stream(HeartType.values()).map(HeartType::id).toList())));

	private ChaosCommands() {}

	public static void register(CommandDispatcher<CommandSourceStack> d, CommandBuildContext ctx, Commands.CommandSelection env) {
		registerHearts(d);
		registerCast(d);
		registerAdmin(d);
		EyeManager.registerCommands(d);
	}

	// ---------------------------------------------------------------- helpers

	public static RequiredArgumentBuilder<CommandSourceStack, String> heartArg(String name) {
		return Commands.argument(name, StringArgumentType.word())
				.suggests((c, b) -> SharedSuggestionProvider.suggest(Arrays.stream(HeartType.values()).map(HeartType::id), b));
	}

	public static HeartType heart(CommandContext<CommandSourceStack> c, String name) throws CommandSyntaxException {
		return HeartType.byId(StringArgumentType.getString(c, name)).orElseThrow(UNKNOWN_HEART::create);
	}

	private static int ok(CommandSourceStack s, String msg) {
		s.sendSuccess(() -> Component.literal(msg).withStyle(ChatFormatting.LIGHT_PURPLE), true);
		return 1;
	}

	private static int fail(CommandSourceStack s, String msg) {
		s.sendFailure(Component.literal(msg));
		return 0;
	}

	private static HeartType activeOrFail(ServerPlayer p) {
		HeartType t = DataStore.get(p).active;
		if (t == null) p.sendSystemMessage(Component.literal("You do not hold a Chaos Heart. Defeat a heart-bearer in PvP to claim one.").withStyle(ChatFormatting.RED));
		return t;
	}

	// ---------------------------------------------------------------- /hearts

	private static void registerHearts(CommandDispatcher<CommandSourceStack> d) {
		d.register(Commands.literal("hearts")
				.executes(c -> {
					Menus.hearts(c.getSource().getPlayerOrException());
					return 1;
				})
				.then(Commands.literal("list").executes(c -> list(c.getSource(), c.getSource().getPlayerOrException())))
				.then(Commands.literal("equip").then(heartArg("heart").executes(c -> {
					ServerPlayer p = c.getSource().getPlayerOrException();
					String err = HeartManager.setActive(p, heart(c, "heart"), false);
					return err == null ? 1 : fail(c.getSource(), err);
				})))
				.then(Commands.literal("focus").executes(c -> {
					ServerPlayer p = c.getSource().getPlayerOrException();
					if (activeOrFail(p) == null) return 0;
					AbilityManager.ensureFocus(p);
					AbilityManager.refreshFocus(p);
					return 1;
				}))
				.then(Commands.literal("tree")
						.executes(c -> {
							ServerPlayer p = c.getSource().getPlayerOrException();
							HeartType t = activeOrFail(p);
							if (t != null) Menus.tree(p, t);
							return t == null ? 0 : 1;
						})
						.then(heartArg("heart").executes(c -> {
							Menus.tree(c.getSource().getPlayerOrException(), heart(c, "heart"));
							return 1;
						})))
				.then(Commands.literal("feats")
						.executes(c -> {
							ServerPlayer p = c.getSource().getPlayerOrException();
							HeartType t = activeOrFail(p);
							if (t != null) Menus.feats(p, t);
							return t == null ? 0 : 1;
						})
						.then(heartArg("heart").executes(c -> {
							Menus.feats(c.getSource().getPlayerOrException(), heart(c, "heart"));
							return 1;
						})))
				.then(Commands.literal("trial")
						.executes(c -> {
							ServerPlayer p = c.getSource().getPlayerOrException();
							HeartType t = activeOrFail(p);
							if (t == null) return 0;
							String err = TrialManager.start(p, t, false);
							return err == null ? 1 : fail(c.getSource(), err);
						})
						.then(Commands.literal("leave").executes(c -> {
							ServerPlayer p = c.getSource().getPlayerOrException();
							if (!TrialManager.inTrial(p)) return fail(c.getSource(), "You are not in a trial.");
							TrialManager.fail(p.getUUID(), "You abandoned the trial.");
							return 1;
						})))
				.then(Commands.literal("info").then(heartArg("heart").executes(c -> info(c.getSource(), heart(c, "heart"))))));
	}

	private static int list(CommandSourceStack s, ServerPlayer p) {
		PlayerData pd = DataStore.get(p);
		MutableComponent out = Component.literal("— Chaos Hearts —").withStyle(ChatFormatting.DARK_PURPLE, ChatFormatting.BOLD);
		for (HeartType t : HeartType.values()) {
			PlayerData.HeartProgress prog = pd.progress(t);
			int lvl = Mastery.level(prog.xp);
			boolean owned = pd.owns(t);
			if (!owned && prog.xp == 0) continue;
			out.append(Component.literal("\n" + (pd.active == t ? "▶ " : owned ? "❤ " : "  ")).withStyle(owned ? ChatFormatting.WHITE : ChatFormatting.DARK_GRAY))
					.append(t.title())
					.append(Component.literal("  mastery " + lvl + "/100" + (prog.awakened ? "  ✦ awakened" : "") + (owned ? "" : "  (not held)")).withStyle(ChatFormatting.GRAY));
		}
		if (pd.hearts.isEmpty()) out.append(Component.literal("\nYou hold no hearts. Win one in PvP.").withStyle(ChatFormatting.GRAY));
		else out.append(Component.literal("\nNewest heart (drops on a PvP death): ").withStyle(ChatFormatting.DARK_GRAY)).append(pd.latest().type.title());
		s.sendSuccess(() -> out, false);
		return 1;
	}

	private static int info(CommandSourceStack s, HeartType t) {
		HeartKit kit = HeartKits.get(t);
		MutableComponent out = t.title().withStyle(st -> st.withBold(true));
		out.append(Component.literal("\n" + t.lore).withStyle(ChatFormatting.DARK_GRAY, ChatFormatting.ITALIC));
		out.append(Component.literal("\nPassive: ").withStyle(ChatFormatting.GOLD)).append(Component.literal(kit.passive1Name() + " — " + kit.passive1Description()).withStyle(ChatFormatting.GRAY));
		for (int i = 0; i < 4; i++) {
			Ability a = kit.ability(i);
			out.append(Component.literal("\n[" + AbilityManager.SLOT_KEYS[i] + "] ").withStyle(ChatFormatting.YELLOW))
					.append(Component.literal(a.name()).withStyle(t.style()))
					.append(Component.literal(" (mastery " + a.unlockLevel() + ", " + (int) a.baseCooldown() + "s) — " + a.description()).withStyle(ChatFormatting.GRAY));
		}
		out.append(Component.literal("\nMastery " + Mastery.LVL_PASSIVE2 + ": ").withStyle(ChatFormatting.GOLD)).append(Component.literal(kit.passive2Name() + " — " + kit.passive2Description()).withStyle(ChatFormatting.GRAY));
		out.append(Component.literal("\nAwakened: ").withStyle(ChatFormatting.GOLD)).append(Component.literal(kit.awakenedName() + " — " + kit.awakenedDescription()).withStyle(ChatFormatting.GRAY));
		s.sendSuccess(() -> out, false);
		return 1;
	}

	// ---------------------------------------------------------------- /chaos cast

	private static void registerCast(CommandDispatcher<CommandSourceStack> d) {
		d.register(Commands.literal("chaos").then(Commands.literal("cast").then(Commands.argument("slot", IntegerArgumentType.integer(1, 4)).executes(c -> {
			ServerPlayer p = c.getSource().getPlayerOrException();
			int slot = IntegerArgumentType.getInteger(c, "slot") - 1;
			var focus = net.chaoshearts.heart.HeartItems.isFocus(p.getMainHandItem()) ? p.getMainHandItem() : p.getOffhandItem();
			if (!net.chaoshearts.heart.HeartItems.isFocus(focus)) return fail(c.getSource(), "Hold your Focus to cast.");
			AbilityManager.tryCast(p, slot, focus);
			return 1;
		}))));
	}

	// ---------------------------------------------------------------- /chaosadmin

	private static void registerAdmin(CommandDispatcher<CommandSourceStack> d) {
		d.register(Commands.literal("chaosadmin").requires(Perms.require(Perms.ADMIN))
				.then(Commands.literal("give").then(Commands.argument("player", EntityArgument.player()).then(heartArg("heart")
						.executes(c -> give(c, false))
						.then(Commands.argument("force", BoolArgumentType.bool()).executes(c -> give(c, BoolArgumentType.getBool(c, "force")))))))
				.then(Commands.literal("take").then(Commands.argument("player", EntityArgument.player()).then(heartArg("heart").executes(c -> {
					ServerPlayer p = EntityArgument.getPlayer(c, "player");
					HeartType t = heart(c, "heart");
					HeartRecord rec = heldRecord(p, t);
					if (rec == null) return fail(c.getSource(), p.getName().getString() + " does not hold the " + t.displayName + " Heart.");
					HeartManager.destroy(rec);
					p.sendSystemMessage(Component.literal("Your ").withStyle(ChatFormatting.GRAY).append(t.title()).append(Component.literal(" was removed by an admin.").withStyle(ChatFormatting.GRAY)));
					return ok(c.getSource(), "Removed the " + t.displayName + " Heart from " + p.getName().getString() + ".");
				}))))
				.then(Commands.literal("transfer").then(Commands.argument("from", EntityArgument.player()).then(heartArg("heart").then(Commands.argument("to", EntityArgument.player()).executes(c -> {
					ServerPlayer from = EntityArgument.getPlayer(c, "from");
					ServerPlayer to = EntityArgument.getPlayer(c, "to");
					HeartType t = heart(c, "heart");
					HeartRecord rec = heldRecord(from, t);
					if (rec == null) return fail(c.getSource(), from.getName().getString() + " does not hold the " + t.displayName + " Heart.");
					if (TrialManager.inTrial(from) || TrialManager.inTrial(to)) return fail(c.getSource(), "Wait until the trial is over.");
					HeartManager.transfer(rec, to, "was given to you");
					return ok(c.getSource(), "Moved the " + t.displayName + " Heart to " + to.getName().getString() + ".");
				})))))
				.then(Commands.literal("registry").executes(c -> registry(c.getSource())))
				.then(Commands.literal("destroy").then(Commands.argument("id", StringArgumentType.word()).executes(c -> {
					HeartRecord rec = findRecord(StringArgumentType.getString(c, "id"));
					if (rec == null) return fail(c.getSource(), "No heart with that id. See /chaosadmin registry.");
					HeartManager.destroy(rec);
					return ok(c.getSource(), "Destroyed heart " + rec.id + ".");
				})))
				.then(Commands.literal("returnall").executes(c -> {
					int n = 0;
					for (HeartRecord rec : HeartManager.records()) {
						if (rec.state == HeartRecord.State.DROPPED) {
							HeartManager.returnToOwner(rec, "was returned to you by an admin");
							n++;
						}
					}
					return ok(c.getSource(), "Returned " + n + " dropped heart" + (n == 1 ? "" : "s") + " to their owners.");
				}))
				.then(Commands.literal("mastery").then(Commands.argument("player", EntityArgument.player()).then(heartArg("heart")
						.then(Commands.literal("set").then(Commands.argument("level", IntegerArgumentType.integer(0, 100)).executes(c -> {
							ServerPlayer p = EntityArgument.getPlayer(c, "player");
							HeartType t = heart(c, "heart");
							int lvl = IntegerArgumentType.getInteger(c, "level");
							Mastery.setLevel(p, t, lvl);
							return ok(c.getSource(), p.getName().getString() + "'s " + t.displayName + " mastery is now " + lvl + ".");
						})))
						.then(Commands.literal("add").then(Commands.argument("xp", LongArgumentType.longArg(-1_000_000, 1_000_000)).executes(c -> {
							ServerPlayer p = EntityArgument.getPlayer(c, "player");
							HeartType t = heart(c, "heart");
							Mastery.addRaw(p, t, LongArgumentType.getLong(c, "xp"));
							AbilityManager.refreshFocus(p);
							return ok(c.getSource(), p.getName().getString() + "'s " + t.displayName + " mastery is now " + Mastery.level(p, t) + " (" + DataStore.get(p).progress(t).xp + " XP).");
						}))))))
				.then(Commands.literal("awaken").then(Commands.argument("player", EntityArgument.player()).then(heartArg("heart")
						.executes(c -> {
							ServerPlayer p = EntityArgument.getPlayer(c, "player");
							HeartType t = heart(c, "heart");
							TrialManager.awaken(p, t, 0);
							return ok(c.getSource(), "Awakened " + p.getName().getString() + "'s " + t.displayName + " Heart.");
						})
						.then(Commands.literal("revoke").executes(c -> {
							ServerPlayer p = EntityArgument.getPlayer(c, "player");
							HeartType t = heart(c, "heart");
							PlayerData.HeartProgress prog = DataStore.get(p).progress(t);
							prog.awakened = false;
							prog.nodes.clear();
							SkillManager.invalidate(p.getUUID());
							DataStore.markDirty();
							AbilityManager.refreshFocus(p);
							return ok(c.getSource(), "Revoked the awakening of " + p.getName().getString() + "'s " + t.displayName + " Heart.");
						})))))
				.then(Commands.literal("points").then(Commands.argument("player", EntityArgument.player()).then(heartArg("heart").then(Commands.argument("bonus", IntegerArgumentType.integer(-15, 15)).executes(c -> {
					ServerPlayer p = EntityArgument.getPlayer(c, "player");
					HeartType t = heart(c, "heart");
					PlayerData.HeartProgress prog = DataStore.get(p).progress(t);
					prog.bonusPoints = IntegerArgumentType.getInteger(c, "bonus");
					SkillManager.invalidate(p.getUUID());
					DataStore.markDirty();
					return ok(c.getSource(), p.getName().getString() + " now has " + SkillManager.available(t, prog) + " unspent " + t.displayName + " points (" + SkillManager.totalPoints(prog) + " total).");
				})))))
				.then(Commands.literal("respec").then(Commands.argument("player", EntityArgument.player()).then(heartArg("heart").executes(c -> {
					ServerPlayer p = EntityArgument.getPlayer(c, "player");
					HeartType t = heart(c, "heart");
					String err = SkillManager.respec(p, t, true);
					return err == null ? ok(c.getSource(), "Reset " + p.getName().getString() + "'s " + t.displayName + " tree.") : fail(c.getSource(), err);
				}))))
				.then(Commands.literal("cooldowns").then(Commands.argument("players", EntityArgument.players()).executes(c -> {
					Collection<ServerPlayer> ps = EntityArgument.getPlayers(c, "players");
					for (ServerPlayer p : ps) AbilityManager.resetCooldowns(p);
					return ok(c.getSource(), "Reset cooldowns for " + ps.size() + " player" + (ps.size() == 1 ? "" : "s") + ".");
				})))
				.then(Commands.literal("trial")
						.then(Commands.literal("start").then(Commands.argument("player", EntityArgument.player()).then(heartArg("heart").executes(c -> {
							ServerPlayer p = EntityArgument.getPlayer(c, "player");
							String err = TrialManager.start(p, heart(c, "heart"), true);
							return err == null ? ok(c.getSource(), "Started the trial for " + p.getName().getString() + ".") : fail(c.getSource(), err);
						}))))
						.then(Commands.literal("stop").then(Commands.argument("player", EntityArgument.player()).executes(c -> {
							ServerPlayer p = EntityArgument.getPlayer(c, "player");
							if (!TrialManager.inTrial(p)) return fail(c.getSource(), p.getName().getString() + " is not in a trial.");
							TrialManager.fail(p.getUUID(), "An admin ended the trial.");
							return ok(c.getSource(), "Stopped " + p.getName().getString() + "'s trial.");
						})))
						.then(Commands.literal("win").then(Commands.argument("player", EntityArgument.player()).executes(c -> {
							ServerPlayer p = EntityArgument.getPlayer(c, "player");
							if (!TrialManager.inTrial(p)) return fail(c.getSource(), p.getName().getString() + " is not in a trial.");
							TrialManager.win(p.getUUID());
							return ok(c.getSource(), "Completed " + p.getName().getString() + "'s trial.");
						})))
						.then(Commands.literal("list").executes(c -> {
							c.getSource().sendSuccess(TrialManager::describeSessions, false);
							return 1;
						})))
				.then(Commands.literal("reload").executes(c -> {
					ChaosConfig.load();
					return ok(c.getSource(), "Reloaded config/chaoshearts.json.");
				}))
				.then(Commands.literal("inspect").then(Commands.argument("player", EntityArgument.player()).executes(c -> inspect(c.getSource(), EntityArgument.getPlayer(c, "player")))))
				.then(Commands.literal("reset").then(Commands.argument("player", EntityArgument.player()).then(Commands.literal("confirm").executes(c -> {
					ServerPlayer p = EntityArgument.getPlayer(c, "player");
					if (TrialManager.inTrial(p)) TrialManager.fail(p.getUUID(), "Your progress was reset by an admin.");
					PlayerData pd = DataStore.get(p);
					pd.progress.clear();
					pd.xpToday = 0;
					pd.pvpKillTimes.clear();
					pd.trialRetryAtMillis = 0;
					SkillManager.invalidate(p.getUUID());
					AbilityManager.resetCooldowns(p);
					DataStore.save();
					AbilityManager.refreshFocus(p);
					return ok(c.getSource(), "Reset all mastery, awakenings and skills for " + p.getName().getString() + ". Their hearts were kept.");
				}))))
				.then(Commands.literal("save").executes(c -> {
					DataStore.save();
					return ok(c.getSource(), "Saved Chaos Hearts data.");
				})));
	}

	private static int give(CommandContext<CommandSourceStack> c, boolean force) throws CommandSyntaxException {
		ServerPlayer p = EntityArgument.getPlayer(c, "player");
		HeartType t = heart(c, "heart");
		if (TrialManager.inTrial(p)) return fail(c.getSource(), "Wait until their trial is over.");
		int max = ChaosConfig.get().maxHeartsPerPlayer;
		if (!force && max > 0 && DataStore.get(p).hearts.size() >= max) return fail(c.getSource(), p.getName().getString() + " already holds the maximum of " + max + " hearts. Add true to force it.");
		HeartRecord rec = HeartManager.create(p, t, force);
		if (rec == null) return fail(c.getSource(), "A " + t.displayName + " Heart already exists and unique hearts is on. Add true to force it.");
		return ok(c.getSource(), "Gave a " + t.displayName + " Heart to " + p.getName().getString() + ".");
	}

	/** The newest heart of that type the player holds. */
	public static HeartRecord heldRecord(ServerPlayer p, HeartType t) {
		PlayerData pd = DataStore.get(p);
		for (int i = pd.hearts.size() - 1; i >= 0; i--) {
			PlayerData.OwnedHeart h = pd.hearts.get(i);
			if (h.type == t) {
				HeartRecord rec = HeartManager.record(h.heartId);
				if (rec != null) return rec;
			}
		}
		return null;
	}

	private static HeartRecord findRecord(String prefix) {
		for (HeartRecord r : HeartManager.records()) if (r.id.toString().startsWith(prefix.toLowerCase())) return r;
		return null;
	}

	private static String nameOf(UUID id) {
		if (id == null) return "nobody";
		ServerPlayer p = HeartManager.online(id);
		if (p != null) return p.getName().getString();
		PlayerData pd = DataStore.find(id);
		return pd != null && !pd.lastName.isEmpty() ? pd.lastName : id.toString().substring(0, 8);
	}

	private static int registry(CommandSourceStack s) {
		var recs = HeartManager.records();
		recs.sort((a, b) -> a.type.compareTo(b.type));
		MutableComponent out = Component.literal("— Heart registry (" + recs.size() + ") —").withStyle(ChatFormatting.DARK_PURPLE, ChatFormatting.BOLD);
		long now = System.currentTimeMillis();
		for (HeartRecord r : recs) {
			String where = r.state == HeartRecord.State.HELD
					? "held by " + nameOf(r.holder)
					: String.format("dropped in %s at %d %d %d for %s, %ds left", r.dimension, (int) r.x, (int) r.y, (int) r.z, nameOf(r.collector), Math.max(0, (r.expiresAt - now) / 1000));
			out.append(Component.literal("\n" + r.id.toString().substring(0, 8) + " ").withStyle(ChatFormatting.DARK_GRAY)).append(r.type.title()).append(Component.literal(" " + where).withStyle(ChatFormatting.GRAY));
		}
		s.sendSuccess(() -> out, false);
		return recs.size();
	}

	private static int inspect(CommandSourceStack s, ServerPlayer p) {
		PlayerData pd = DataStore.get(p);
		MutableComponent out = Component.literal("— " + p.getName().getString() + " —").withStyle(ChatFormatting.DARK_PURPLE, ChatFormatting.BOLD);
		out.append(Component.literal("\nHearts (oldest first): ").withStyle(ChatFormatting.GRAY));
		for (PlayerData.OwnedHeart h : pd.hearts) out.append(h.type.label()).append(Component.literal(" "));
		out.append(Component.literal("\nActive: " + (pd.active == null ? "none" : pd.active.displayName) + ", XP today " + pd.xpToday + ", in trial " + TrialManager.inTrial(p)).withStyle(ChatFormatting.GRAY));
		for (HeartType t : HeartType.values()) {
			PlayerData.HeartProgress prog = pd.progress(t);
			if (prog.xp == 0 && !prog.awakened) continue;
			out.append(Component.literal("\n").append(t.label()).append(Component.literal(" lvl " + Mastery.level(prog.xp) + " (" + prog.xp + " XP)" + (prog.awakened ? " awakened, " + SkillManager.available(t, prog) + "/" + SkillManager.totalPoints(prog) + " pts, nodes " + prog.nodes : "") + ", feats " + prog.feats.size()).withStyle(ChatFormatting.GRAY)));
		}
		s.sendSuccess(() -> out, false);
		return 1;
	}

	/** Shared float argument for the Eye's size. */
	static RequiredArgumentBuilder<CommandSourceStack, Float> scaleArg() {
		return Commands.argument("scale", FloatArgumentType.floatArg(1f, 12f));
	}
}
