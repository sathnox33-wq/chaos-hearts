package net.chaoshearts.trial;

import java.util.ArrayList;
import java.util.EnumMap;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import net.chaoshearts.ChaosHearts;
import net.chaoshearts.ability.AbilityManager;
import net.chaoshearts.combat.Combat;
import net.chaoshearts.config.ChaosConfig;
import net.chaoshearts.data.DataStore;
import net.chaoshearts.data.PlayerData;
import net.chaoshearts.eye.EyeManager;
import net.chaoshearts.fx.Displays;
import net.chaoshearts.fx.Fx;
import net.chaoshearts.heart.HeartType;
import net.chaoshearts.mastery.Mastery;
import net.chaoshearts.skill.SkillManager;
import net.chaoshearts.trial.trials.BloodTrial;
import net.chaoshearts.trial.trials.CelestialTrial;
import net.chaoshearts.trial.trials.CorruptionTrial;
import net.chaoshearts.trial.trials.FrozenTrial;
import net.chaoshearts.trial.trials.InfernalTrial;
import net.chaoshearts.trial.trials.RageTrial;
import net.chaoshearts.trial.trials.SpeedTrial;
import net.chaoshearts.trial.trials.StormTrial;
import net.chaoshearts.trial.trials.TitanTrial;
import net.chaoshearts.trial.trials.VoidTrial;
import net.chaoshearts.util.Dims;
import net.fabricmc.fabric.api.entity.event.v1.ServerLivingEntityEvents;
import net.fabricmc.fabric.api.event.lifecycle.v1.ServerEntityEvents;
import net.fabricmc.fabric.api.networking.v1.ServerPlayConnectionEvents;
import net.minecraft.ChatFormatting;
import net.minecraft.core.Holder;
import net.minecraft.core.particles.ParticleTypes;
import net.minecraft.core.registries.Registries;
import net.minecraft.network.chat.Component;
import net.minecraft.network.chat.MutableComponent;
import net.minecraft.network.protocol.game.ClientboundStopSoundPacket;
import net.minecraft.resources.ResourceKey;
import net.minecraft.server.MinecraftServer;
import net.minecraft.server.level.ServerBossEvent;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.sounds.SoundSource;
import net.minecraft.world.BossEvent;
import net.minecraft.world.damagesource.DamageSource;
import net.minecraft.world.effect.MobEffect;
import net.minecraft.world.effect.MobEffectCategory;
import net.minecraft.world.effect.MobEffectInstance;
import net.minecraft.world.effect.MobEffects;
import net.minecraft.world.entity.Entity;
import net.minecraft.world.entity.ExperienceOrb;
import net.minecraft.world.entity.LivingEntity;
import net.minecraft.world.entity.Mob;
import net.minecraft.world.entity.item.ItemEntity;
import net.minecraft.world.entity.player.Player;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.level.GameType;
import net.minecraft.world.level.Level;
import net.minecraft.world.phys.Vec3;
import net.minecraft.world.entity.TraceableEntity;

/**
 * Runs Awakening Trials. Each run gets its own arena far apart from the others in the
 * chaoshearts:trials dimension, so trials never overlap and nobody else can walk in.
 */
public final class TrialManager {
	public static final String TAG = "chaoshearts.trial";
	public static final ResourceKey<Level> DIMENSION = ResourceKey.create(Registries.DIMENSION, ChaosHearts.id("trials"));
	private static final int MAX_SESSIONS = 8;
	private static final int INTRO_TICKS = 200;
	private static final int BOSS_INTRO_TICKS = 70;
	private static final int VICTORY_TICKS = 120;
	/** Length of each trial's music loop in ticks (the generated tracks are 32 s). */
	private static final int MUSIC_TICKS = 640;

	private static final Map<HeartType, Trial> TRIALS = new EnumMap<>(HeartType.class);
	private static final Map<UUID, TrialSession> SESSIONS = new HashMap<>();
	private static final Map<UUID, TrialSession> BY_ID = new HashMap<>();
	private static final List<TrialSession> CLEANING = new ArrayList<>();

	static {
		register(new RageTrial());
		register(new SpeedTrial());
		register(new InfernalTrial());
		register(new VoidTrial());
		register(new FrozenTrial());
		register(new StormTrial());
		register(new BloodTrial());
		register(new TitanTrial());
		register(new CelestialTrial());
		register(new CorruptionTrial());
	}

	private TrialManager() {}

	private static void register(Trial t) {
		TRIALS.put(t.type, t);
	}

	public static Trial trial(HeartType t) {
		return TRIALS.get(t);
	}

	// ---------------------------------------------------------------- queries

	public static TrialSession session(UUID player) {
		return SESSIONS.get(player);
	}

	public static boolean inTrial(Player p) {
		TrialSession s = SESSIONS.get(p.getUUID());
		return s != null && s.state != TrialSession.State.CLEANUP;
	}

	/** True while the player is watching a camera shot. Abilities are disabled then. */
	public static boolean inCinematic(Player p) {
		TrialSession s = SESSIONS.get(p.getUUID());
		return s != null && s.cinematic != null;
	}

	public static boolean isTrialMob(Entity e) {
		return e != null && e.getTags().contains(TAG);
	}

	public static boolean isTrialLevel(Level level) {
		return level.dimension() == DIMENSION;
	}

