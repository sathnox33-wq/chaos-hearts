# Up: race ahead for 10 ticks, then anchor and lift everything within 5.5 blocks up into it.
execute if score @s ch.t matches ..10 if block ^ ^ ^1.1 #ch:passable run tp @s ^ ^ ^1.1
execute if score @s ch.t matches ..10 at @s run particle minecraft:dust{color:[0.541,0.235,1.0],scale:1.6} ~ ~ ~ 0.1 0.1 0.1 0 4
execute if score @s ch.t matches 11 at @s run function ch:kit/void/orb/anchor
execute if score @s ch.t matches 11.. at @s as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..5.5,limit=12] run function ch:kit/void/orb/grab
execute if score @s ch.t matches 11.. if score #vt ch.tmp matches 0 at @s run function ch:kit/void/orb/sting
execute at @s run function ch:kit/void/orb/fx
execute if score @s ch.life matches 15 at @s run function ch:kit/void/orb/warn
