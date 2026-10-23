# Level: drift forward slowly, dragging everything within 5 blocks.
execute if block ^ ^ ^0.45 #ch:passable run tp @s ^ ^ ^0.45
execute at @s as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..5,limit=12] run function ch:kit/void/orb/grab
execute if score #vt ch.tmp matches 0 at @s run function ch:kit/void/orb/sting
execute at @s run function ch:kit/void/orb/fx
