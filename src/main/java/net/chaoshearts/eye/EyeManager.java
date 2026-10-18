package net.chaoshearts.eye;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.joml.Quaternionf;
import org.joml.Vector3f;

import com.mojang.brigadier.CommandDispatcher;
import com.mojang.brigadier.arguments.FloatArgumentType;
import com.mojang.brigadier.arguments.StringArgumentType;
import com.mojang.brigadier.context.CommandContext;
import com.mojang.brigadier.exceptions.CommandSyntaxException;
import com.mojang.datafixers.util.Pair;

import net.chaoshearts.ChaosHearts;
import net.chaoshearts.command.ChaosCommands;
import net.chaoshearts.command.Perms;
import net.chaoshearts.config.ChaosConfig;
import net.chaoshearts.data.DataStore;
import net.chaoshearts.data.HeartRecord;
import net.chaoshearts.data.PlayerData;
import net.chaoshearts.fx.Displays;
import net.chaoshearts.fx.Fx;
import net.chaoshearts.fx.Scheduler;
import net.chaoshearts.heart.HeartManager;
import net.chaoshearts.heart.HeartType;
import net.chaoshearts.trial.TrialManager;
import net.fabricmc.fabric.api.message.v1.ServerMessageEvents;
import net.fabricmc.fabric.api.networking.v1.ServerPlayConnectionEvents;
import net.minecraft.ChatFormatting;
import net.minecraft.commands.CommandSourceStack;
import net.minecraft.commands.Commands;
import net.minecraft.commands.arguments.EntityArgument;
import net.minecraft.core.Holder;
import net.minecraft.core.component.DataComponents;
import net.minecraft.core.particles.ParticleTypes;
import net.minecraft.network.chat.Component;
import net.minecraft.network.chat.MutableComponent;
import net.minecraft.network.protocol.game.ClientboundSetEquipmentPacket;
import net.minecraft.server.MinecraftServer;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.sounds.SoundSource;
import net.minecraft.world.effect.MobEffectInstance;
import net.minecraft.world.effect.MobEffects;
import net.minecraft.world.entity.Display;
import net.minecraft.world.entity.EquipmentSlot;
import net.minecraft.world.entity.player.Abilities;
import net.minecraft.world.entity.player.Player;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.Items;
import net.minecraft.world.item.component.CustomModelData;
import net.minecraft.world.phys.Vec3;

/**
 * The admin's monster form: a giant eye wrapped in a shroud of darkness. The admin flies, cannot
 * be hurt or targeted, speaks in the Eye's voice and can grant or tear out Chaos Hearts.
 */
public final class EyeManager {
	private static final int VOID_PURPLE = 0x3B0A5C;
	private static final int IRIS = 0xC21A3A;

	private static final class Form {
		final UUID player;
		Display.ItemDisplay eye;
		Display.TextDisplay speech;
		long speechUntil;
		float scale;
		// What to restore.
		boolean mayfly, flying, invulnerable;
		float flySpeed;
		UUID gazeTarget;
		long gazeUntil;

		Form(UUID player) {
			this.player = player;
		}
	}

	private static final Map<UUID, Form> FORMS = new HashMap<>();

	private EyeManager() {}

	public static boolean isEye(Player p) {
		return p != null && FORMS.containsKey(p.getUUID());
	}

	// ---------------------------------------------------------------- transform

