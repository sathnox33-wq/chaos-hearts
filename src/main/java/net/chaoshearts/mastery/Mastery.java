package net.chaoshearts.mastery;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import net.chaoshearts.ability.AbilityManager;
import net.chaoshearts.ability.HeartKit;
import net.chaoshearts.ability.HeartKits;
import net.chaoshearts.config.ChaosConfig;
import net.chaoshearts.data.DataStore;
import net.chaoshearts.data.PlayerData;
import net.chaoshearts.fx.Fx;
import net.chaoshearts.heart.HeartType;
import net.chaoshearts.skill.SkillManager;
import net.minecraft.ChatFormatting;
import net.minecraft.core.particles.ParticleTypes;
import net.minecraft.network.chat.Component;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.sounds.SoundSource;

/** Mastery levels, XP sources, anti-grind rules and feats. Mastery is per player and heart type. */
public final class Mastery {
	public static final int MAX = 100;

	public static final int LVL_A2 = 10;
	public static final int LVL_PASSIVE2 = 25;
	public static final int LVL_A3 = 40;
	public static final int LVL_HONED = 60;
	public static final int LVL_ULT = 75;
	public static final int LVL_AURA = 90;

	private static final Map<UUID, Map<UUID, long[]>> RECENT_TARGETS = new HashMap<>();

	private Mastery() {}

	public static long xpToReach(int level) {
		return 40L * level + 2L * level * (level - 1);
	}

	public static int level(long xp) {
		int lo = 0, hi = MAX;
		while (lo < hi) {
			int mid = (lo + hi + 1) / 2;
			if (xpToReach(mid) <= xp) lo = mid;
			else hi = mid - 1;
		}
		return lo;
	}

	public static int level(ServerPlayer p, HeartType t) {
		return level(DataStore.get(p).progress(t).xp);
	}

	public static boolean awakened(ServerPlayer p, HeartType t) {
		return DataStore.get(p).progress(t).awakened;
	}

	/** 0 plain, 1 glint, 2 aura, 3 awakened. Drives Focus visuals. */
	public static int visualTier(int mastery, boolean awakened) {
		if (awakened) return 3;
		if (mastery >= LVL_AURA) return 2;
		if (mastery >= LVL_PASSIVE2) return 1;
		return 0;
	}

	/** Progress inside the current level, 0..1. */
	public static double levelProgress(long xp) {
		int l = level(xp);
		if (l >= MAX) return 1;
		long a = xpToReach(l), b = xpToReach(l + 1);
		return (xp - a) / (double) (b - a);
	}

	/**
	 * Diminishing returns on the same target: full, half, quarter within the window.
	 * Returns the multiplier and records the hit.
	 */
	public static double targetFactor(ServerPlayer p, UUID target) {
		long now = System.currentTimeMillis();
		long window = ChaosConfig.get().sameTargetWindowSeconds * 1000L;
		Map<UUID, long[]> m = RECENT_TARGETS.computeIfAbsent(p.getUUID(), u -> new HashMap<>());
		if (m.size() > 64) m.values().removeIf(v -> now - v[1] > window);
		long[] rec = m.get(target);
		if (rec == null || now - rec[1] > window) {
			m.put(target, new long[] {1, now});
			return 1.0;
		}
		rec[0]++;
		return rec[0] == 2 ? 0.5 : 0.25;
	}

	public static void forget(UUID player) {
		RECENT_TARGETS.remove(player);
	}

	/** Awards mastery XP for the player's active heart (normal sources, with the daily soft cap). */
	public static long award(ServerPlayer p, double base) {
		PlayerData pd = DataStore.get(p);
		if (pd.active == null || base <= 0) return 0;
		var cfg = ChaosConfig.get();
		String today = LocalDate.now().toString();
		if (!today.equals(pd.xpDay)) {
			pd.xpDay = today;
			pd.xpToday = 0;
		}
		double amount = base * cfg.masteryXpMultiplier;
		if (pd.xpToday >= cfg.dailySoftCap) amount *= cfg.softCapMultiplier;
		long gained = Math.max(1, Math.round(amount));
		pd.xpToday += gained;
		addRaw(p, pd.active, gained);
		return gained;
	}

	/** Adds XP without caps (feats, admin). Handles level-up feedback. */
	public static void addRaw(ServerPlayer p, HeartType type, long amount) {
		PlayerData pd = DataStore.get(p);
		PlayerData.HeartProgress prog = pd.progress(type);
		int before = level(prog.xp);
		int pointsBefore = SkillManager.totalPoints(prog);
		prog.xp = Math.max(0, prog.xp + amount);
		int after = level(prog.xp);
		DataStore.markDirty();
		if (after > before) onLevelUp(p, type, before, after);
		if (prog.awakened && SkillManager.totalPoints(prog) > pointsBefore) {
			p.sendSystemMessage(Component.literal("✦ ").withStyle(type.style())
					.append(Component.literal("You earned a skill point for the " + type.displayName + " Heart. ").withStyle(ChatFormatting.GOLD))
					.append(Component.literal("/hearts tree").withStyle(ChatFormatting.YELLOW)));
			Fx.soundTo(p, SoundEvents.PLAYER_LEVELUP, 0.8f, 1.4f);
		}
	}

