package net.chaoshearts.ability;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import net.chaoshearts.ChaosHearts;
import net.chaoshearts.combat.Combat;
import net.chaoshearts.config.ChaosConfig;
import net.chaoshearts.data.DataStore;
import net.chaoshearts.data.PlayerData;
import net.chaoshearts.eye.EyeManager;
import net.chaoshearts.fx.Fx;
import net.chaoshearts.heart.HeartItems;
import net.chaoshearts.heart.HeartType;
import net.chaoshearts.mastery.Mastery;
import net.chaoshearts.skill.SkillManager;
import net.chaoshearts.trial.TrialManager;
import net.fabricmc.fabric.api.entity.event.v1.ServerLivingEntityEvents;
import net.fabricmc.fabric.api.event.player.UseItemCallback;
import net.minecraft.ChatFormatting;
import net.minecraft.core.Holder;
import net.minecraft.network.chat.Component;
import net.minecraft.network.chat.MutableComponent;
import net.minecraft.server.MinecraftServer;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.sounds.SoundSource;
import net.minecraft.world.InteractionHand;
import net.minecraft.world.InteractionResult;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.entity.LivingEntity;
import net.minecraft.world.entity.boss.enderdragon.EnderDragon;
import net.minecraft.world.entity.boss.wither.WitherBoss;
import net.minecraft.world.entity.monster.ElderGuardian;
import net.minecraft.world.entity.monster.warden.Warden;
import net.minecraft.world.item.ItemStack;

/** Input, cooldowns, the HUD, passives and the Focus item. */
public final class AbilityManager {
	private static final Map<UUID, PlayerState> STATES = new HashMap<>();
	public static final String[] SLOT_KEYS = {"Right-click", "Sneak + Right-click", "Swap Hands", "Sneak + Swap Hands"};

	private AbilityManager() {}

	public static PlayerState state(ServerPlayer p) {
		return STATES.computeIfAbsent(p.getUUID(), u -> new PlayerState());
	}

	public static PlayerState state(UUID id) {
		return STATES.computeIfAbsent(id, u -> new PlayerState());
	}

	/** Context for the player's active heart, or null if they have none. */
	public static Ctx ctx(ServerPlayer p) {
		PlayerData pd = DataStore.get(p);
		HeartType t = pd.active;
		if (t == null) return null;
		HeartKit kit = HeartKits.get(t);
		PlayerData.HeartProgress prog = pd.progress(t);
		return new Ctx(p, t, kit, Mastery.level(prog.xp), prog.awakened, SkillManager.set(p.getUUID(), t), state(p));
	}

	public static void registerEvents() {
		UseItemCallback.EVENT.register((player, world, hand) -> {
			if (!(player instanceof ServerPlayer p) || hand != InteractionHand.MAIN_HAND) return InteractionResult.PASS;
			ItemStack stack = p.getItemInHand(hand);
			if (!HeartItems.isFocus(stack)) return InteractionResult.PASS;
			tryCast(p, p.isShiftKeyDown() ? 1 : 0, stack);
			return InteractionResult.SUCCESS_SERVER;
		});

		ServerLivingEntityEvents.AFTER_DAMAGE.register((entity, source, base, taken, blocked) -> {
			if (taken <= 0) return;
			ServerPlayer attacker = source.getEntity() instanceof ServerPlayer sp && sp != entity ? sp : null;
			if (attacker != null && entity instanceof ServerPlayer victim) Combat.tag(victim, attacker);
			if (attacker != null && !Combat.inAbilityDamage()) {
				Ctx c = ctx(attacker);
				if (c != null) c.kit.afterHit(c, entity, taken, false);
			}
			if (entity instanceof ServerPlayer victim) {
				Ctx c = ctx(victim);
				if (c != null) c.kit.afterHurt(c, source, taken);
			}
		});

		ServerLivingEntityEvents.ALLOW_DEATH.register((entity, source, amount) -> {
			if (!(entity instanceof ServerPlayer p)) return true;
			if (TrialManager.inTrial(p)) return true; // the trial decides
			Ctx c = ctx(p);
			return c == null || !c.kit.preventDeath(c, source);
		});

		ServerLivingEntityEvents.AFTER_DEATH.register((entity, source) -> {
			if (!(source.getEntity() instanceof ServerPlayer killer) || killer == entity) return;
			if (isBoss(entity)) {
				Ctx c = ctx(killer);
				if (c != null) Mastery.award(killer, ChaosConfig.get().xpBossKill);
			}
			if (!Combat.inAbilityDamage() && !(entity instanceof ServerPlayer)) {
				Ctx c = ctx(killer);
				if (c != null) c.kit.onKill(c, entity);
			}
		});
	}