	public static String transform(ServerPlayer p, float scale) {
		if (FORMS.containsKey(p.getUUID())) {
			resize(p, scale);
			return null;
		}
		if (TrialManager.inTrial(p)) return "Finish your trial first.";
		Form f = new Form(p.getUUID());
		Abilities ab = p.getAbilities();
		f.mayfly = ab.mayfly;
		f.flying = ab.flying;
		f.invulnerable = ab.invulnerable;
		f.flySpeed = ab.getFlyingSpeed();
		f.scale = scale;
		FORMS.put(p.getUUID(), f);
		ab.mayfly = true;
		ab.flying = true;
		ab.invulnerable = true;
		ab.setFlyingSpeed(ChaosConfig.get().eyeFlySpeed);
		p.onUpdateAbilities();
		p.addEffect(new MobEffectInstance(MobEffects.INVISIBILITY, -1, 0, false, false, false));
		p.addEffect(new MobEffectInstance(MobEffects.NIGHT_VISION, -1, 0, false, false, false));
		p.setDeltaMovement(p.getDeltaMovement().add(0, 0.6, 0));
		p.hurtMarked = true;
		spawnEye(p, f);
		hideEquipment(p, true);
		PlayerData pd = DataStore.get(p);
		pd.eyeActive = true;
		DataStore.markDirty();

		ServerLevel level = p.level();
		Vec3 c = eyeCenter(p, f);
		Fx.implode(level, Fx.dust(0x050505, 3f), c, 8, 200, 0.7);
		Fx.far(level, ParticleTypes.SQUID_INK, c, 120, 2, 0.15);
		Fx.far(level, ParticleTypes.SCULK_SOUL, c, 40, 1.5, 0.05);
		for (ServerPlayer other : p.level().getServer().getPlayerList().getPlayers()) {
			Fx.soundTo(other, Holder.direct(SoundEvents.WARDEN_EMERGE), SoundSource.HOSTILE, other == p ? 0.6f : 0.4f, 0.5f);
			Fx.customTo(other, "eye_open", SoundSource.HOSTILE, 1f, 1f);
		}
		Fx.sound(level, c, SoundEvents.WARDEN_ROAR, 4f, 0.5f);
		p.sendSystemMessage(Component.literal("You are the Eye. Fly freely, speak through chat, use /eye for your powers. /eye off to return.").withStyle(ChatFormatting.DARK_PURPLE));
		ChaosHearts.LOGGER.info("{} became the Eye", p.getName().getString());
		return null;
	}

	public static void revert(ServerPlayer p, boolean announce) {
		Form f = FORMS.remove(p.getUUID());
		if (f == null) return;
		if (f.eye != null) f.eye.discard();
		if (f.speech != null) f.speech.discard();
		Abilities ab = p.getAbilities();
		boolean keepsFlight = p.isCreative() || p.isSpectator();
		ab.mayfly = keepsFlight || f.mayfly;
		ab.flying = (keepsFlight || f.mayfly) && f.flying;
		ab.invulnerable = p.isCreative() || p.isSpectator() || f.invulnerable;
		ab.setFlyingSpeed(f.flySpeed > 0 ? f.flySpeed : 0.05f);
		p.onUpdateAbilities();
		p.removeEffect(MobEffects.INVISIBILITY);
		p.removeEffect(MobEffects.NIGHT_VISION);
		p.resetFallDistance();
		p.addEffect(new MobEffectInstance(MobEffects.SLOW_FALLING, 200, 0, false, false, true));
		hideEquipment(p, false);
		PlayerData pd = DataStore.get(p);
		pd.eyeActive = false;
		DataStore.markDirty();
		if (announce) {
			ServerLevel level = p.level();
			Vec3 c = p.position().add(0, 1, 0);
			Fx.far(level, ParticleTypes.SQUID_INK, c, 80, 1.5, 0.2);
			Fx.sound(level, c, SoundEvents.WARDEN_DIG, 2f, 0.6f);
			Fx.customTo(p, "eye_close", SoundSource.HOSTILE, 1f, 1f);
			p.sendSystemMessage(Component.literal("The Eye closes. You are yourself again.").withStyle(ChatFormatting.GRAY));
		}
		ChaosHearts.LOGGER.info("{} left the Eye form", p.getName().getString());
	}

	public static void revertAll(MinecraftServer server) {
		for (UUID id : new ArrayList<>(FORMS.keySet())) {
			ServerPlayer p = server.getPlayerList().getPlayer(id);
			if (p != null) revert(p, false);
			else FORMS.remove(id);
		}
	}

