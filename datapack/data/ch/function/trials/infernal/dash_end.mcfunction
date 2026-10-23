# The charge ends in a burst.
particle minecraft:explosion ~ ~1 ~ 0.5 0.5 0.5 0 4
particle minecraft:flame ~ ~1 ~ 1 0.6 1 0.1 40
execute rotated 0 0 run function ch:api/fx/wave {color:16742938,r:3.5,t:5}
playsound minecraft:entity.generic.explode master @a[distance=..60] ~ ~ ~ 1 1.2
tag @a[tag=ch.infernal.dh] remove ch.infernal.dh
kill @s
