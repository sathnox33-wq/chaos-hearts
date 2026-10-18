package net.chaoshearts.heart;

import java.util.ArrayList;
import java.util.EnumSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import net.chaoshearts.ChaosHearts;
import net.chaoshearts.ability.AbilityManager;
import net.chaoshearts.ability.HeartKits;
import net.chaoshearts.combat.Combat;
import net.chaoshearts.config.ChaosConfig;
import net.chaoshearts.data.DataStore;
import net.chaoshearts.data.HeartRecord;
import net.chaoshearts.data.PlayerData;
import net.chaoshearts.fx.Fx;
import net.chaoshearts.mastery.Mastery;
import net.chaoshearts.trial.TrialManager;
import net.chaoshearts.util.Dims;
import net.fabricmc.fabric.api.entity.event.v1.ServerLivingEntityEvents;
import net.fabricmc.fabric.api.event.lifecycle.v1.ServerEntityEvents;
import net.fabricmc.fabric.api.networking.v1.ServerPlayConnectionEvents;
import net.minecraft.ChatFormatting;
import net.minecraft.core.Holder;
import net.minecraft.core.particles.ParticleTypes;
import net.minecraft.network.chat.Component;
import net.minecraft.server.MinecraftServer;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.sounds.SoundSource;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.entity.Entity;
import net.minecraft.world.entity.item.ItemEntity;
import net.minecraft.world.entity.player.Player;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.phys.Vec3;

/**
 * Heart ownership. Every change goes through here: the registry record and the player's list
 * are updated together and saved immediately.
 */
public final class HeartManager {
	private static final Map<UUID, Long> PICKUP_MSG = new HashMap<>();

	private HeartManager() {}

	public static void registerEvents() {
		ServerPlayConnectionEvents.JOIN.register((handler, sender, server) -> onJoin(handler.player));
		ServerPlayConnectionEvents.DISCONNECT.register((handler, server) -> onDisconnect(handler.player));
		ServerLivingEntityEvents.AFTER_DEATH.register((entity, source) -> {
			if (entity instanceof ServerPlayer victim) onPlayerDeath(victim, source);
		});
		ServerEntityEvents.ENTITY_LOAD.register(HeartManager::onEntityLoad);
		ServerEntityEvents.ENTITY_UNLOAD.register(HeartManager::onEntityUnload);
	}

	// ---------------------------------------------------------------- queries

	public static List<HeartRecord> records() {
		return new ArrayList<>(DataStore.root().hearts.values());
	}

	public static HeartRecord record(UUID id) {
		return DataStore.root().hearts.get(id);
	}

	public static Set<HeartType> typesInPlay() {
		Set<HeartType> s = EnumSet.noneOf(HeartType.class);
		for (HeartRecord r : DataStore.root().hearts.values()) s.add(r.type);
		return s;
	}

	public static HeartType active(ServerPlayer p) {
		return DataStore.get(p).active;
	}

	// ---------------------------------------------------------------- creation and removal

	/** Creates a brand-new heart for the player. Returns null if unique mode forbids it and force is false. */
	public static HeartRecord create(ServerPlayer p, HeartType type, boolean force) {
		if (!force && ChaosConfig.get().uniqueHearts && typesInPlay().contains(type)) return null;
		HeartRecord rec = new HeartRecord();
		rec.id = UUID.randomUUID();
		rec.type = type;
		rec.createdAt = System.currentTimeMillis();
		DataStore.root().hearts.put(rec.id, rec);
		giveTo(p.getUUID(), rec);
		DataStore.save();
		onGained(p, rec, "awakens within you");
		return rec;
	}

	/** Moves an existing record into a player's possession (HELD). Does not save. */
	private static void giveTo(UUID player, HeartRecord rec) {
		PlayerData pd = DataStore.get(player);
		rec.state = HeartRecord.State.HELD;
		rec.holder = player;
		rec.entity = null;
		rec.collector = null;
		rec.previousOwner = null;
		rec.dimension = null;
		pd.hearts.removeIf(h -> h.heartId.equals(rec.id));
		pd.hearts.add(new PlayerData.OwnedHeart(rec.id, rec.type, System.currentTimeMillis()));
		if (pd.active == null) pd.active = rec.type;
		DataStore.markDirty();
	}

