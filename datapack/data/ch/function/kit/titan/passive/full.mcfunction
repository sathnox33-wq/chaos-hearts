# Tremor reached 100: the next Ground Slam will be a Cataclysm.
scoreboard players set @s ch.titan.full 1
function ch:core/msg/say {m:"Tremor full: your next Ground Slam is a CATACLYSM",c:"#FF7A2A"}
playsound minecraft:block.respawn_anchor.charge player @s ~ ~ ~ 0.8 0.6
playsound chaoshearts:titan_quake player @s ~ ~ ~ 0.4 1.6
particle minecraft:lava ~ ~0.3 ~ 0.4 0.1 0.4 0 6