	private static boolean isBoss(LivingEntity e) {
		return e instanceof WitherBoss || e instanceof Warden || e instanceof ElderGuardian || e instanceof EnderDragon;
	}

	/** A PvP kill credited to killer (from the death handler). */
	public static void onPvpKill(ServerPlayer killer, ServerPlayer victim) {
		Ctx c = ctx(killer);
		if (c == null) return;
		c.kit.onKill(c, victim);
		PlayerData pd = DataStore.get(killer);
		long now = System.currentTimeMillis();
		Long last = pd.pvpKillTimes.get(victim.getUUID());
		if (last == null || now - last > ChaosConfig.get().pvpKillRepeatMinutes * 60_000L) {
			pd.pvpKillTimes.put(victim.getUUID(), now);
			pd.pvpKillTimes.values().removeIf(t -> now - t > 24 * 3600_000L);
			Mastery.award(killer, ChaosConfig.get().xpPvpKill);
		}
	}

	/** Hooked into LivingEntity.hurtServer. Lets the attacker's and the victim's heart change the damage. */
	public static float modifyDamage(LivingEntity target, DamageSource source, float amount) {
		if (amount <= 0 || target.level().isClientSide()) return amount;
		if (target instanceof ServerPlayer tp && EyeManager.isEye(tp)) return 0;
		// Summoned allies never hurt their summoner.
		if (source.getEntity() != null && source.getEntity().getTags().contains("chaoshearts.ally." + target.getUUID())) return 0;
		amount = TrialManager.modifyDamage(target, source, amount);
		if (source.getEntity() instanceof ServerPlayer attacker && attacker != target) {
			Ctx c = ctx(attacker);
			if (c != null) amount = c.kit.outgoing(c, target, source, amount);
		}
		if (target instanceof ServerPlayer victim) {
			Ctx c = ctx(victim);
			if (c != null) amount = c.kit.incoming(c, source, amount);
		}
		return Math.max(0, amount);
	}

	/** The swap-hands key. Returns true if it was used to cast (the swap is then cancelled). */
	public static boolean onSwapHands(ServerPlayer p) {
		ItemStack main = p.getMainHandItem();
		if (!HeartItems.isFocus(main)) return false;
		tryCast(p, p.isShiftKeyDown() ? 3 : 2, main);
		return true;
	}