	/** Removes the heart from its holder's list. Does not save. */
	private static void takeFrom(UUID player, HeartRecord rec) {
		PlayerData pd = DataStore.get(player);
		pd.hearts.removeIf(h -> h.heartId.equals(rec.id));
		if (pd.active == rec.type && !pd.owns(rec.type)) {
			ServerPlayer online = online(player);
			if (online != null) {
				var kit = HeartKits.get(rec.type);
				if (kit != null) kit.deactivate(online);
				AbilityManager.state(online).resetCombatState();
			}
			pd.active = pd.hearts.isEmpty() ? null : pd.latest().type;
		}
		DataStore.markDirty();
	}

	/** Destroys a heart entirely (admin). */
	public static void destroy(HeartRecord rec) {
		if (rec.state == HeartRecord.State.HELD && rec.holder != null) {
			takeFrom(rec.holder, rec);
			ServerPlayer p = online(rec.holder);
			if (p != null) AbilityManager.refreshFocus(p);
		} else if (rec.state == HeartRecord.State.DROPPED) {
			discardEntity(rec);
		}
		DataStore.root().hearts.remove(rec.id);
		DataStore.save();
	}

	/** Gives a held or dropped heart to another player directly (admin / Eye). */
	public static void transfer(HeartRecord rec, ServerPlayer to, String verb) {
		if (rec.state == HeartRecord.State.HELD && rec.holder != null) {
			if (rec.holder.equals(to.getUUID())) return;
			UUID from = rec.holder;
			takeFrom(from, rec);
			ServerPlayer fp = online(from);
			if (fp != null) {
				AbilityManager.refreshFocus(fp);
				fp.sendSystemMessage(Component.literal("Your ").withStyle(ChatFormatting.GRAY).append(rec.type.title()).append(Component.literal(" was taken from you.").withStyle(ChatFormatting.GRAY)));
			} else {
				DataStore.get(from).pendingMessages.add("Your " + rec.type.displayName + " Heart was taken from you while you were away.");
			}
		} else if (rec.state == HeartRecord.State.DROPPED) {
			discardEntity(rec);
		}
		giveTo(to.getUUID(), rec);
		DataStore.save();
		onGained(to, rec, verb);
	}

	private static void onGained(ServerPlayer p, HeartRecord rec, String verb) {
		HeartType t = rec.type;
		int m = Mastery.level(p, t);
		Fx.title(p, t.title().withStyle(s -> s.withBold(true)), Component.literal("The heart " + verb + ". Your mastery: " + m + "/100").withStyle(ChatFormatting.GRAY), 10, 60, 20);
		p.sendSystemMessage(Component.literal("❤ ").withStyle(t.style()).append(t.title()).append(Component.literal(" " + verb + ". Mastery " + m + "/100.").withStyle(ChatFormatting.GRAY)));
		Fx.soundTo(p, Holder.direct(SoundEvents.BEACON_POWER_SELECT), SoundSource.MASTER, 1f, 0.8f);
		Fx.customTo(p, "heart_acquire", SoundSource.MASTER, 1f, 1f);
		ServerLevel l = (ServerLevel) p.level();
		Fx.helix(l, Fx.dust(t.color, 1.4f), p.position(), 0.8, 2.2, 3, 50, 0);
		Fx.helix(l, Fx.dust(t.secondaryColor, 1.2f), p.position(), 0.8, 2.2, 3, 50, Math.PI);
		AbilityManager.ensureFocus(p);
		AbilityManager.refreshFocus(p);
	}

	// ---------------------------------------------------------------- join / leave

