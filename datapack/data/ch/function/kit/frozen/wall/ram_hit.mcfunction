# The ram's front: hits each enemy once (6 damage, heavy slow) and drives them along.
scoreboard players set #f_dmg ch.tmp 60
execute positioned ^ ^0.8 ^0.6 as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..1.5,tag=!ch.frozen.rh] at @s run function ch:kit/frozen/wall/ram_one
execute positioned ^ ^0.8 ^-0.8 as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,type=!player,distance=..2.2] run function ch:api/push {s:0.75,y:0.15}
scoreboard players operation #f_p ch.tmp = @s ch.life
scoreboard players operation #f_p ch.tmp %= #4 ch.g
execute if score #f_p ch.tmp matches 0 positioned ^ ^0.8 ^-0.8 as @a[distance=..2.2,tag=!ch.caster] run function ch:api/push {s:0.75,y:0.15}
