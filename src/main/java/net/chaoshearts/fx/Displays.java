package net.chaoshearts.fx;

import org.joml.Quaternionf;
import org.joml.Vector3f;

import com.mojang.math.Transformation;

import net.chaoshearts.mixin.BlockDisplayAccessor;
import net.chaoshearts.mixin.DisplayAccessor;
import net.chaoshearts.mixin.ItemDisplayAccessor;
import net.chaoshearts.mixin.TextDisplayAccessor;
import net.minecraft.network.chat.Component;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.util.Brightness;
import net.minecraft.world.entity.Display;
import net.minecraft.world.entity.EntitySpawnReason;
import net.minecraft.world.entity.EntityType;
import net.minecraft.world.item.ItemDisplayContext;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.level.block.state.BlockState;
import net.minecraft.world.phys.Vec3;

/** Spawns and animates display entities for projectiles, boulders, the Eye and set dressing. */
public final class Displays {
	/** Every display the mod spawns carries this tag so leftovers can be cleaned up. */
	public static final String TAG = "chaoshearts.fx";

	private static final java.util.Set<java.util.UUID> LIVE = new java.util.HashSet<>();

	private Displays() {}

	/** Leftover displays from a crash or an unloaded chunk are removed when they load. */
	public static void registerEvents() {
		net.fabricmc.fabric.api.event.lifecycle.v1.ServerEntityEvents.ENTITY_LOAD.register((e, level) -> {
			if (e.getTags().contains(TAG) && !LIVE.contains(e.getUUID())) {
				net.chaoshearts.ChaosHearts.server().execute(e::discard);
			}
		});
		net.fabricmc.fabric.api.event.lifecycle.v1.ServerEntityEvents.ENTITY_UNLOAD.register((e, level) -> {
			if (e.isRemoved() && e.getRemovalReason() != null && e.getRemovalReason().shouldDestroy()) LIVE.remove(e.getUUID());
		});
	}

	/** Marks a temporary entity (decoy, minion) so it survives loading now but is removed if found after a restart. */
	public static void track(net.minecraft.world.entity.Entity e) {
		e.addTag(TAG);
		LIVE.add(e.getUUID());
	}

	public static Display.ItemDisplay item(ServerLevel level, Vec3 pos, ItemStack stack, float scale, boolean fullBright) {
		Display.ItemDisplay d = EntityType.ITEM_DISPLAY.create(level, EntitySpawnReason.COMMAND);
		if (d == null) return null;
		d.setPos(pos.x, pos.y, pos.z);
		((ItemDisplayAccessor) d).chaoshearts$setItem(stack);
		((ItemDisplayAccessor) d).chaoshearts$setItemTransform(ItemDisplayContext.FIXED);
		setup(d, scale, fullBright);
		level.addFreshEntity(d);
		return d;
	}

	public static Display.BlockDisplay block(ServerLevel level, Vec3 pos, BlockState state, float scale, boolean fullBright) {
		Display.BlockDisplay d = EntityType.BLOCK_DISPLAY.create(level, EntitySpawnReason.COMMAND);
		if (d == null) return null;
		d.setPos(pos.x, pos.y, pos.z);
		((BlockDisplayAccessor) d).chaoshearts$setBlock(state);
		DisplayAccessor a = (DisplayAccessor) d;
		d.addTag(TAG);
		LIVE.add(d.getUUID());
		d.getEntityData().set(DisplayAccessor.chaoshearts$posRotDuration(), 2);
		a.chaoshearts$setViewRange(2.0f);
		if (fullBright) a.chaoshearts$setBrightness(new Brightness(15, 15));
		// Block displays are anchored at a corner: centre them.
		transform(d, new Vector3f(-scale / 2, -scale / 2, -scale / 2), new Quaternionf(), new Vector3f(scale), 0);
		level.addFreshEntity(d);
		return d;
	}

	public static Display.TextDisplay text(ServerLevel level, Vec3 pos, Component text, int background, float scale) {
		Display.TextDisplay d = EntityType.TEXT_DISPLAY.create(level, EntitySpawnReason.COMMAND);
		if (d == null) return null;
		d.setPos(pos.x, pos.y, pos.z);
		TextDisplayAccessor t = (TextDisplayAccessor) d;
		t.chaoshearts$setText(text);
		d.getEntityData().set(TextDisplayAccessor.chaoshearts$backgroundId(), background);
		d.getEntityData().set(TextDisplayAccessor.chaoshearts$lineWidthId(), 220);
		setup(d, scale, true);
		((DisplayAccessor) d).chaoshearts$setBillboard(Display.BillboardConstraints.CENTER);
		level.addFreshEntity(d);
		return d;
	}

	private static void setup(Display d, float scale, boolean fullBright) {
		DisplayAccessor a = (DisplayAccessor) d;
		d.addTag(TAG);
		LIVE.add(d.getUUID());
		d.getEntityData().set(DisplayAccessor.chaoshearts$posRotDuration(), 2);
		a.chaoshearts$setViewRange(2.0f);
		if (fullBright) a.chaoshearts$setBrightness(new Brightness(15, 15));
		transform(d, new Vector3f(), new Quaternionf(), new Vector3f(scale), 0);
	}

	public static void transform(Display d, Vector3f translation, Quaternionf rotation, Vector3f scale, int interpolationTicks) {
		DisplayAccessor a = (DisplayAccessor) d;
		a.chaoshearts$setTransformation(new Transformation(translation, rotation, scale, new Quaternionf()));
		a.chaoshearts$setInterpolationDelay(0);
		a.chaoshearts$setInterpolationDuration(interpolationTicks);
	}

	public static void billboard(Display d, Display.BillboardConstraints c) {
		((DisplayAccessor) d).chaoshearts$setBillboard(c);
	}

	public static void glow(Display d, int rgb) {
		d.setGlowingTag(true);
		((DisplayAccessor) d).chaoshearts$setGlowColor(rgb);
	}

	public static void teleportDuration(Display d, int ticks) {
		d.getEntityData().set(DisplayAccessor.chaoshearts$posRotDuration(), Math.max(0, Math.min(59, ticks)));
	}

	public static void setText(Display.TextDisplay d, Component text) {
		((TextDisplayAccessor) d).chaoshearts$setText(text);
	}

	public static void setItem(Display.ItemDisplay d, ItemStack stack) {
		((ItemDisplayAccessor) d).chaoshearts$setItem(stack);
	}

	/** Moves a display smoothly (clients interpolate over the teleport duration). */
	public static void move(Display d, Vec3 pos) {
		d.snapTo(pos.x, pos.y, pos.z, d.getYRot(), d.getXRot());
	}

	public static void move(Display d, Vec3 pos, float yaw, float pitch) {
		d.snapTo(pos.x, pos.y, pos.z, yaw, pitch);
	}
}
