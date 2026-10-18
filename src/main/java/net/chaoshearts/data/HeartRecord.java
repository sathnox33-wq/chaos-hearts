package net.chaoshearts.data;

import java.util.UUID;

import net.chaoshearts.heart.HeartType;

/** One physical Chaos Heart. Exactly one state at a time. */
public final class HeartRecord {
	public enum State { HELD, DROPPED }

	public UUID id;
	public HeartType type;
	public State state;
	public long createdAt;

	/** HELD: who has it. */
	public UUID holder;

	/** DROPPED: the item entity, where it is, who may take it and who gets it back. */
	public UUID entity;
	public String dimension;
	public double x, y, z;
	public UUID collector;
	public UUID previousOwner;
	public long expiresAt;
}