	private static TrialSession sessionOf(Entity e) {
		for (String tag : e.getTags()) {
			if (tag.startsWith(TAG + ".")) {
				try {
					return BY_ID.get(UUID.fromString(tag.substring(TAG.length() + 1)));
				} catch (IllegalArgumentException ignored) {
				}
			}
		}
		return null;
	}

	private static TrialSession sessionAt(Level level, Vec3 pos) {
		if (!isTrialLevel(level)) return null;
		for (TrialSession s : SESSIONS.values()) if (s.arena.inside(pos, 12)) return s;
		return null;
	}

	public static Component describeSessions() {
		MutableComponent out = Component.literal("— Active trials (" + SESSIONS.size() + ") —").withStyle(ChatFormatting.DARK_PURPLE, ChatFormatting.BOLD);
		for (TrialSession s : SESSIONS.values()) {
			ServerPlayer p = s.player();
			out.append(Component.literal("\n" + (p == null ? s.player.toString() : p.getName().getString()) + " ").withStyle(ChatFormatting.WHITE))
					.append(s.type.title())
					.append(Component.literal(" " + s.state + " phase " + s.phase + " " + s.fightAge / 20 + "s at " + s.arena.center.toShortString()).withStyle(ChatFormatting.GRAY));
		}
		if (!CLEANING.isEmpty()) out.append(Component.literal("\n" + CLEANING.size() + " arena(s) being cleared").withStyle(ChatFormatting.DARK_GRAY));
		return out;
	}

	// ---------------------------------------------------------------- events

	public static void registerEvents() {
		ServerLivingEntityEvents.ALLOW_DEATH.register((entity, source, amount) -> {
			if (entity instanceof ServerPlayer p && inTrial(p)) {
				// Death in a trial costs nothing but the attempt. The player keeps everything.
				p.setHealth(1f);
				ChaosHearts.server().execute(() -> fail(p.getUUID(), "You fell in the trial."));
				return false;
			}
			return true;
		});
		ServerEntityEvents.ENTITY_LOAD.register(TrialManager::onEntityLoad);
		ServerPlayConnectionEvents.DISCONNECT.register((handler, server) -> {
			TrialSession s = SESSIONS.get(handler.player.getUUID());
			if (s != null) end(s, false, "You left the trial.", false);
		});
	}

	private static void onEntityLoad(Entity e, ServerLevel level) {
		if (!isTrialLevel(level) || e instanceof Player || e.getTags().contains(Displays.TAG)) return;
		MinecraftServer server = ChaosHearts.server();
		if (e instanceof ExperienceOrb) {
			server.execute(e::discard);
			return;
		}
		if (e instanceof ItemEntity item) {
			// Only items the trial's own player threw may exist here (they get them back afterwards).
			TrialSession s = sessionAt(level, item.position());
			Entity owner = item instanceof TraceableEntity te ? te.getOwner() : null;
			if (s == null || owner == null || !owner.getUUID().equals(s.player)) server.execute(item::discard);
			return;
		}
		if (!(e instanceof LivingEntity)) return;
		if (e.getTags().contains(TAG)) {
			TrialSession s = sessionOf(e);
			if (s == null || !s.active()) server.execute(e::discard);
			return;
		}
		// Mobs summoned by trial mobs (an evoker's vexes) join the trial; anything else does not belong.
		TrialSession s = sessionAt(level, e.position());
		if (s != null && s.fighting()) {
			e.addTag(TAG);
			e.addTag(s.tag());
			ServerPlayer p = s.player();
			if (e instanceof Mob m && p != null) m.setTarget(p);
		} else {
			server.execute(e::discard);
		}
	}

	/** Damage rules inside trials: the boss only takes damage from its challenger, and trial mobs hit harder with difficulty. */
	public static float modifyDamage(LivingEntity target, DamageSource source, float amount) {
		if (!isTrialLevel(target.level())) return amount;
		Entity src = source.getEntity();
		if (isTrialMob(target)) {
			TrialSession s = sessionOf(target);
			if (s == null) return amount;
			if (src == null) return amount;
			if (src.getUUID().equals(s.player) || src.getTags().contains("chaoshearts.ally." + s.player)) {
				if (target.getUUID().equals(s.boss) && target instanceof Mob boss) {
					if (s.state != TrialSession.State.BOSS) return 0;
					return s.trial.bossIncoming(s, boss, amount);
				}
				return amount;
			}
			return 0;
		}
		if (target instanceof ServerPlayer p && isTrialMob(src)) {
			TrialSession s = SESSIONS.get(p.getUUID());
			if (s == null || !s.fighting()) return 0;
			return (float) (amount * TrialKit.difficulty());
		}
		return amount;
	}

	// ---------------------------------------------------------------- starting