	private static void onJoin(ServerPlayer p) {
		PlayerData pd = DataStore.get(p);
		pd.sanitize();
		if (!pd.starterGiven) {
			pd.starterGiven = true;
			DataStore.markDirty();
			if ("random".equalsIgnoreCase(ChaosConfig.get().starterMode)) {
				List<HeartType> pool = new ArrayList<>(List.of(HeartType.values()));
				if (ChaosConfig.get().uniqueHearts) pool.removeAll(typesInPlay());
				if (!pool.isEmpty()) {
					HeartType t = pool.get(p.getRandom().nextInt(pool.size()));
					ChaosHearts.server().execute(() -> create(p, t, false));
				}
			}
		}
		for (String m : pd.pendingMessages) p.sendSystemMessage(Component.literal(m).withStyle(ChatFormatting.LIGHT_PURPLE));
		if (!pd.pendingMessages.isEmpty()) {
			pd.pendingMessages.clear();
			DataStore.markDirty();
		}
		AbilityManager.onJoin(p);
		TrialManager.onJoin(p);
	}

	private static void onDisconnect(ServerPlayer p) {
		String action = ChaosConfig.get().combatLogAction;
		UUID attacker = Combat.lastAttacker(p.getUUID());
		ServerPlayer killer = attacker == null ? null : online(attacker);
		// If the opponent already left, they fled first and the fight is over: the one who stayed loses nothing.
		if (killer != null && !"off".equalsIgnoreCase(action) && !TrialManager.inTrial(p)) {
			if ("kill".equalsIgnoreCase(action)) {
				// Dying fires the normal death handler, which drops the heart for the attacker.
				p.kill((ServerLevel) p.level());
			} else {
				dropLatest(p, attacker, null);
				killer.sendSystemMessage(Component.literal(p.getName().getString() + " fled the fight and dropped their heart.").withStyle(ChatFormatting.GOLD));
			}
			ChaosHearts.LOGGER.info("{} disconnected in combat with {}", p.getName().getString(), attacker);
		}
		Combat.clearTag(p.getUUID());
		AbilityManager.onLeave(p);
		DataStore.save();
	}

	// ---------------------------------------------------------------- PvP death

	private static void onPlayerDeath(ServerPlayer victim, DamageSource source) {
		if (TrialManager.inTrial(victim)) return;
		ServerPlayer killer = null;
		Entity e = source.getEntity();
		if (e instanceof ServerPlayer sp && sp != victim) killer = sp;
		if (killer == null) {
			UUID last = Combat.lastAttacker(victim.getUUID());
			if (last != null) killer = online(last);
		}
		Combat.clearTag(victim.getUUID());
		AbilityManager.state(victim).resetCombatState();
		if (killer == null) return;
		AbilityManager.onPvpKill(killer, victim);
		dropLatest(victim, killer.getUUID(), null);
	}

