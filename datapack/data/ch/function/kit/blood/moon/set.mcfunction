# The Blood Moon sets.
scoreboard players set @s ch.blood.moon 0
execute as @e[tag=ch.blood.moonv,distance=..80] if score @s ch.owner = #me ch.tmp run function ch:kit/blood/moon/set_one
playsound minecraft:entity.wither.death player @s ~ ~ ~ 0.3 1.8
