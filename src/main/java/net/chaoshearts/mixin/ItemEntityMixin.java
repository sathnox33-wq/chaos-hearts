package net.chaoshearts.mixin;

import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfo;

import net.chaoshearts.heart.HeartItems;
import net.chaoshearts.heart.HeartManager;
import net.minecraft.world.entity.item.ItemEntity;
import net.minecraft.world.entity.player.Player;

/** Heart tokens never enter an inventory; touching one hands the heart over through the registry. */
@Mixin(ItemEntity.class)
public abstract class ItemEntityMixin {
	@Inject(method = "playerTouch", at = @At("HEAD"), cancellable = true)
	private void chaoshearts$touch(Player player, CallbackInfo ci) {
		ItemEntity self = (ItemEntity) (Object) this;
		if (player.level().isClientSide()) return;
		if (HeartItems.isToken(self.getItem())) {
			HeartManager.onTouch(self, player);
			ci.cancel();
		}
	}
}
