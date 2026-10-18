package net.chaoshearts;

import net.chaoshearts.ability.AbilityManager;
import net.chaoshearts.command.ChaosCommands;
import net.chaoshearts.config.ChaosConfig;
import net.chaoshearts.data.DataStore;
import net.chaoshearts.eye.EyeManager;
import net.chaoshearts.fx.Scheduler;
import net.chaoshearts.fx.TempBlocks;
import net.chaoshearts.heart.HeartManager;
import net.chaoshearts.pack.PackServer;
import net.chaoshearts.trial.TrialManager;
import net.fabricmc.api.ModInitializer;
import net.fabricmc.fabric.api.command.v2.CommandRegistrationCallback;
import net.fabricmc.fabric.api.event.lifecycle.v1.ServerLifecycleEvents;
import net.fabricmc.fabric.api.event.lifecycle.v1.ServerTickEvents;
import net.minecraft.resources.Identifier;
import net.minecraft.server.MinecraftServer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ChaosHearts implements ModInitializer {
	public static final String MOD_ID = "chaoshearts";
	public static final Logger LOGGER = LoggerFactory.getLogger(MOD_ID);

	private static MinecraftServer server;
	private static long tick;

	public static Identifier id(String path) {
		return Identifier.fromNamespaceAndPath(MOD_ID, path);
	}

	public static MinecraftServer server() {
		return server;
	}

	/** Server ticks since this server started. */
	public static long tick() {
		return tick;
	}

	@Override
	public void onInitialize() {
		ChaosConfig.load();

		ServerLifecycleEvents.SERVER_STARTING.register(s -> {
			server = s;
			tick = 0;
		});
		ServerLifecycleEvents.SERVER_STARTED.register(s -> {
			DataStore.load(s);
			TempBlocks.cleanupFromSave(s);
			TrialManager.onServerStarted(s);
			PackServer.start(s);
		});
		ServerLifecycleEvents.SERVER_STOPPING.register(s -> {
			EyeManager.revertAll(s);
			TrialManager.onServerStopping(s);
			AbilityManager.onServerStopping(s);
			TempBlocks.restoreAll(s);
			Scheduler.clear();
			DataStore.save();
			PackServer.stop();
		});
		ServerLifecycleEvents.SERVER_STOPPED.register(s -> {
			DataStore.unload();
			server = null;
		});

		ServerTickEvents.END_SERVER_TICK.register(s -> {
			tick++;
			Scheduler.tick();
			TempBlocks.tick(s);
			HeartManager.tick(s);
			AbilityManager.tick(s);
			TrialManager.tick(s);
			EyeManager.tick(s);
			DataStore.autosave(tick);
		});

		net.chaoshearts.fx.Displays.registerEvents();
		HeartManager.registerEvents();
		AbilityManager.registerEvents();
		TrialManager.registerEvents();
		EyeManager.registerEvents();
		CommandRegistrationCallback.EVENT.register(ChaosCommands::register);

		LOGGER.info("Chaos Hearts loaded");
	}
}