	private static void resize(ServerPlayer p, float scale) {
		Form f = FORMS.get(p.getUUID());
		if (f == null || f.eye == null) return;
		f.scale = scale;
		Displays.transform(f.eye, new Vector3f(), new Quaternionf(), new Vector3f(scale), 10);
		Fx.sound(p.level(), eyeCenter(p, f), SoundEvents.WARDEN_HEARTBEAT, 2f, 0.6f);
	}

	private static void spawnEye(ServerPlayer p, Form f) {
		ItemStack model = new ItemStack(Items.ENDER_EYE);
		model.set(DataComponents.CUSTOM_MODEL_DATA, new CustomModelData(List.of(), List.of(), List.of("chaoshearts:the_eye"), List.of()));
		f.eye = Displays.item(p.level(), eyeCenter(p, f), model, 0.1f, true);
		if (f.eye != null) {
			Displays.teleportDuration(f.eye, 2);
			Displays.transform(f.eye, new Vector3f(), new Quaternionf(), new Vector3f(f.scale), 20);
			((net.chaoshearts.mixin.DisplayAccessor) f.eye).chaoshearts$setViewRange(6f);
		}
	}

	private static Vec3 eyeCenter(ServerPlayer p, Form f) {
		return p.position().add(0, 0.9 + f.scale * 0.1, 0);
	}

	private static void hideEquipment(ServerPlayer p, boolean hide) {
		List<Pair<EquipmentSlot, ItemStack>> list = new ArrayList<>();
		for (EquipmentSlot slot : EquipmentSlot.values()) {
			if (slot.getType() == EquipmentSlot.Type.ANIMAL_ARMOR || slot == EquipmentSlot.SADDLE) continue;
			list.add(Pair.of(slot, hide ? ItemStack.EMPTY : p.getItemBySlot(slot).copy()));
		}
		p.level().getChunkSource().sendToTrackingPlayers(p, new ClientboundSetEquipmentPacket(p.getId(), list));
	}

	// ---------------------------------------------------------------- tick

	public static void tick(MinecraftServer server) {
		if (FORMS.isEmpty()) return;
		long t = ChaosHearts.tick();
		for (Form f : new ArrayList<>(FORMS.values())) {
			ServerPlayer p = server.getPlayerList().getPlayer(f.player);
			if (p == null) {
				FORMS.remove(f.player);
				if (f.eye != null) f.eye.discard();
				if (f.speech != null) f.speech.discard();
				continue;
			}
			tickForm(p, f, t);
		}
	}

