package net.chaoshearts.mixin;

import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.gen.Accessor;
import org.spongepowered.asm.mixin.gen.Invoker;

import net.minecraft.network.chat.Component;
import net.minecraft.network.syncher.EntityDataAccessor;
import net.minecraft.world.entity.Display;

@Mixin(Display.TextDisplay.class)
public interface TextDisplayAccessor {
	@Invoker("setText")
	void chaoshearts$setText(Component text);

	@Accessor("DATA_BACKGROUND_COLOR_ID")
	static EntityDataAccessor<Integer> chaoshearts$backgroundId() {
		throw new AssertionError();
	}

	@Accessor("DATA_LINE_WIDTH_ID")
	static EntityDataAccessor<Integer> chaoshearts$lineWidthId() {
		throw new AssertionError();
	}

	@Invoker("setFlags")
	void chaoshearts$setFlags(byte flags);
}