	/** Returns null if the trial started, otherwise why not. */
	public static String start(ServerPlayer p, HeartType type, boolean force) {
		MinecraftServer server = ChaosHearts.server();
		ServerLevel level = server.getLevel(DIMENSION);
		if (level == null) return "The trials dimension is missing. Is the mod's datapack disabled?";
		if (SESSIONS.containsKey(p.getUUID())) return "You are already in a trial.";
		if (EyeManager.isEye(p)) return "Leave the Eye's form first.";
		if (SESSIONS.size() >= MAX_SESSIONS) return "Too many trials are running. Try again in a few minutes.";
		PlayerData pd = DataStore.get(p);
		if (!pd.owns(type)) return "You must hold the " + type.displayName + " Heart.";
		PlayerData.HeartProgress prog = pd.progress(type);
		long now = System.currentTimeMillis();
		if (!force) {
			if (pd.active != type) return "Make the " + type.displayName + " Heart your active heart first.";
			if (prog.awakened) return "Your " + type.displayName + " Heart is already awakened.";
			if (Mastery.level(prog.xp) < Mastery.MAX) return "The trial opens at " + type.displayName + " mastery 100. You are at " + Mastery.level(prog.xp) + ".";
			if (now < pd.trialRetryAtMillis) return "The heart is still recovering. Try again in " + ((pd.trialRetryAtMillis - now) / 60000 + 1) + " min.";
			if (p.isCreative() || p.isSpectator()) return "Trials are fought in survival.";
		}
		if (Combat.isTagged(p)) return "You cannot begin a trial in combat.";
		if (p.isPassenger() || p.isSleeping() || !p.isAlive()) return "You cannot begin a trial right now.";
		if (isTrialLevel(p.level())) return "You are already in the trials dimension.";

		Trial trial = TRIALS.get(type);
		int slot = DataStore.root().trialSlotCounter++;
		Arena arena = new Arena(level, Arena.centerForSlot(slot), trial.radius(), slot * 31L + type.ordinal());
		arena.planBase(trial.palette(), trial.pillars());
		trial.decorate(arena);

		PlayerData.TrialReturn r = new PlayerData.TrialReturn();
		r.dimension = Dims.id(p.level());
		r.x = p.getX();
		r.y = p.getY();
		r.z = p.getZ();
		r.yaw = p.getYRot();
		r.pitch = p.getXRot();
		r.gameMode = p.gameMode.getGameModeForPlayer().name();
		r.heart = type.id();
		pd.trialReturn = r;
		DataStore.save();

		TrialSession s = new TrialSession(p.getUUID(), type, trial, arena, force);
		s.timeLimitTicks = Math.max(1, ChaosConfig.get().trialTimeLimitMinutes) * 1200;
		SESSIONS.put(p.getUUID(), s);
		BY_ID.put(s.id, s);
		ChaosHearts.LOGGER.info("{} started the {} trial in arena slot {} ({} blocks)", p.getName().getString(), type.id(), slot, arena.plannedCount());

		ServerLevel here = p.level();
		Fx.title(p, Component.literal("The heart stirs...").withStyle(type.style().withBold(true)), Component.literal(trial.title()).withStyle(ChatFormatting.GRAY), 10, 40, 10);
		Fx.sound(here, p.position(), SoundEvents.PORTAL_TRIGGER, 0.6f, 1.4f);
		Fx.helix(here, Fx.dust(type.color, 1.5f), p.position(), 1.2, 3, 4, 80, 0);
		return null;
	}

	// ---------------------------------------------------------------- the main loop

	public static void tick(MinecraftServer server) {
		long t = ChaosHearts.tick();
		for (TrialSession s : new ArrayList<>(SESSIONS.values())) {
			try {
				step(s);
			} catch (Throwable e) {
				ChaosHearts.LOGGER.error("Trial for {} crashed, ending it", s.player, e);
				PlayerData pd = DataStore.get(s.player);
				long before = pd.trialRetryAtMillis;
				end(s, false, "The trial collapsed. Your attempt was not counted.", true);
				pd.trialRetryAtMillis = before;
			}
		}
		Iterator<TrialSession> it = CLEANING.iterator();
		int budget = ChaosConfig.get().trialBuildBlocksPerTick;
		while (it.hasNext()) {
			TrialSession s = it.next();
			if (s.arena.clearStep(budget)) {
				it.remove();
				BY_ID.remove(s.id);
			}
			break; // one arena at a time
		}
		if (t % 20 == 7) removeIntruders(server);
	}

	private static void step(TrialSession s) {
		ServerPlayer p = s.player();
		if (p == null) {
			end(s, false, "You left the trial.", false);
			return;
		}
		s.stateAge++;
		if (s.state != TrialSession.State.BUILDING && !isTrialLevel(p.level())) {
			end(s, false, "You left the arena.", true);
			return;
		}
		switch (s.state) {
			case BUILDING -> stepBuilding(s, p);
			case INTRO -> stepIntro(s, p);
			case WAVES -> {
				fightTick(s, p);
				stepWaves(s, p);
			}
			case BOSS_INTRO -> stepBossIntro(s, p);
			case BOSS -> {
				fightTick(s, p);
				stepBoss(s, p);
			}
			case VICTORY -> stepVictory(s, p);
			default -> {}
		}
	}

	private static void enter(TrialSession s, TrialSession.State state) {
		s.state = state;
		s.stateAge = 0;
	}

	private static void stepBuilding(TrialSession s, ServerPlayer p) {
		if (Combat.isTagged(p)) {
			end(s, false, "The trial fades: you were pulled into combat.", true);
			return;
		}
		boolean done = s.arena.buildStep(ChaosConfig.get().trialBuildBlocksPerTick);
		Fx.actionBar(p, Component.literal("The arena takes shape... " + Math.round(s.arena.buildProgress() * 100) + "%").withStyle(s.type.style()));
		Fx.ring(p.level(), Fx.dust(s.type.color, 1.2f), p.position().add(0, 0.1, 0), 1.4, 16, s.stateAge * 0.3);
		if (done && s.stateAge > 20) enterIntro(s, p);
	}