	private static void tickForm(ServerPlayer p, Form f, long t) {
		ServerLevel level = p.level();
		Vec3 c = eyeCenter(p, f);
		if (f.eye == null || !f.eye.isAlive() || f.eye.level() != level) {
			if (f.eye != null) f.eye.discard();
			spawnEye(p, f);
		}
		float yaw = p.getYRot() + ChaosConfig.get().eyeModelYawOffset;
		float pitch = p.getXRot();
		ServerPlayer gaze = f.gazeTarget == null || t > f.gazeUntil ? null : level.getServer().getPlayerList().getPlayer(f.gazeTarget);
		if (gaze != null && gaze.level() == level) {
			float[] rot = net.chaoshearts.trial.Cinematic.lookAngles(c, gaze.getEyePosition());
			yaw = rot[0] + ChaosConfig.get().eyeModelYawOffset;
			pitch = rot[1];
		}
		Displays.move(f.eye, c, yaw, pitch);
		Abilities ab = p.getAbilities();
		if (!ab.mayfly || !ab.invulnerable) {
			ab.mayfly = true;
			ab.invulnerable = true;
			p.onUpdateAbilities();
		}
		if (!p.hasEffect(MobEffects.INVISIBILITY)) p.addEffect(new MobEffectInstance(MobEffects.INVISIBILITY, -1, 0, false, false, false));
		p.resetFallDistance();
		p.clearFire();

		// The shroud: tendrils of black smoke and ink circling the eye.
		double r = f.scale * 0.75;
		if (t % 2 == 0) {
			for (int k = 0; k < 3; k++) {
				double a = t * 0.12 + k * Math.PI * 2 / 3;
				double y = Math.sin(t * 0.07 + k) * r * 0.5;
				Vec3 at = c.add(Math.cos(a) * r, y, Math.sin(a) * r);
				Fx.at(level, Fx.dust(0x050505, 2.5f), at, 3, 0.25, 0);
				Fx.at(level, ParticleTypes.SQUID_INK, at, 1, 0.1, 0.01);
			}
			Fx.at(level, ParticleTypes.LARGE_SMOKE, c, 3, r * 0.6, 0.01);
		}
		if (t % 5 == 0) {
			Fx.at(level, Fx.dust(VOID_PURPLE, 1.6f), c, 8, r, 0);
			Fx.at(level, ParticleTypes.SMOKE, c.add(0, -r, 0), 6, r * 0.5, 0.02);
		}
		if (t % 10 == 0) Fx.at(level, Fx.dust(IRIS, 1f), c.add(p.getLookAngle().scale(f.scale * 0.5)), 4, 0.15, 0);
		if (t % 80 == 0) Fx.sound(level, c, SoundEvents.WARDEN_HEARTBEAT, 1.5f, 0.5f);
		if (t % 240 == 37) Fx.custom(level, c, "eye_ambient", 1.5f, 1f);

		double shroud = ChaosConfig.get().eyeShroudRadius;
		if (shroud > 0 && t % 20 == 0) {
			for (ServerPlayer other : level.players()) {
				if (other == p || other.isSpectator() || other.position().distanceTo(c) > shroud) continue;
				other.addEffect(new MobEffectInstance(MobEffects.DARKNESS, 50, 0, false, false, true));
			}
		}
		if (t % 10 == 0) hideEquipment(p, true);

		if (f.speech != null) {
			if (t > f.speechUntil) {
				f.speech.discard();
				f.speech = null;
			} else {
				Displays.move(f.speech, c.add(0, f.scale * 0.6 + 0.8, 0));
			}
		}
	}

	// ---------------------------------------------------------------- powers

	private static Component voice(String msg) {
		return Component.literal("👁 THE EYE").withStyle(ChatFormatting.DARK_PURPLE, ChatFormatting.BOLD)
				.append(Component.literal(" » ").withStyle(ChatFormatting.DARK_GRAY))
				.append(Component.literal(msg).withStyle(ChatFormatting.LIGHT_PURPLE, ChatFormatting.ITALIC));
	}

	/** Speaks to everyone. */
	public static void speak(ServerPlayer eye, String msg) {
		Component line = voice(msg);
		MinecraftServer server = eye.level().getServer();
		for (ServerPlayer p : server.getPlayerList().getPlayers()) {
			p.sendSystemMessage(line);
			Fx.soundTo(p, Holder.direct(SoundEvents.WARDEN_AMBIENT), SoundSource.HOSTILE, 0.5f, 0.5f);
			Fx.customTo(p, "eye_speak", SoundSource.HOSTILE, 0.9f, 1f);
		}
		bubble(eye, msg);
		ChaosHearts.LOGGER.info("[The Eye] {}", msg);
	}

	public static void whisper(ServerPlayer eye, ServerPlayer target, String msg) {
		target.sendSystemMessage(Component.literal("👁 the eye whispers to you: ").withStyle(ChatFormatting.DARK_PURPLE, ChatFormatting.ITALIC)
				.append(Component.literal(msg).withStyle(ChatFormatting.LIGHT_PURPLE, ChatFormatting.ITALIC)));
		Fx.title(target, Component.empty(), Component.literal(msg).withStyle(ChatFormatting.DARK_PURPLE, ChatFormatting.ITALIC), 10, 50, 20);
		Fx.soundTo(target, Holder.direct(SoundEvents.AMBIENT_CAVE.value()), SoundSource.HOSTILE, 1f, 0.6f);
		Fx.customTo(target, "eye_whisper", SoundSource.HOSTILE, 1f, 1f);
		eye.sendSystemMessage(Component.literal("You whisper to " + target.getName().getString() + ": " + msg).withStyle(ChatFormatting.DARK_GRAY, ChatFormatting.ITALIC));
	}

