# Seeking fireball flight: a gentle turn toward the challenger.
particle minecraft:flame ~ ~ ~ 0.15 0.15 0.15 0.02 4
particle minecraft:large_smoke ~ ~ ~ 0.1 0.1 0.1 0.01 1
execute positioned ^ ^ ^3 facing entity @a[tag=ch.challenger,distance=..90,limit=1,sort=nearest] eyes positioned ^ ^ ^0.7 run summon minecraft:marker ~ ~ ~ {Tags:["ch.infernal.aim","ch.noability"]}
execute facing entity @e[type=marker,tag=ch.infernal.aim,limit=1,sort=nearest] feet run tp @s ~ ~ ~ ~ ~
kill @e[type=marker,tag=ch.infernal.aim]
