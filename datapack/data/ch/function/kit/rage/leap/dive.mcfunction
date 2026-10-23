# The meteor dive: a downward wind burst just above the head.
effect clear @s minecraft:slow_falling
execute rotated 0 90 run function ch:api/vec {s:2.2}
execute positioned ~ ~2.5 ~ summon minecraft:wind_charge run function ch:api/motion
execute rotated 0 90 run function ch:api/fx/beam {color:14689835,w:0.6,len:6.0,t:2,life:6}
particle minecraft:flame ~ ~1 ~ 0.3 0.6 0.3 0.1 20
playsound minecraft:item.mace.smash_air player @a ~ ~ ~ 1.2 0.5
playsound minecraft:entity.ravager.roar player @a ~ ~ ~ 0.8 0.8