	public static void proclaim(ServerPlayer eye, Collection<ServerPlayer> targets, String msg) {
		for (ServerPlayer p : targets) {
			Fx.title(p, Component.literal("👁").withStyle(ChatFormatting.DARK_PURPLE), Component.literal(msg).withStyle(ChatFormatting.LIGHT_PURPLE), 10, 70, 20);
			Fx.soundTo(p, Holder.direct(SoundEvents.WARDEN_SONIC_CHARGE), SoundSource.HOSTILE, 0.6f, 0.5f);
		}
		speak(eye, msg);
	}

	private static void bubble(ServerPlayer eye, String msg) {
		Form f = FORMS.get(eye.getUUID());
		if (f == null) return;
		if (f.speech != null) f.speech.discard();
		f.speech = Displays.text(eye.level(), eyeCenter(eye, f).add(0, f.scale * 0.6 + 0.8, 0),
				Component.literal(msg).withStyle(ChatFormatting.LIGHT_PURPLE, ChatFormatting.ITALIC), 0x90000000, 1.4f);
		f.speechUntil = ChaosHearts.tick() + Math.min(200, 60 + msg.length() * 2L);
	}

	/** Turns the Eye towards a player and lets them feel it. */
	public static void gaze(ServerPlayer eye, ServerPlayer target) {
		Form f = FORMS.get(eye.getUUID());
		if (f == null) return;
		f.gazeTarget = target.getUUID();
		f.gazeUntil = ChaosHearts.tick() + 100;
		target.addEffect(new MobEffectInstance(MobEffects.DARKNESS, 120, 0, false, false, true));
		target.addEffect(new MobEffectInstance(MobEffects.GLOWING, 100, 0, false, false, true));
		Fx.title(target, Component.literal("👁").withStyle(ChatFormatting.DARK_RED, ChatFormatting.BOLD), Component.literal("The Eye sees you.").withStyle(ChatFormatting.DARK_PURPLE, ChatFormatting.ITALIC), 5, 50, 15);
		Fx.soundTo(target, Holder.direct(SoundEvents.WARDEN_HEARTBEAT), SoundSource.HOSTILE, 2f, 0.5f);
		Fx.customTo(target, "eye_gaze", SoundSource.HOSTILE, 1f, 1f);
		if (target.level() == eye.level()) Fx.line(eye.level(), Fx.dust(IRIS, 1f), eyeCenter(eye, f), target.getEyePosition(), 0.6);
	}

	/** A beam of light from the Eye to the player, then a new heart. */
	public static String give(ServerPlayer eye, ServerPlayer target, HeartType type) {
		if (TrialManager.inTrial(target)) return target.getName().getString() + " is in a trial.";
		Form f = FORMS.get(eye.getUUID());
		Vec3 from = f == null ? eye.getEyePosition() : eyeCenter(eye, f);
		beam(eye, from, target, type.color, () -> {
			HeartRecord rec = HeartManager.create(target, type, true);
			if (rec == null) return;
			Fx.title(target, Component.literal("👁").withStyle(ChatFormatting.DARK_PURPLE), Component.literal("The Eye grants you the ").withStyle(ChatFormatting.LIGHT_PURPLE).append(type.title()), 5, 60, 20);
			speak(eye, target.getName().getString() + ", take the " + type.displayName + " Heart. Do not waste it.");
		});
		return null;
	}