	public static void tryCast(ServerPlayer p, int slot, ItemStack focus) {
		if (focus != null) {
			UUID owner = HeartItems.focusOwner(focus);
			if (owner == null || !owner.equals(p.getUUID())) {
				Fx.actionBar(p, Component.literal("This Focus is bound to someone else.").withStyle(ChatFormatting.RED));
				return;
			}
		}
		if (EyeManager.isEye(p) || p.isSpectator() || !p.isAlive()) return;
		if (TrialManager.inCinematic(p)) return;
		PlayerState st = state(p);
		long tick = ChaosHearts.tick();
		if (tick - st.lastCastTick < 3) return;
		Ctx c = ctx(p);
		if (c == null) {
			Fx.actionBar(p, Component.literal("You hold no Chaos Heart.").withStyle(ChatFormatting.GRAY));
			return;
		}
		Ability ab = c.kit.ability(slot);
		if (!c.unlocked(ab.unlockLevel())) {
			Fx.actionBar(p, Component.literal(ab.name() + " unlocks at " + c.type.displayName + " mastery " + ab.unlockLevel()).withStyle(ChatFormatting.GRAY));
			Fx.soundTo(p, SoundEvents.DISPENSER_FAIL, 0.4f, 1.6f);
			return;
		}
		String key = c.type.id() + "." + ab.key();
		long now = System.currentTimeMillis();
		Long ready = st.readyAt.get(key);
		if (ready != null && ready > now) {
			Fx.actionBar(p, Component.literal(ab.name() + " recharging: " + formatSecs((ready - now) / 1000.0)).withStyle(ChatFormatting.GRAY));
			Fx.soundTo(p, SoundEvents.UI_BUTTON_CLICK.value(), 0.25f, 0.6f);
			return;
		}
		st.lastCastTick = tick;
		c.ability = ab;
		boolean ok;
		try {
			ok = ab.cast(c);
		} catch (Throwable e) {
			ChaosHearts.LOGGER.error("Ability {} failed", key, e);
			ok = false;
		}
		if (!ok) return;
		double cd = c.num(ab.key() + ".cooldown", ab.baseCooldown()) * ChaosConfig.get().cooldownMultiplier;
		if (c.mastery >= Mastery.LVL_HONED) cd *= 0.85;
		cd = Math.max(0.5, cd);
		st.readyAt.put(key, now + (long) (cd * 1000));
		st.chimePending.put(key, true);
		ItemStack hand = p.getMainHandItem();
		if (HeartItems.isFocus(hand)) p.getCooldowns().addCooldown(hand, (int) (cd * 20));
	}

	/** Reduces the remaining cooldown of one ability (used by some passives and skill nodes). */
	public static void reduceCooldown(ServerPlayer p, HeartType t, int slot, double seconds) {
		PlayerState st = state(p);
		String key = t.id() + ".a" + (slot + 1);
		Long r = st.readyAt.get(key);
		if (r != null) st.readyAt.put(key, r - (long) (seconds * 1000));
	}

	public static long readyAt(ServerPlayer p, HeartType t, int slot) {
		return state(p).readyAt.getOrDefault(t.id() + ".a" + (slot + 1), 0L);
	}

	public static void setReadyAt(ServerPlayer p, HeartType t, int slot, long epochMillis) {
		state(p).readyAt.put(t.id() + ".a" + (slot + 1), epochMillis);
		state(p).chimePending.put(t.id() + ".a" + (slot + 1), true);
	}

	public static void resetCooldowns(ServerPlayer p) {
		state(p).resetCooldowns();
	}

	private static String formatSecs(double s) {
		if (s >= 60) return (int) (s / 60) + ":" + String.format("%02d", (int) s % 60);
		if (s >= 10) return (int) Math.ceil(s) + "s";
		return String.format("%.1fs", s);
	}

	// ---------------------------------------------------------------- tick

	public static void tick(MinecraftServer server) {
		long t = ChaosHearts.tick();
		for (ServerPlayer p : server.getPlayerList().getPlayers()) {
			if (!p.isAlive() || p.isSpectator()) continue;
			Ctx c = ctx(p);
			if (c == null) continue;
			try {
				c.kit.tick(c, t);
				if (t % 4 == 0 && (c.mastery >= Mastery.LVL_AURA || c.awakened) && !p.isInvisible() && !EyeManager.isEye(p)) c.kit.aura(c, t);
				if (t % 5 == 0) hud(c, t);
			} catch (Throwable e) {
				ChaosHearts.LOGGER.error("Heart tick failed for {}", p.getName().getString(), e);
			}
			if (t % 20 == 3) refreshFocus(p);
		}
	}

