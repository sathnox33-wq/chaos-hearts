package net.chaoshearts.mixin;

import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfoReturnable;

import net.chaoshearts.heart.HeartItems;
import net.minecraft.world.Container;
import net.minecraft.world.entity.item.ItemEntity;
import net.minecraft.world.level.block.entity.HopperBlockEntity;

/** Hoppers and hopper minecarts cannot swallow heart tokens. */
@Mixin(HopperBlockEntity.class)
public abstract class HopperBlockEntityMixin {
	@Inject(method = "addItem(Lnet/minecraft/world/Container;Lnet/minecraft/world/entity/item/ItemEntity;)Z", at = @At("HEAD"), cancellable = true)
	private static void chaoshearts$noHearts(Container container, ItemEntity item, CallbackInfoReturnable<Boolean> cir) {
		if (HeartItems.isToken(item.getItem())) cir.setReturnValue(false);
	}
}
