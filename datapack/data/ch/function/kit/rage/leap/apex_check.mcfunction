# Skyfall / Wrathfall: at the top of the climb, hang in the air and mark the impact.
execute store result score #vy ch.tmp run data get entity @s Motion[1] 100
execute if score #vy ch.tmp matches 6.. run return 0
scoreboard players set @s ch.rage.lap 1
scoreboard players set @s ch.rage.hang 9
effect give @s minecraft:slow_falling 1 0 true
execute store result score @s ch.rage.ly run data get entity @s Pos[1] 10
scoreboard players set #sd ch.tmp 40
function ch:kit/rage/leap/seek_big
particle minecraft:explosion ~ ~1 ~ 0 0 0 0 1
playsound minecraft:entity.warden.sonic_charge player @a ~ ~ ~ 1.4 1.3
playsound chaoshearts:trial_telegraph player @a ~ ~ ~ 1 1.3