	/**
	 * Drops the victim's most recently acquired heart for the collector. at == null means at the
	 * victim, moved to the collector if the spot is unsafe (void, lava).
	 */
	public static boolean dropLatest(ServerPlayer victim, UUID collector, Vec3 at) {
		PlayerData pd = DataStore.get(victim);
		PlayerData.OwnedHeart latest = pd.latest();
		if (latest == null) return false;
		HeartRecord rec = record(latest.heartId);
		if (rec == null) return false;
		ServerLevel level = (ServerLevel) victim.level();
		Vec3 pos = at != null ? at : victim.position();
		ServerPlayer col = online(collector);
		boolean unsafe = pos.y < level.getMinY() + 1 || level.getFluidState(victim.blockPosition()).is(net.minecraft.tags.FluidTags.LAVA);
		if (unsafe && col != null) {
			level = (ServerLevel) col.level();
			pos = col.position();
		} else if (unsafe) {
			pos = new Vec3(pos.x, Math.max(pos.y, level.getMinY() + 2), pos.z);
		}

		takeFrom(victim.getUUID(), rec);
		String collectorName = col != null ? col.getName().getString() : "the victor";
		ItemEntity item = new ItemEntity(level, pos.x, pos.y + 0.5, pos.z, HeartItems.token(rec.id, rec.type, collectorName));
		item.setUnlimitedLifetime();
		item.setNeverPickUp();
		item.setInvulnerable(true);
		item.setGlowingTag(true);
		item.setDeltaMovement(0, 0.25, 0);
		rec.state = HeartRecord.State.DROPPED;
		rec.holder = null;
		rec.entity = item.getUUID();
		rec.dimension = Dims.id(level);
		rec.x = pos.x;
		rec.y = pos.y;
		rec.z = pos.z;
		rec.collector = collector;
		rec.previousOwner = victim.getUUID();
		rec.expiresAt = System.currentTimeMillis() + ChaosConfig.get().collectWindowSeconds * 1000L;
		level.addFreshEntity(item);
		DataStore.save();

		AbilityManager.refreshFocus(victim);
		Fx.far(level, Fx.dust(rec.type.color, 3f), pos.add(0, 1, 0), 60, 0.6, 0);
		Fx.far(level, ParticleTypes.END_ROD, pos.add(0, 1, 0), 40, 0.3, 0.15);
		level.playSound(null, pos.x, pos.y, pos.z, SoundEvents.WITHER_DEATH, SoundSource.PLAYERS, 0.5f, 1.6f);
		level.playSound(null, pos.x, pos.y, pos.z, Fx.custom("heart_drop"), SoundSource.PLAYERS, 1.5f, 1f);

		victim.sendSystemMessage(Component.literal("💔 You lost your ").withStyle(ChatFormatting.RED).append(rec.type.title())
				.append(Component.literal(". Your mastery stays with you.").withStyle(ChatFormatting.GRAY)));
		if (col != null) {
			col.sendSystemMessage(Component.literal("❤ ").withStyle(rec.type.style()).append(victim.getName().copy().withStyle(ChatFormatting.WHITE))
					.append(Component.literal(" dropped the ").withStyle(ChatFormatting.GRAY)).append(rec.type.title())
					.append(Component.literal(". Collect it within " + ChaosConfig.get().collectWindowSeconds / 60 + " minutes.").withStyle(ChatFormatting.GRAY)));
			Fx.title(col, Component.empty(), Component.literal("Claim the ").withStyle(ChatFormatting.GOLD).append(rec.type.title()), 5, 50, 10);
		}
		return true;
	}

	// ---------------------------------------------------------------- pickup

	/** Called from the ItemEntity mixin for every player touch on a heart token. Never lets vanilla pick it up. */
	public static void onTouch(ItemEntity item, Player player) {
		if (!(player instanceof ServerPlayer p) || item.isRemoved()) return;
		UUID id = HeartItems.tokenId(item.getItem());
		HeartRecord rec = id == null ? null : record(id);
		if (rec == null || rec.state != HeartRecord.State.DROPPED || !item.getUUID().equals(rec.entity)) {
			item.discard();
			return;
		}
		if (p.isSpectator() || !p.isAlive()) return;
		// Only the victor may claim it. The loser gets it back when the window runs out, not by grabbing it.
		boolean victor = p.getUUID().equals(rec.collector) || (rec.collector == null && p.getUUID().equals(rec.previousOwner));
		if (!victor) {
			notifyOnce(p, Component.literal("This heart can only be claimed by its victor.").withStyle(ChatFormatting.RED));
			return;
		}
		int max = ChaosConfig.get().maxHeartsPerPlayer;
		if (max > 0 && DataStore.get(p).hearts.size() >= max) {
			notifyOnce(p, Component.literal("You cannot hold more than " + max + " hearts.").withStyle(ChatFormatting.RED));
			return;
		}
		boolean reclaim = p.getUUID().equals(rec.previousOwner);
		giveTo(p.getUUID(), rec);
		item.discard();
		DataStore.save();
		ServerLevel level = (ServerLevel) p.level();
		Fx.implode(level, Fx.dust(rec.type.color, 1.5f), p.position().add(0, 1, 0), 2.5, 50, 0.3);
		level.playSound(null, p.getX(), p.getY(), p.getZ(), SoundEvents.TOTEM_USE, SoundSource.PLAYERS, 0.6f, 1.5f);
		onGained(p, rec, reclaim ? "returns to you" : "is yours");
		ChaosHearts.LOGGER.info("{} collected {} heart {}", p.getName().getString(), rec.type.id(), rec.id);
	}