	public static void setLevel(ServerPlayer p, HeartType type, int level) {
		PlayerData.HeartProgress prog = DataStore.get(p).progress(type);
		int before = level(prog.xp);
		prog.xp = xpToReach(Math.max(0, Math.min(MAX, level)));
		DataStore.markDirty();
		if (level > before) onLevelUp(p, type, before, level(prog.xp));
		AbilityManager.refreshFocus(p);
	}

	private static void onLevelUp(ServerPlayer p, HeartType type, int before, int after) {
		Fx.soundTo(p, SoundEvents.PLAYER_LEVELUP, 0.6f, 0.8f + after / 200f);
		Fx.actionBar(p, Component.literal(type.displayName + " Mastery " + after + "/100").withStyle(type.style().withBold(true)));
		for (int lvl = before + 1; lvl <= after; lvl++) {
			String unlock = milestone(type, lvl);
			if (unlock == null) continue;
			Fx.title(p, Component.literal(type.displayName + " Mastery " + lvl).withStyle(type.style().withBold(true)),
					Component.literal(unlock).withStyle(ChatFormatting.GRAY), 10, 60, 20);
			p.sendSystemMessage(Component.literal("✦ " + type.displayName + " Mastery " + lvl + ": ").withStyle(type.style().withBold(true))
					.append(Component.literal(unlock).withStyle(ChatFormatting.GRAY)));
			Fx.soundTo(p, net.minecraft.core.Holder.direct(SoundEvents.UI_TOAST_CHALLENGE_COMPLETE), SoundSource.MASTER, 0.7f, 1.0f);
			Fx.customTo(p, "mastery_milestone", SoundSource.MASTER, 1.0f, 1.0f);
			Fx.at(p.level(), ParticleTypes.TOTEM_OF_UNDYING, p.position().add(0, 1, 0), 40, 0.6, 0.4);
		}
		AbilityManager.refreshFocus(p);
	}

	public static String milestone(HeartType type, int lvl) {
		HeartKit kit = HeartKits.get(type);
		return switch (lvl) {
			case LVL_A2 -> "Unlocked " + kit.ability(1).name() + " (Sneak + Right-click)";
			case LVL_PASSIVE2 -> "Unlocked passive: " + kit.passive2Name();
			case LVL_A3 -> "Unlocked " + kit.ability(2).name() + " (Swap Hands)";
			case LVL_HONED -> "Honed: abilities recharge 15% faster and hit 10% harder";
			case LVL_ULT -> "Unlocked ultimate: " + kit.ability(3).name() + " (Sneak + Swap Hands)";
			case LVL_AURA -> "Your heart's aura now shows itself";
			case MAX -> "The Awakening Trial calls. Use /hearts trial";
			default -> null;
		};
	}

	// ---------------------------------------------------------------- feats and counters

	public static long counter(ServerPlayer p, HeartType type, String key, long add) {
		PlayerData.HeartProgress prog = DataStore.get(p).progress(type);
		long v = prog.counters.getOrDefault(key, 0L) + add;
		prog.counters.put(key, v);
		DataStore.markDirty();
		return v;
	}

	/** Completes a feat once. Feat XP ignores the daily cap. */
	public static void feat(ServerPlayer p, HeartType type, String featId) {
		HeartKit kit = HeartKits.get(type);
		HeartKit.Feat feat = kit.feat(featId);
		if (feat == null) return;
		PlayerData.HeartProgress prog = DataStore.get(p).progress(type);
		if (!prog.feats.add(featId)) return;
		DataStore.markDirty();
		p.sendSystemMessage(Component.literal("★ Feat complete: ").withStyle(ChatFormatting.GOLD, ChatFormatting.BOLD)
				.append(Component.literal(feat.name()).withStyle(type.style().withBold(true)))
				.append(Component.literal(" — " + feat.description() + " (+" + feat.xp() + " mastery)").withStyle(ChatFormatting.GRAY)));
		Fx.title(p, Component.literal("★ " + feat.name()).withStyle(type.style().withBold(true)), Component.literal("Feat complete").withStyle(ChatFormatting.GOLD), 5, 40, 15);
		Fx.soundTo(p, net.minecraft.core.Holder.direct(SoundEvents.UI_TOAST_CHALLENGE_COMPLETE), SoundSource.MASTER, 1f, 1.2f);
		addRaw(p, type, Math.round(feat.xp() * ChaosConfig.get().masteryXpMultiplier));
	}
}
