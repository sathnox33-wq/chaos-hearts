package net.chaoshearts.ability;

import java.util.EnumMap;
import java.util.Map;

import net.chaoshearts.ability.hearts.BloodKit;
import net.chaoshearts.ability.hearts.CelestialKit;
import net.chaoshearts.ability.hearts.CorruptionKit;
import net.chaoshearts.ability.hearts.FrozenKit;
import net.chaoshearts.ability.hearts.InfernalKit;
import net.chaoshearts.ability.hearts.RageKit;
import net.chaoshearts.ability.hearts.SpeedKit;
import net.chaoshearts.ability.hearts.StormKit;
import net.chaoshearts.ability.hearts.TitanKit;
import net.chaoshearts.ability.hearts.VoidKit;
import net.chaoshearts.heart.HeartType;

public final class HeartKits {
	private static final Map<HeartType, HeartKit> KITS = new EnumMap<>(HeartType.class);

	static {
		register(new RageKit());
		register(new SpeedKit());
		register(new InfernalKit());
		register(new VoidKit());
		register(new FrozenKit());
		register(new StormKit());
		register(new BloodKit());
		register(new TitanKit());
		register(new CelestialKit());
		register(new CorruptionKit());
	}

	private HeartKits() {}

	private static void register(HeartKit kit) {
		KITS.put(kit.type, kit);
	}

	public static HeartKit get(HeartType type) {
		return type == null ? null : KITS.get(type);
	}
}
