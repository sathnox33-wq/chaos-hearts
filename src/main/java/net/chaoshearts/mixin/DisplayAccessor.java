package net.chaoshearts.mixin;

import com.mojang.math.Transformation;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.gen.Accessor;
import org.spongepowered.asm.mixin.gen.Invoker;

import net.minecraft.network.syncher.EntityDataAccessor;
import net.minecraft.util.Brightness;
import net.minecraft.world.entity.Display;

@Mixin(Display.class)
public interface DisplayAccessor {
	@Invoker("setTransformation")
	void chaoshearts$setTransformation(Transformation t);

	@Invoker("setTransformationInterpolationDuration")
	void chaoshearts$setInterpolationDuration(int ticks);

	@Invoker("setTransformationInterpolationDelay")
	void chaoshearts$setInterpolationDelay(int ticks);

	/** Vanilla has no setter for the teleport (position/rotation) interpolation duration. */
	@Accessor("DATA_POS_ROT_INTERPOLATION_DURATION_ID")
	static EntityDataAccessor<Integer> chaoshearts$posRotDuration() {
		throw new AssertionError();
	}

	@Invoker("setBillboardConstraints")
	void chaoshearts$setBillboard(Display.BillboardConstraints c);

	@Invoker("setBrightnessOverride")
	void chaoshearts$setBrightness(Brightness b);

	@Invoker("setViewRange")
	void chaoshearts$setViewRange(float range);

	@Invoker("setShadowRadius")
	void chaoshearts$setShadowRadius(float r);

	@Invoker("setGlowColorOverride")
	void chaoshearts$setGlowColor(int rgb);
}
