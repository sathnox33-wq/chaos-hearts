package net.chaoshearts.mixin;

import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.gen.Invoker;

import net.minecraft.world.entity.Display;
import net.minecraft.world.item.ItemDisplayContext;
import net.minecraft.world.item.ItemStack;

@Mixin(Display.ItemDisplay.class)
public interface ItemDisplayAccessor {
	@Invoker("setItemStack")
	void chaoshearts$setItem(ItemStack stack);

	@Invoker("setItemTransform")
	void chaoshearts$setItemTransform(ItemDisplayContext ctx);
}