	private static void enterIntro(TrialSession s, ServerPlayer p) {
		enter(s, TrialSession.State.INTRO);
		Arena a = s.arena;
		Vec3 c = a.centerTop();
		Vec3 look = c.add(0, 2, 0);
		double R = a.radius;
		Vec3 boss = a.bossSpawn();
		Vec3 spawn = a.playerSpawn();
		Cinematic cine = new Cinematic()
				.orbit(0, 110, c, R + 9, 17, 9, Math.PI / 2, Math.PI / 2 + Math.PI * 1.5, look)
				.key(150, boss.add(0, 3.2, 8), boss.add(0, 1.6, 0))
				.key(175, boss.add(2, 2.4, 6), boss.add(0, 1.8, 0))
				.key(INTRO_TICKS, spawn.add(0, 2.6, 4.5), c.add(0, 1.5, 0));
		Vec3 first = c.add(Math.cos(Math.PI / 2) * (R + 9), 17, Math.sin(Math.PI / 2) * (R + 9));
		p.teleport(new net.minecraft.world.level.portal.TeleportTransition(s.level, first, Vec3.ZERO, 0, 30, net.minecraft.world.level.portal.TeleportTransition.DO_NOTHING));
		p.setGameMode(GameType.SPECTATOR);
		cine.start(s.level);
		s.cinematic = cine;
		Fx.customTo(p, "trial_intro", SoundSource.MASTER, 1f, 1f);
		Fx.soundTo(p, Holder.direct(SoundEvents.END_PORTAL_SPAWN), SoundSource.MASTER, 0.5f, 0.7f);
	}

	private static void stepIntro(TrialSession s, ServerPlayer p) {
		Cinematic cine = s.cinematic;
		cine.tick(p);
		int t = cine.age();
		Trial trial = s.trial;
		if (t == 8) Fx.title(p, Component.literal("AWAKENING TRIAL").withStyle(ChatFormatting.GOLD, ChatFormatting.BOLD), s.type.title(), 15, 55, 15);
		if (t == 40) startMusic(s, p);
		if (t == 85) Fx.title(p, Component.literal(trial.title()).withStyle(s.type.style().withBold(true)), Component.literal(trial.tagline()).withStyle(ChatFormatting.GRAY), 10, 60, 15);
		if (t == 150) {
			Vec3 b = s.arena.bossSpawn();
			Fx.far(s.level, Fx.dust(s.type.color, 2.5f), b.add(0, 1.5, 0), 60, 0.8, 0);
			Fx.far(s.level, ParticleTypes.SCULK_SOUL, b.add(0, 1, 0), 20, 0.6, 0.05);
			Fx.soundTo(p, Holder.direct(SoundEvents.WARDEN_HEARTBEAT), SoundSource.HOSTILE, 1f, 0.7f);
			Fx.title(p, Component.empty(), Component.literal(trial.bossName() + " awaits.").withStyle(ChatFormatting.DARK_GRAY, ChatFormatting.ITALIC), 5, 40, 10);
		}
		if (t % 10 == 0) trial.ambient(s);
		if (cine.finished()) {
			cine.stop(p);
			s.cinematic = null;
			Vec3 spawn = s.arena.playerSpawn();
			p.setGameMode(GameType.ADVENTURE);
			p.teleport(new net.minecraft.world.level.portal.TeleportTransition(s.level, spawn, Vec3.ZERO, 180, 0, net.minecraft.world.level.portal.TeleportTransition.DO_NOTHING));
			p.addEffect(new MobEffectInstance(MobEffects.RESISTANCE, 60, 4, false, false, true));
			enter(s, TrialSession.State.WAVES);
			s.fightStartMillis = System.currentTimeMillis();
			s.waveDelay = 60;
			s.bar = new ServerBossEvent(Component.literal(trial.title()), trial.barColor(), BossEvent.BossBarOverlay.NOTCHED_10);
			s.bar.addPlayer(p);
		}
	}

	/** Shared every fight tick: timer, safety, zones, music, retargeting and leashing. */
	private static void fightTick(TrialSession s, ServerPlayer p) {
		s.fightAge++;
		Arena a = s.arena;
		if (s.fightAge > s.timeLimitTicks) {
			end(s, false, "Time ran out.", true);
			return;
		}
		if (!a.inside(p.position(), 1)) {
			Vec3 spawn = a.playerSpawn();
			p.teleport(new net.minecraft.world.level.portal.TeleportTransition(s.level, spawn, Vec3.ZERO, 180, 0, net.minecraft.world.level.portal.TeleportTransition.DO_NOTHING));
			p.resetFallDistance();
			p.hurtServer(s.level, s.level.damageSources().fellOutOfWorld(), 4f);
		}
		if (p.gameMode.getGameModeForPlayer() != GameType.ADVENTURE && s.cinematic == null) p.setGameMode(GameType.ADVENTURE);
		// Zones
		Iterator<TrialSession.Zone> zit = s.zones.iterator();
		while (zit.hasNext()) {
			TrialSession.Zone z = zit.next();
			if (--z.ticksLeft <= 0) {
				zit.remove();
				continue;
			}
			if (s.fightAge % 4 == 0) Fx.disc(s.level, Fx.dust(z.color, 1.2f), z.pos.add(0, 0.15, 0), z.radius, (int) (4 + z.radius * 3));
			if (s.fightAge % 10 == 0 && TrialKit.near(s, z.pos, z.radius) && Math.abs(p.getY() - z.pos.y) < 2.5) {
				if (z.damagePerSecond > 0) TrialKit.hit(s, s.boss(), z.damagePerSecond / 2);
				if (z.onTouch != null) z.onTouch.accept(p);
			}
		}
		if (s.fightAge % 10 == 0) s.trial.ambient(s);
		if (ChaosHearts.tick() >= s.nextMusicTick) startMusic(s, p);
		if (s.fightAge % 20 == 0) {
			for (UUID id : new ArrayList<>(s.adds)) retarget(s, s.level.getEntity(id), p);
			retarget(s, s.boss(), p);
		}
		int left = (s.timeLimitTicks - s.fightAge) / 20;
		if (s.fightAge % 20 == 0 && left <= 60) Fx.actionBar(p, Component.literal("⌛ " + left + "s").withStyle(left <= 15 ? ChatFormatting.RED : ChatFormatting.GOLD));
	}

