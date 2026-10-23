# As a projectile hitting the wind wall (not the owner's): it is turned around.
execute on origin if score @s ch.pid = #pid ch.storm.g run return 0
tag @s add ch.storm.defl
execute store result entity @s Motion[0] double -0.0012 run data get entity @s Motion[0] 1000
execute store result entity @s Motion[1] double 0.0006 run data get entity @s Motion[1] 1000
execute store result entity @s Motion[2] double -0.0012 run data get entity @s Motion[2] 1000
particle minecraft:small_gust ~ ~ ~ 0.1 0.1 0.1 0 2
playsound minecraft:entity.breeze.deflect player @a ~ ~ ~ 1 1.2