	private static void hud(Ctx c, long t) {
		ServerPlayer p = c.player;
		PlayerState st = c.state;
		boolean holding = HeartItems.isFocus(p.getMainHandItem()) || HeartItems.isFocus(p.getOffhandItem());
		long now = System.currentTimeMillis();
		// Ready chimes
		for (int slot = 0; slot < 4; slot++) {
			String key = c.type.id() + ".a" + (slot + 1);
			Long r = st.readyAt.get(key);
			if (r != null && r <= now && Boolean.TRUE.equals(st.chimePending.get(key))) {
				st.chimePending.put(key, false);
				if (holding) Fx.soundTo(p, Holder.direct(SoundEvents.AMETHYST_BLOCK_CHIME), SoundSource.PLAYERS, 0.5f, 1.2f + slot * 0.2f);
			}
		}
		String extra = c.kit.hud(c, t);
		if (!holding && extra == null) return;
		if (st.hudFlash != null && st.hudFlashUntil > now) {
			Fx.actionBar(p, st.hudFlash);
			return;
		}
		MutableComponent bar = Component.empty();
		if (holding) {
			for (int slot = 0; slot < 4; slot++) {
				Ability ab = c.kit.ability(slot);
				if (slot > 0) bar.append(Component.literal(" │ ").withStyle(ChatFormatting.DARK_GRAY));
				if (!c.unlocked(ab.unlockLevel())) {
					bar.append(Component.literal("🔒" + ab.unlockLevel()).withStyle(ChatFormatting.DARK_GRAY));
					continue;
				}
				Long r = st.readyAt.get(c.type.id() + ".a" + (slot + 1));
				if (r == null || r <= now) {
					bar.append(Component.literal(ab.name() + " ✔").withStyle(c.type.style()));
				} else {
					bar.append(Component.literal(ab.name() + " " + formatSecs((r - now) / 1000.0)).withStyle(ChatFormatting.GRAY));
				}
			}
		}
		if (extra != null) {
			if (holding) bar.append(Component.literal(" │ ").withStyle(ChatFormatting.DARK_GRAY));
			bar.append(Component.literal(extra).withStyle(c.type.style().withBold(true)));
		}
		Fx.actionBar(p, bar);
	}

	// ---------------------------------------------------------------- focus item

	/** Gives the player a Focus if they own hearts and have none in their inventory. */
	public static void ensureFocus(ServerPlayer p) {
		PlayerData pd = DataStore.get(p);
		if (pd.active == null) return;
		var inv = p.getInventory();
		for (int i = 0; i < inv.getContainerSize(); i++) {
			ItemStack s = inv.getItem(i);
			if (HeartItems.isFocus(s) && p.getUUID().equals(HeartItems.focusOwner(s))) return;
		}
		ItemStack f = makeFocus(p, pd);
		if (!inv.add(f)) p.drop(f, false);
	}

	public static ItemStack makeFocus(ServerPlayer p, PlayerData pd) {
		PlayerData.HeartProgress prog = pd.progress(pd.active);
		return HeartItems.focus(p.getUUID(), pd.active, Mastery.level(prog.xp), prog.awakened);
	}

	/** Updates the player's Focus items to match their active heart, or removes them if they have none. */
	public static void refreshFocus(ServerPlayer p) {
		PlayerData pd = DataStore.get(p);
		var inv = p.getInventory();
		String wanted = null;
		ItemStack fresh = null;
		if (pd.active != null) {
			fresh = makeFocus(p, pd);
			wanted = HeartItems.focusSignature(fresh);
		}
		for (int i = 0; i < inv.getContainerSize(); i++) {
			ItemStack s = inv.getItem(i);
			if (!HeartItems.isFocus(s) || !p.getUUID().equals(HeartItems.focusOwner(s))) continue;
			if (fresh == null) {
				inv.setItem(i, ItemStack.EMPTY);
			} else if (!wanted.equals(HeartItems.focusSignature(s))) {
				inv.setItem(i, fresh.copy());
			}
		}
	}

	// ---------------------------------------------------------------- lifecycle

	public static void onJoin(ServerPlayer p) {
		ensureFocus(p);
		refreshFocus(p);
	}

	public static void onLeave(ServerPlayer p) {
		PlayerData pd = DataStore.get(p);
		if (pd.active != null) HeartKits.get(pd.active).deactivate(p);
		Mastery.forget(p.getUUID());
		Combat.forget(p.getUUID());
		SkillManager.invalidate(p.getUUID());
	}

	public static void onServerStopping(MinecraftServer server) {
		for (ServerPlayer p : server.getPlayerList().getPlayers()) onLeave(p);
		STATES.clear();
	}
}