	private static void retarget(TrialSession s, Entity e, ServerPlayer p) {
		if (!(e instanceof Mob m) || !m.isAlive()) return;
		if (m.getTarget() != p) m.setTarget(p);
		if (!s.arena.inside(m.position(), 0)) {
			Vec3 c = s.arena.floorPoint(2, s.arena.radius - 6);
			m.teleportTo(c.x, c.y, c.z);
			m.setDeltaMovement(Vec3.ZERO);
			Fx.at(s.level, ParticleTypes.REVERSE_PORTAL, c.add(0, 1, 0), 30, 0.4, 0.1);
		}
	}

	private static void stepWaves(TrialSession s, ServerPlayer p) {
		if (s.state != TrialSession.State.WAVES) return;
		Trial trial = s.trial;
		int total = trial.waves();
		if (s.waveDelay > 0) {
			s.waveDelay--;
			if (s.waveDelay == 59 || s.waveDelay == 39 || s.waveDelay == 19) {
				int n = s.waveDelay / 20 + 1;
				Fx.title(p, Component.literal(String.valueOf(n)).withStyle(s.type.style().withBold(true)), Component.literal("Wave " + (s.wave + 2) + " of " + total).withStyle(ChatFormatting.GRAY), 0, 15, 5);
				Fx.soundTo(p, Holder.direct(SoundEvents.NOTE_BLOCK_HAT.value()), SoundSource.MASTER, 1f, 0.8f);
			}
			s.bar.setName(Component.literal(trial.title() + " — Wave " + (s.wave + 2) + " incoming").withStyle(s.type.style()));
			s.bar.setProgress(1f - s.waveDelay / 60f);
			if (s.waveDelay == 0) {
				s.wave++;
				s.waveDelay = -1;
				trial.spawnWave(s, s.wave);
				s.var("waveSize", Math.max(1, s.adds.size()));
				Fx.title(p, Component.literal("WAVE " + (s.wave + 1)).withStyle(s.type.style().withBold(true)), Component.literal("Defeat every foe").withStyle(ChatFormatting.GRAY), 0, 25, 10);
				Fx.soundTo(p, Holder.direct(SoundEvents.RAID_HORN.value()), SoundSource.HOSTILE, 0.6f, 1.2f);
				Fx.customTo(p, "trial_wave", SoundSource.MASTER, 1f, 1f);
			}
			return;
		}
		int alive = TrialKit.aliveAdds(s);
		s.bar.setName(Component.literal(trial.title() + " — Wave " + (s.wave + 1) + "/" + total + " — " + alive + " remain").withStyle(s.type.style()));
		s.bar.setProgress(Math.max(0f, Math.min(1f, alive / (float) s.var("waveSize"))));
		if (alive == 0) {
			Fx.soundTo(p, Holder.direct(SoundEvents.PLAYER_LEVELUP), SoundSource.MASTER, 0.6f, 1.3f);
			if (s.wave + 1 < total) {
				s.waveDelay = 60;
			} else {
				enterBossIntro(s, p);
			}
		}
	}

	private static void enterBossIntro(TrialSession s, ServerPlayer p) {
		enter(s, TrialSession.State.BOSS_INTRO);
		s.zones.clear();
		s.resumePos = p.position();
		s.resumeYaw = p.getYRot();
		s.resumePitch = p.getXRot();
		Vec3 b = s.arena.bossSpawn();
		Cinematic cine = new Cinematic()
				.key(0, p.getEyePosition(), b.add(0, 1.5, 0))
				.key(28, b.add(0, 4.5, 10), b.add(0, 2, 0))
				.key(BOSS_INTRO_TICKS, b.add(3.5, 2.6, 6.5), b.add(0, 2.8, 0));
		cine.start(s.level);
		s.cinematic = cine;
		p.setGameMode(GameType.SPECTATOR);
		s.bar.setName(Component.literal(s.trial.bossName()).withStyle(s.type.style().withBold(true)));
		s.bar.setProgress(0f);
		Fx.soundTo(p, Holder.direct(SoundEvents.WITHER_SPAWN), SoundSource.HOSTILE, 0.35f, 0.8f);
	}