	private static void notifyOnce(ServerPlayer p, Component msg) {
		long now = System.currentTimeMillis();
		Long last = PICKUP_MSG.get(p.getUUID());
		if (last != null && now - last < 3000) return;
		PICKUP_MSG.put(p.getUUID(), now);
		Fx.actionBar(p, msg);
	}

	// ---------------------------------------------------------------- validation and expiry

	private static void onEntityLoad(Entity e, ServerLevel level) {
		if (!(e instanceof ItemEntity item) || !HeartItems.isToken(item.getItem())) return;
		UUID id = HeartItems.tokenId(item.getItem());
		HeartRecord rec = id == null ? null : record(id);
		if (rec == null || rec.state != HeartRecord.State.DROPPED || !item.getUUID().equals(rec.entity)) {
			ChaosHearts.LOGGER.warn("Removed an invalid heart item {} at {}", id, item.position());
			ChaosHearts.server().execute(item::discard);
		}
	}

	private static void onEntityUnload(Entity e, ServerLevel level) {
		if (!(e instanceof ItemEntity item) || !HeartItems.isToken(item.getItem())) return;
		Entity.RemovalReason reason = e.getRemovalReason();
		if (reason == null || reason == Entity.RemovalReason.UNLOADED_TO_CHUNK || reason == Entity.RemovalReason.UNLOADED_WITH_PLAYER) {
			// Still in the world, just not loaded: remember where it is.
			UUID id = HeartItems.tokenId(item.getItem());
			HeartRecord rec = id == null ? null : record(id);
			if (rec != null && rec.state == HeartRecord.State.DROPPED && item.getUUID().equals(rec.entity)) {
				rec.x = item.getX();
				rec.y = item.getY();
				rec.z = item.getZ();
				DataStore.markDirty();
			}
			return;
		}
		UUID id = HeartItems.tokenId(item.getItem());
		HeartRecord rec = id == null ? null : record(id);
		if (rec != null && rec.state == HeartRecord.State.DROPPED && item.getUUID().equals(rec.entity)) {
			ChaosHearts.server().execute(() -> returnToOwner(rec, "was destroyed and returned to you"));
		}
	}

	public static void returnToOwner(HeartRecord rec, String why) {
		if (rec.state != HeartRecord.State.DROPPED) return;
		discardEntity(rec);
		UUID owner = rec.previousOwner != null ? rec.previousOwner : rec.collector;
		if (owner == null) {
			DataStore.root().hearts.remove(rec.id);
			DataStore.save();
			return;
		}
		giveTo(owner, rec);
		DataStore.save();
		ServerPlayer p = online(owner);
		if (p != null) onGained(p, rec, why);
		else DataStore.get(owner).pendingMessages.add("Your " + rec.type.displayName + " Heart " + why + ".");
	}

	private static void discardEntity(HeartRecord rec) {
		MinecraftServer server = ChaosHearts.server();
		if (server == null || rec.entity == null) return;
		UUID entity = rec.entity;
		// Mark first so the unload hook does not treat this as a destroyed heart.
		rec.entity = null;
		ServerLevel level = Dims.level(server, rec.dimension);
		if (level != null) {
			Entity e = level.getEntity(entity);
			if (e != null) e.discard();
		}
	}

