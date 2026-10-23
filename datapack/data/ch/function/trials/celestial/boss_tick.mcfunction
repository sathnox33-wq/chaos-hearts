# Astrael's mind, every tick: decorations, falling stars, the locked beam, the shield, and its attack patterns.
tag @s add ch.caster
scoreboard players add @s ch.t 1
function ch:trials/celestial/deco
execute if score #t20 ch.g matches 0..19 run particle minecraft:end_rod ~ ~1.2 ~ 0.6 0.8 0.6 0.02 1
execute as @e[type=item_display,tag=ch.celestial.tdrop,distance=..80] if score @s ch.t < #now ch.g at @s run function ch:trials/celestial/drop_go
execute if entity @e[type=marker,tag=ch.celestial.tbeam,distance=..80,limit=1] as @e[type=marker,tag=ch.celestial.tbeam,distance=..80] at @s run function ch:trials/celestial/beam_tick
execute if score @s ch.v4 matches 1.. run function ch:trials/celestial/shield_tick
execute if score @s ch.celestial.tb3 matches 1.. run function ch:trials/celestial/nova_tick
execute if score @s ch.v6 matches 1.. run function ch:trials/celestial/lock_tick
execute unless score @s ch.v6 matches 1.. unless score @s ch.celestial.tb3 matches 1.. run function ch:trials/celestial/patterns
tag @s remove ch.caster