	private static void stepBossIntro(TrialSession s, ServerPlayer p) {
		Cinematic cine = s.cinematic;
		cine.tick(p);
		int t = cine.age();
		if (t == 20) {
			Mob boss = s.trial.spawnBoss(s, s.arena.bossSpawn());
			if (boss == null) {
				end(s, false, "The boss could not be summoned.", true);
				return;
			}
			s.boss = boss.getUUID();
			s.adds.remove(boss.getUUID());
			boss.setNoAi(true);
			boss.setInvulnerable(true);
			s.trial.bossEntrance(s, boss);
			Fx.customTo(p, "boss_roar", SoundSource.HOSTILE, 1f, 1f);
		}
		if (t == 26) Fx.title(p, Component.literal(s.trial.bossName()).withStyle(s.type.style().withBold(true)), Component.literal("Guardian of the " + s.type.displayName + " Heart").withStyle(ChatFormatting.GRAY), 5, 50, 10);
		if (t > 20 && s.bar != null) s.bar.setProgress(Math.min(1f, (t - 20) / 40f));
		if (cine.finished()) {
			cine.stop(p);
			s.cinematic = null;
			p.setGameMode(GameType.ADVENTURE);
			p.teleport(new net.minecraft.world.level.portal.TeleportTransition(s.level, s.resumePos, Vec3.ZERO, s.resumeYaw, s.resumePitch, net.minecraft.world.level.portal.TeleportTransition.DO_NOTHING));
			Mob boss = s.boss();
			if (boss == null) {
				end(s, false, "The boss vanished.", true);
				return;
			}
			boss.setNoAi(false);
			boss.setInvulnerable(false);
			boss.setTarget(p);
			s.bar.setColor(s.trial.barColor());
			s.bar.setOverlay(BossEvent.BossBarOverlay.NOTCHED_20);
			s.phase = 2;
			enter(s, TrialSession.State.BOSS);
			s.trial.onPhase(s, boss, 2);
		}
	}

	private static void stepBoss(TrialSession s, ServerPlayer p) {
		if (s.state != TrialSession.State.BOSS) return;
		Mob boss = s.boss();
		if (boss == null) {
			enterVictory(s, p);
			return;
		}
		float frac = boss.getHealth() / boss.getMaxHealth();
		s.bar.setProgress(Math.max(0f, Math.min(1f, frac)));
		if (s.phase == 2 && frac <= 0.5f) {
			s.phase = 3;
			s.bar.setName(Component.literal(s.trial.bossName() + " — ENRAGED").withStyle(s.type.style().withBold(true)));
			Fx.title(p, Component.literal("ENRAGED").withStyle(ChatFormatting.DARK_RED, ChatFormatting.BOLD), Component.literal(s.trial.bossName() + " calls for aid").withStyle(ChatFormatting.GRAY), 3, 30, 10);
			Fx.customTo(p, "boss_phase", SoundSource.HOSTILE, 1f, 1f);
			Fx.soundTo(p, Holder.direct(SoundEvents.ENDER_DRAGON_GROWL), SoundSource.HOSTILE, 0.6f, 1.1f);
			s.trial.onPhase(s, boss, 3);
			s.trial.spawnWave(s, s.trial.waves());
		} else if (s.phase == 3 && frac <= 0.2f) {
			s.phase = 4;
			s.bar.setName(Component.literal(s.trial.bossName() + " — LAST STAND").withStyle(ChatFormatting.DARK_RED, ChatFormatting.BOLD));
			Fx.title(p, Component.literal("LAST STAND").withStyle(ChatFormatting.DARK_RED, ChatFormatting.BOLD), Component.literal("Finish it").withStyle(ChatFormatting.GRAY), 3, 30, 10);
			Fx.customTo(p, "boss_phase", SoundSource.HOSTILE, 1f, 0.8f);
			s.trial.onPhase(s, boss, 4);
		}
		s.trial.bossTick(s, boss);
	}

	private static void enterVictory(TrialSession s, ServerPlayer p) {
		enter(s, TrialSession.State.VICTORY);
		s.won = true;
		long millis = System.currentTimeMillis() - s.fightStartMillis;
		discardMobs(s);
		s.zones.clear();
		stopMusic(p, s);
		if (s.bar != null) s.bar.removeAllPlayers();
		awaken(p, s.type, millis);
		p.setHealth(p.getMaxHealth());
		Vec3 c = p.position();
		Cinematic cine = new Cinematic().orbit(0, VICTORY_TICKS, c, 6, 3.5, 2, 0, Math.PI * 1.5, c.add(0, 1.2, 0));
		cine.start(s.level);
		s.cinematic = cine;
		s.resumePos = c;
		p.setGameMode(GameType.SPECTATOR);
		Fx.customTo(p, "trial_victory", SoundSource.MASTER, 1f, 1f);
		Fx.soundTo(p, Holder.direct(SoundEvents.UI_TOAST_CHALLENGE_COMPLETE), SoundSource.MASTER, 1f, 1f);
		Fx.title(p, Component.literal("✦ AWAKENED ✦").withStyle(ChatFormatting.GOLD, ChatFormatting.BOLD), s.type.title().append(Component.literal(" — " + formatTime(millis)).withStyle(ChatFormatting.GRAY)), 10, 80, 20);
	}

	private static void stepVictory(TrialSession s, ServerPlayer p) {
		Cinematic cine = s.cinematic;
		if (cine != null) cine.tick(p);
		int t = s.stateAge;
		Vec3 c = s.resumePos;
		if (t % 8 == 0) {
			Vec3 burst = c.add((s.level.random.nextDouble() - 0.5) * 10, 6 + s.level.random.nextDouble() * 5, (s.level.random.nextDouble() - 0.5) * 10);
			Fx.far(s.level, Fx.dust(s.type.color, 2.5f), burst, 40, 1.2, 0);
			Fx.far(s.level, ParticleTypes.FIREWORK, burst, 50, 0.1, 0.25);
			Fx.sound(s.level, burst, SoundEvents.FIREWORK_ROCKET_LARGE_BLAST, 1f, 0.9f + s.level.random.nextFloat() * 0.3f);
		}
		if (t % 4 == 0) Fx.helix(s.level, Fx.dust(s.type.color, s.type.secondaryColor, 1.4f), c, 1.2, 3.5, 2, 30, t * 0.2);
		if (t == 20) Fx.at(s.level, ParticleTypes.TOTEM_OF_UNDYING, c.add(0, 1, 0), 120, 0.5, 0.6);
		if (t >= VICTORY_TICKS) end(s, true, null, true);
	}