	/** Tears a heart out of the player. The heart is destroyed; the player's mastery is untouched. */
	public static String take(ServerPlayer eye, ServerPlayer target, HeartType typeOrNull) {
		if (TrialManager.inTrial(target)) return target.getName().getString() + " is in a trial.";
		HeartRecord rec;
		if (typeOrNull != null) {
			rec = ChaosCommands.heldRecord(target, typeOrNull);
		} else {
			PlayerData.OwnedHeart latest = DataStore.get(target).latest();
			rec = latest == null ? null : HeartManager.record(latest.heartId);
		}
		if (rec == null) return target.getName().getString() + " holds no such heart.";
		HeartType type = rec.type;
		Form f = FORMS.get(eye.getUUID());
		Vec3 to = f == null ? eye.getEyePosition() : eyeCenter(eye, f);
		ServerLevel level = target.level();
		target.addEffect(new MobEffectInstance(MobEffects.LEVITATION, 40, 0, false, false, true));
		Fx.soundTo(target, Holder.direct(SoundEvents.WARDEN_SONIC_CHARGE), SoundSource.HOSTILE, 1f, 0.7f);
		Scheduler.repeat(0, 2, 20, i -> {
			if (!target.isAlive()) return false;
			Vec3 src = target.position().add(0, 1.2, 0);
			if (target.level() == eye.level()) Fx.line(level, Fx.dust(type.color, 1.2f), src, src.lerp(to, i / 20.0), 0.5);
			Fx.implode(level, Fx.dust(type.color, 1.4f), src, 1.5, 10, -0.2);
			if (i == 19) {
				HeartRecord now = HeartManager.record(rec.id);
				if (now != null && now.state == HeartRecord.State.HELD && target.getUUID().equals(now.holder)) {
					HeartManager.destroy(now);
					Fx.sound(level, src, SoundEvents.WARDEN_SONIC_BOOM, 1.5f, 0.8f);
					Fx.far(level, Fx.dust(type.color, 3f), src, 80, 0.6, 0);
					Fx.title(target, Component.literal("💔").withStyle(ChatFormatting.DARK_RED), Component.literal("The Eye tore out your ").withStyle(ChatFormatting.GRAY).append(type.title()), 5, 60, 20);
					target.sendSystemMessage(Component.literal("The Eye took your ").withStyle(ChatFormatting.GRAY).append(type.title()).append(Component.literal(". Your mastery remains.").withStyle(ChatFormatting.GRAY)));
				}
			}
			return true;
		});
		return null;
	}

	private static void beam(ServerPlayer eye, Vec3 from, ServerPlayer target, int rgb, Runnable then) {
		ServerLevel level = eye.level();
		Fx.sound(level, from, SoundEvents.BEACON_POWER_SELECT, 2f, 0.6f);
		Scheduler.repeat(0, 2, 15, i -> {
			if (!target.isAlive()) return false;
			Vec3 to = target.position().add(0, 1.2, 0);
			if (target.level() == level) Fx.line(level, Fx.dust(rgb, 1.3f), from, from.lerp(to, (i + 1) / 15.0), 0.5);
			if (i == 14) {
				Fx.helix(target.level(), Fx.dust(rgb, 1.5f), target.position(), 1, 2.5, 3, 50, 0);
				then.run();
			}
			return true;
		});
	}

	// ---------------------------------------------------------------- events and commands

	public static void registerEvents() {
		ServerMessageEvents.ALLOW_CHAT_MESSAGE.register((message, sender, params) -> {
			if (!isEye(sender)) return true;
			String text = message.signedContent();
			sender.level().getServer().execute(() -> speak(sender, text));
			return false;
		});
		ServerPlayConnectionEvents.DISCONNECT.register((handler, server) -> revert(handler.player, false));
		ServerPlayConnectionEvents.JOIN.register((handler, sender, server) -> {
			PlayerData pd = DataStore.get(handler.player);
			if (pd.eyeActive) {
				// The form never survives a logout; make sure nothing is left switched on.
				pd.eyeActive = false;
				ServerPlayer p = handler.player;
				Abilities ab = p.getAbilities();
				if (!p.isCreative() && !p.isSpectator()) {
					ab.mayfly = false;
					ab.flying = false;
					ab.invulnerable = false;
					p.onUpdateAbilities();
				}
				p.removeEffect(MobEffects.INVISIBILITY);
				p.removeEffect(MobEffects.NIGHT_VISION);
				DataStore.markDirty();
			}
		});
	}

	private static ServerPlayer eye(CommandContext<CommandSourceStack> c) throws CommandSyntaxException {
		ServerPlayer p = c.getSource().getPlayerOrException();
		if (!isEye(p)) throw new com.mojang.brigadier.exceptions.SimpleCommandExceptionType(Component.literal("You are not the Eye. Use /eye first.")).create();
		return p;
	}