	public static void tick(MinecraftServer server) {
		long t = ChaosHearts.tick();
		if (t % 20 == 0) {
			long now = System.currentTimeMillis();
			for (HeartRecord rec : records()) {
				if (rec.state != HeartRecord.State.DROPPED) continue;
				if (now > rec.expiresAt) {
					ServerPlayer collector = online(rec.collector);
					if (collector != null) collector.sendSystemMessage(Component.literal("You did not claim the " + rec.type.displayName + " Heart in time. It returned to its owner.").withStyle(ChatFormatting.GRAY));
					returnToOwner(rec, "found its way back to you");
					continue;
				}
				ServerLevel level = Dims.level(server, rec.dimension);
				Entity e = level == null || rec.entity == null ? null : level.getEntity(rec.entity);
				if (e != null) {
					Vec3 c = e.position();
					Fx.far(level, Fx.dust(rec.type.color, 2f), c.add(0, 0.6, 0), 6, 0.2, 0);
					Fx.pillar(level, Fx.dust(rec.type.color, 1.5f), c, 12, 10, 0.05);
					Fx.ring(level, ParticleTypes.END_ROD, c.add(0, 0.1, 0), 0.9, 10, t * 0.15);
					ServerPlayer col = online(rec.collector);
					if (col != null && col.level() == level && t % 60 == 0) {
						long secs = (rec.expiresAt - now) / 1000;
						Fx.actionBar(col, Component.literal("❤ " + rec.type.displayName + " Heart: " + (int) col.position().distanceTo(c) + " blocks away, " + secs + "s to claim").withStyle(rec.type.style()));
					}
				}
			}
		}
		if (t % 10 == 5) {
			for (ServerPlayer p : server.getPlayerList().getPlayers()) scrubInventory(p);
		}
	}

	/** Removes heart tokens from inventories. A token can only legitimately exist as a dropped item. */
	private static void scrubInventory(ServerPlayer p) {
		var inv = p.getInventory();
		for (int i = 0; i < inv.getContainerSize(); i++) {
			ItemStack s = inv.getItem(i);
			if (!s.isEmpty() && HeartItems.isToken(s)) {
				inv.setItem(i, ItemStack.EMPTY);
				ChaosHearts.LOGGER.warn("Removed a copied heart item from {}", p.getName().getString());
			}
		}
		ItemStack carried = p.containerMenu.getCarried();
		if (!carried.isEmpty() && HeartItems.isToken(carried)) p.containerMenu.setCarried(ItemStack.EMPTY);
	}

	// ---------------------------------------------------------------- active heart

	/** Returns null on success, or why the swap was refused. */
	public static String setActive(ServerPlayer p, HeartType type, boolean force) {
		PlayerData pd = DataStore.get(p);
		if (!pd.owns(type)) return "You do not hold the " + type.displayName + " Heart.";
		if (pd.active == type) return null;
		long now = System.currentTimeMillis();
		if (!force) {
			if (Combat.isTagged(p)) return "You cannot change hearts in combat.";
			if (TrialManager.inTrial(p)) return "You cannot change hearts during a trial.";
			long cd = ChaosConfig.get().heartSwapCooldownSeconds * 1000L;
			if (now - pd.lastSwapMillis < cd) return "You can change hearts again in " + ((cd - (now - pd.lastSwapMillis)) / 1000 + 1) + "s.";
		}
		HeartType old = pd.active;
		if (old != null) HeartKits.get(old).deactivate(p);
		AbilityManager.state(p).resetCombatState();
		pd.active = type;
		pd.lastSwapMillis = now;
		DataStore.markDirty();
		ServerLevel l = (ServerLevel) p.level();
		Fx.sphere(l, Fx.dust(type.color, 1.2f), p.position().add(0, 1, 0), 1.3, 60);
		Fx.sound(l, p.position(), SoundEvents.BEACON_ACTIVATE, 0.7f, 1.4f);
		p.sendSystemMessage(Component.literal("Your active heart is now the ").withStyle(ChatFormatting.GRAY).append(type.title()).append(Component.literal(".").withStyle(ChatFormatting.GRAY)));
		AbilityManager.refreshFocus(p);
		return null;
	}

	public static ServerPlayer online(UUID id) {
		MinecraftServer s = ChaosHearts.server();
		return s == null || id == null ? null : s.getPlayerList().getPlayer(id);
	}
}