	// ---------------------------------------------------------------- ending

	public static void win(UUID player) {
		TrialSession s = SESSIONS.get(player);
		ServerPlayer p = s == null ? null : s.player();
		if (s == null || p == null || s.state == TrialSession.State.VICTORY) return;
		if (s.cinematic != null) {
			s.cinematic.stop(p);
			s.cinematic = null;
		}
		enterVictory(s, p);
	}

	public static void fail(UUID player, String reason) {
		TrialSession s = SESSIONS.get(player);
		if (s != null && s.state != TrialSession.State.VICTORY) end(s, false, reason, true);
	}

	/**
	 * Ends a session. returnPlayer is false when the player is disconnecting: their return point
	 * stays saved and they are put back when they next join.
	 */
	private static void end(TrialSession s, boolean won, String reason, boolean returnPlayer) {
		if (SESSIONS.get(s.player) != s) return;
		SESSIONS.remove(s.player);
		s.endReason = reason;
		ServerPlayer p = s.player();
		if (s.cinematic != null) {
			s.cinematic.stop(p);
			s.cinematic = null;
		}
		if (s.bar != null) s.bar.removeAllPlayers();
		PlayerData pd = DataStore.get(s.player);
		boolean entered = s.state != TrialSession.State.BUILDING;
		if (!won && entered && !s.forced) pd.trialRetryAtMillis = System.currentTimeMillis() + ChaosConfig.get().trialRetryCooldownMinutes * 60_000L;
		if (p != null && returnPlayer) {
			stopMusic(p, s);
			if (entered) {
				recoverItems(s, p);
				returnPlayer(p, pd, true);
			} else {
				pd.trialReturn = null;
			}
			if (!won && reason != null) {
				Fx.title(p, Component.literal("TRIAL FAILED").withStyle(ChatFormatting.DARK_RED, ChatFormatting.BOLD), Component.literal(reason).withStyle(ChatFormatting.GRAY), 5, 60, 20);
				p.sendSystemMessage(Component.literal("✖ " + reason + (entered && !s.forced ? " You can try again in " + ChaosConfig.get().trialRetryCooldownMinutes + " minutes." : "")).withStyle(ChatFormatting.RED));
				if (entered) Fx.customTo(p, "trial_fail", SoundSource.MASTER, 1f, 1f);
				Fx.soundTo(p, Holder.direct(SoundEvents.BEACON_DEACTIVATE), SoundSource.MASTER, 1f, 0.6f);
			}
		} else if (!entered) {
			pd.trialReturn = null;
		}
		DataStore.save();
		discardMobs(s);
		discardLoose(s);
		s.zones.clear();
		s.state = TrialSession.State.CLEANUP;
		s.arena.beginClear();
		CLEANING.add(s);
		ChaosHearts.LOGGER.info("Trial {} for {} ended: {}", s.type.id(), s.player, won ? "victory" : reason);
	}

	private static void discardMobs(TrialSession s) {
		for (Entity e : s.level.getEntities((Entity) null, s.arena.bounds(), e -> e.getTags().contains(s.tag()))) e.discard();
		s.adds.clear();
		s.boss = null;
	}

	/** Arrows, fangs and other leftovers that are not players. */
	private static void discardLoose(TrialSession s) {
		for (Entity e : s.level.getEntities((Entity) null, s.arena.bounds(), e -> !(e instanceof Player) && !(e instanceof ItemEntity) && !e.getTags().contains(Displays.TAG))) e.discard();
	}

	/** Gives back items the player dropped in the arena. */
	private static void recoverItems(TrialSession s, ServerPlayer p) {
		for (ItemEntity item : s.level.getEntitiesOfClass(ItemEntity.class, s.arena.bounds())) {
			Entity owner = item.getOwner();
			if (owner != null && owner.getUUID().equals(p.getUUID())) {
				ItemStack stack = item.getItem().copy();
				item.discard();
				if (!p.getInventory().add(stack)) p.drop(stack, false);
			} else {
				item.discard();
			}
		}
	}

	/** Puts the player back where they were before the trial and restores their game mode. */
	private static void returnPlayer(ServerPlayer p, PlayerData pd, boolean heal) {
		PlayerData.TrialReturn r = pd.trialReturn;
		MinecraftServer server = ChaosHearts.server();
		p.setCamera(p);
		ServerLevel level = r == null ? null : Dims.level(server, r.dimension);
		if (level != null && !isTrialLevel(level)) {
			p.teleport(new net.minecraft.world.level.portal.TeleportTransition(level, new Vec3(r.x, r.y, r.z), Vec3.ZERO, r.yaw, r.pitch, net.minecraft.world.level.portal.TeleportTransition.DO_NOTHING));
		} else {
			p.teleport(p.findRespawnPositionAndUseSpawnBlock(false, net.minecraft.world.level.portal.TeleportTransition.DO_NOTHING));
		}
		GameType mode = GameType.SURVIVAL;
		if (r != null && r.gameMode != null) {
			try {
				mode = GameType.valueOf(r.gameMode);
			} catch (IllegalArgumentException ignored) {
			}
		}
		if (mode == GameType.SPECTATOR) mode = GameType.SURVIVAL;
		p.setGameMode(mode);
		List<Holder<MobEffect>> harmful = new ArrayList<>();
		for (MobEffectInstance e : p.getActiveEffects()) if (e.getEffect().value().getCategory() == MobEffectCategory.HARMFUL) harmful.add(e.getEffect());
		for (Holder<MobEffect> e : harmful) p.removeEffect(e);
		p.clearFire();
		p.setTicksFrozen(0);
		p.resetFallDistance();
		if (heal) p.setHealth(p.getMaxHealth());
		p.addEffect(new MobEffectInstance(MobEffects.RESISTANCE, 100, 4, false, false, true));
		pd.trialReturn = null;
		DataStore.save();
		AbilityManager.refreshFocus(p);
	}