	private static int done(CommandContext<CommandSourceStack> c, String err) {
		if (err != null) {
			c.getSource().sendFailure(Component.literal(err));
			return 0;
		}
		return 1;
	}

	public static void registerCommands(CommandDispatcher<CommandSourceStack> d) {
		d.register(Commands.literal("eye").requires(Perms.require(Perms.ADMIN))
				.executes(c -> {
					ServerPlayer p = c.getSource().getPlayerOrException();
					if (isEye(p)) {
						revert(p, true);
						return 1;
					}
					return done(c, transform(p, (float) ChaosConfig.get().eyeDefaultScale));
				})
				.then(Commands.literal("on")
						.executes(c -> done(c, transform(c.getSource().getPlayerOrException(), (float) ChaosConfig.get().eyeDefaultScale)))
						.then(Commands.argument("scale", FloatArgumentType.floatArg(1f, 12f))
								.executes(c -> done(c, transform(c.getSource().getPlayerOrException(), FloatArgumentType.getFloat(c, "scale"))))))
				.then(Commands.literal("off").executes(c -> {
					ServerPlayer p = c.getSource().getPlayerOrException();
					if (!isEye(p)) return done(c, "You are not the Eye.");
					revert(p, true);
					return 1;
				}))
				.then(Commands.literal("size").then(Commands.argument("scale", FloatArgumentType.floatArg(1f, 12f)).executes(c -> {
					resize(eye(c), FloatArgumentType.getFloat(c, "scale"));
					return 1;
				})))
				.then(Commands.literal("say").then(Commands.argument("message", StringArgumentType.greedyString()).executes(c -> {
					speak(eye(c), StringArgumentType.getString(c, "message"));
					return 1;
				})))
				.then(Commands.literal("whisper").then(Commands.argument("player", EntityArgument.player()).then(Commands.argument("message", StringArgumentType.greedyString()).executes(c -> {
					whisper(eye(c), EntityArgument.getPlayer(c, "player"), StringArgumentType.getString(c, "message"));
					return 1;
				}))))
				.then(Commands.literal("proclaim").then(Commands.argument("message", StringArgumentType.greedyString()).executes(c -> {
					ServerPlayer e = eye(c);
					proclaim(e, e.level().getServer().getPlayerList().getPlayers(), StringArgumentType.getString(c, "message"));
					return 1;
				})))
				.then(Commands.literal("gaze").then(Commands.argument("player", EntityArgument.player()).executes(c -> {
					gaze(eye(c), EntityArgument.getPlayer(c, "player"));
					return 1;
				})))
				.then(Commands.literal("give").then(Commands.argument("player", EntityArgument.player()).then(ChaosCommands.heartArg("heart").executes(c ->
						done(c, give(eye(c), EntityArgument.getPlayer(c, "player"), ChaosCommands.heart(c, "heart")))))))
				.then(Commands.literal("take").then(Commands.argument("player", EntityArgument.player())
						.executes(c -> done(c, take(eye(c), EntityArgument.getPlayer(c, "player"), null)))
						.then(ChaosCommands.heartArg("heart").executes(c -> done(c, take(eye(c), EntityArgument.getPlayer(c, "player"), ChaosCommands.heart(c, "heart")))))))
				.then(Commands.literal("hearts").then(Commands.argument("player", EntityArgument.player()).executes(c -> {
					ServerPlayer target = EntityArgument.getPlayer(c, "player");
					PlayerData pd = DataStore.get(target);
					MutableComponent out = Component.literal("👁 " + target.getName().getString() + " carries: ").withStyle(ChatFormatting.DARK_PURPLE);
					if (pd.hearts.isEmpty()) out.append(Component.literal("nothing").withStyle(ChatFormatting.GRAY));
					for (PlayerData.OwnedHeart h : pd.hearts) out.append(h.type.label()).append(Component.literal(" "));
					c.getSource().sendSuccess(() -> out, false);
					return 1;
				}))));
	}
}
