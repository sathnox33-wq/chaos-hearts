# The host tore the tether: the infection bursts now, weaker.
tag @s remove ch.corruption.fl
scoreboard players set @s ch.v1 0
scoreboard players operation @s ch.v4 *= #2 ch.g
scoreboard players operation @s ch.v4 /= #3 ch.corruption.k
playsound minecraft:entity.leash_knot.break player @a ~ ~ ~ 1 0.5
