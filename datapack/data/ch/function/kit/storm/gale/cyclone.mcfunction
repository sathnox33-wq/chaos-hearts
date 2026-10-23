# A cyclone, every tick: spin and lift for 1.5 seconds, then fling.
scoreboard players remove @s ch.life 1
execute if score #t2 ch.storm.g matches 0 run function ch:kit/storm/gale/cyclone_fx
function ch:api/tag_owner
execute if score @s ch.life matches 11.. as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..7.5] at @s run function ch:kit/storm/gale/spin
execute if score @s ch.life matches 10 run function ch:kit/storm/gale/fling
tag @a remove ch.caster
execute if score @s ch.life matches ..0 run kill @s