	/** Awakens a heart (trial victory or admin). */
	public static void awaken(ServerPlayer p, HeartType type, long trialMillis) {
		PlayerData.HeartProgress prog = DataStore.get(p).progress(type);
		boolean first = !prog.awakened;
		prog.awakened = true;
		if (first) prog.awakenedAtXp = prog.xp;
		if (trialMillis > 0 && (prog.bestTrialMillis == 0 || trialMillis < prog.bestTrialMillis)) prog.bestTrialMillis = trialMillis;
		SkillManager.invalidate(p.getUUID());
		DataStore.save();
		AbilityManager.refreshFocus(p);
		if (!first) return;
		p.sendSystemMessage(Component.literal("✦ The " + type.displayName + " Heart is awakened. ").withStyle(type.style().withBold(true))
				.append(Component.literal("You have " + SkillManager.available(type, prog) + " skill points. ").withStyle(ChatFormatting.GOLD))
				.append(Component.literal("/hearts tree").withStyle(ChatFormatting.YELLOW)));
		Component announce = Component.literal("✦ ").withStyle(type.style())
				.append(p.getName().copy().withStyle(ChatFormatting.WHITE, ChatFormatting.BOLD))
				.append(Component.literal(" has awakened the ").withStyle(ChatFormatting.GRAY))
				.append(type.title().withStyle(s -> s.withBold(true)))
				.append(Component.literal("!").withStyle(ChatFormatting.GRAY));
		for (ServerPlayer other : ChaosHearts.server().getPlayerList().getPlayers()) {
			other.sendSystemMessage(announce);
			if (other != p) Fx.customTo(other, "heart_awaken", SoundSource.MASTER, 0.6f, 1f);
		}
	}

	public static String formatTime(long millis) {
		long s = millis / 1000;
		return (s / 60) + ":" + String.format("%02d", s % 60);
	}

	// ---------------------------------------------------------------- music

	private static void startMusic(TrialSession s, ServerPlayer p) {
		Fx.customTo(p, "trial_music_" + s.type.id(), SoundSource.RECORDS, 0.8f, 1f);
		s.nextMusicTick = ChaosHearts.tick() + MUSIC_TICKS;
	}

	private static void stopMusic(ServerPlayer p, TrialSession s) {
		p.connection.send(new ClientboundStopSoundPacket(ChaosHearts.id("trial_music_" + s.type.id()), SoundSource.RECORDS));
	}

	// ---------------------------------------------------------------- joins, restarts and intruders

	public static void onJoin(ServerPlayer p) {
		PlayerData pd = DataStore.get(p);
		if (pd.trialReturn != null && !SESSIONS.containsKey(p.getUUID())) {
			// They left mid-trial or the server stopped: put them back where they started.
			ChaosHearts.server().execute(() -> {
				returnPlayer(p, pd, true);
				p.sendSystemMessage(Component.literal("Your trial ended while you were away. You were returned to where you began.").withStyle(ChatFormatting.GRAY));
			});
		} else if (isTrialLevel(p.level()) && !SESSIONS.containsKey(p.getUUID())) {
			ChaosHearts.server().execute(() -> returnPlayer(p, pd, false));
		}
	}

	private static void removeIntruders(MinecraftServer server) {
		ServerLevel level = server.getLevel(DIMENSION);
		if (level == null) return;
		for (ServerPlayer p : new ArrayList<>(level.players())) {
			TrialSession s = SESSIONS.get(p.getUUID());
			if (s != null && s.state != TrialSession.State.BUILDING) continue;
			if (EyeManager.isEye(p)) continue; // the Eye may watch
			ChaosHearts.LOGGER.warn("{} was in the trials dimension without a trial; sending them back", p.getName().getString());
			returnPlayer(p, DataStore.get(p), false);
		}
	}

	public static void onServerStarted(MinecraftServer server) {
		if (server.getLevel(DIMENSION) == null) ChaosHearts.LOGGER.error("The chaoshearts:trials dimension did not load. Awakening Trials will not work.");
	}

	public static void onServerStopping(MinecraftServer server) {
		for (TrialSession s : new ArrayList<>(SESSIONS.values())) {
			PlayerData pd = DataStore.get(s.player);
			long before = pd.trialRetryAtMillis;
			end(s, false, "The server is restarting. Your attempt was not counted.", true);
			// A restart is never the player's fault.
			pd.trialRetryAtMillis = before;
		}
		for (TrialSession s : CLEANING) s.arena.clearNow();
		CLEANING.clear();
		BY_ID.clear();
	}
}
