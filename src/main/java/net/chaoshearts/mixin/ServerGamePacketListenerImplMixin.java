package net.chaoshearts.mixin;

import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.Shadow;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfo;

import net.chaoshearts.ability.AbilityManager;
import net.minecraft.network.protocol.game.ServerboundPlayerActionPacket;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.server.network.ServerGamePacketListenerImpl;

/** The swap-hands key casts abilities while the Focus is in the main hand. */
@Mixin(ServerGamePacketListenerImpl.class)
public abstract class ServerGamePacketListenerImplMixin {
	@Shadow
	public ServerPlayer player;

	@Inject(method = "handlePlayerAction", at = @At("HEAD"), cancellable = true)
	private void chaoshearts$swapHands(ServerboundPlayerActionPacket packet, CallbackInfo ci) {
		// The handler first runs on the network thread and reschedules itself; act only on the server thread.
		if (!player.level().getServer().isSameThread()) return;
		if (packet.getAction() == ServerboundPlayerActionPacket.Action.SWAP_ITEM_WITH_OFFHAND && AbilityManager.onSwapHands(player)) {
			ci.cancel();
		}
	}
}
