package net.chaoshearts.pack;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.security.MessageDigest;
import java.util.HexFormat;
import java.util.Optional;
import java.util.UUID;
import java.util.concurrent.Executors;

import com.sun.net.httpserver.HttpServer;

import net.chaoshearts.ChaosHearts;
import net.chaoshearts.config.ChaosConfig;
import net.fabricmc.fabric.api.networking.v1.ServerPlayConnectionEvents;
import net.minecraft.network.chat.Component;
import net.minecraft.network.protocol.common.ClientboundResourcePackPushPacket;
import net.minecraft.server.MinecraftServer;
import net.minecraft.server.level.ServerPlayer;

/**
 * Offers the Chaos Hearts resource pack (models, textures, sounds) to players when they join.
 * Either hosts the copy bundled in the jar on a small HTTP server, or points at an external URL.
 * Vanilla clients that decline the pack still play normally with vanilla visuals.
 */
public final class PackServer {
	private static final String RESOURCE = "/chaoshearts_pack/chaoshearts-resourcepack.zip";
	private static HttpServer http;
	private static byte[] pack;
	private static String url;
	private static String sha1;
	private static boolean registered;

	private PackServer() {}

	public static void start(MinecraftServer server) {
		if (!registered) {
			registered = true;
			ServerPlayConnectionEvents.JOIN.register((handler, sender, s) -> offer(handler.player));
		}
		var cfg = ChaosConfig.get();
		url = null;
		sha1 = null;
		if (!cfg.packExternalUrl.isBlank()) {
			url = cfg.packExternalUrl.trim();
			sha1 = cfg.packExternalSha1.trim().toLowerCase();
			if (sha1.length() != 40) ChaosHearts.LOGGER.warn("packExternalSha1 should be the 40 character SHA-1 of the pack; clients may re-download it every time.");
			ChaosHearts.LOGGER.info("Offering the Chaos Hearts resource pack from {}", url);
			return;
		}
		if (!cfg.packServeBuiltin) return;
		try (InputStream in = PackServer.class.getResourceAsStream(RESOURCE)) {
			if (in == null) {
				ChaosHearts.LOGGER.error("The bundled resource pack is missing from the jar");
				return;
			}
			pack = in.readAllBytes();
			sha1 = HexFormat.of().formatHex(MessageDigest.getInstance("SHA-1").digest(pack));
		} catch (Exception e) {
			ChaosHearts.LOGGER.error("Could not read the bundled resource pack", e);
			return;
		}
		try {
			http = HttpServer.create(new InetSocketAddress(cfg.packPort), 16);
			http.createContext("/pack.zip", ex -> {
				try (ex) {
					if (!"GET".equalsIgnoreCase(ex.getRequestMethod()) && !"HEAD".equalsIgnoreCase(ex.getRequestMethod())) {
						ex.sendResponseHeaders(405, -1);
						return;
					}
					ex.getResponseHeaders().add("Content-Type", "application/zip");
					ex.getResponseHeaders().add("Cache-Control", "no-cache");
					boolean head = "HEAD".equalsIgnoreCase(ex.getRequestMethod());
					ex.sendResponseHeaders(200, head ? -1 : pack.length);
					if (!head) {
						try (OutputStream out = ex.getResponseBody()) {
							out.write(pack);
						}
					}
				} catch (IOException ignored) {
					// Client went away.
				}
			});
			http.setExecutor(Executors.newFixedThreadPool(2, r -> {
				Thread t = new Thread(r, "ChaosHearts-PackServer");
				t.setDaemon(true);
				return t;
			}));
			http.start();
		} catch (IOException e) {
			ChaosHearts.LOGGER.error("Could not start the resource pack server on port {}", cfg.packPort, e);
			http = null;
			return;
		}
		String host = cfg.packPublicUrl.isBlank() ? null : cfg.packPublicUrl.trim();
		if (host == null) {
			String ip = server.getLocalIp();
			host = "http://" + (ip == null || ip.isBlank() ? "localhost" : ip) + ":" + cfg.packPort + "/pack.zip";
			ChaosHearts.LOGGER.warn("packPublicUrl is not set; offering {}. Set it to an address your players can reach.", host);
		}
		url = host;
		ChaosHearts.LOGGER.info("Hosting the Chaos Hearts resource pack ({} KB, sha1 {}) at {}", pack.length / 1024, sha1, url);
	}

	public static void stop() {
		if (http != null) {
			http.stop(0);
			http = null;
		}
		pack = null;
	}

	public static void offer(ServerPlayer p) {
		if (url == null) return;
		UUID id = UUID.nameUUIDFromBytes(("chaoshearts:" + (sha1 == null ? url : sha1)).getBytes(java.nio.charset.StandardCharsets.UTF_8));
		boolean required = ChaosConfig.get().packRequired;
		Component prompt = Component.literal("Chaos Hearts uses a resource pack for its hearts, effects and sounds.");
		p.connection.send(new ClientboundResourcePackPushPacket(id, url, sha1 == null ? "" : sha1, required, Optional.of(prompt)));
	}
}
