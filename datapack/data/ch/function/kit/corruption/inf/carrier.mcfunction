# Carrier: the infection jumps from the burst to the nearest enemy that is not already a host.
scoreboard players add #cgen ch.tmp 1
tag @e[tag=ch.corruption.jt] remove ch.corruption.jt
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,tag=!ch.corruption.host,tag=!ch.corruption.hcur,distance=..8,sort=nearest,limit=1] run tag @s add ch.corruption.jt
execute unless entity @e[tag=ch.corruption.jt,limit=1] run return 0
execute positioned ~ ~1 ~ facing entity @e[tag=ch.corruption.jt,limit=1] eyes run function ch:kit/corruption/inf/jline
execute as @e[tag=ch.corruption.jt,limit=1] at @s run function ch:kit/corruption/inf/plant
tag @e[tag=ch.corruption.jt] remove ch.corruption.jt
scoreboard players remove #cgen ch.tmp 1
