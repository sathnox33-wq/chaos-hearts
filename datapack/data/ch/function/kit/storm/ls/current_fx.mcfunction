# The current's head: crackle and a hit on anything within 1.6 blocks (once per current).
particle minecraft:electric_spark ~ ~0.3 ~ 0.3 0.2 0.3 0.2 12
particle minecraft:dust{color:[0.31,0.66,1.0],scale:1.3} ~ ~0.15 ~ 0.3 0.05 0.3 0 6
particle minecraft:end_rod ~ ~0.5 ~ 0.1 0.3 0.1 0.02 2
execute positioned ~ ~0.05 ~ rotated as @s run function ch:api/fx/sprite {model:"bolt",color:15267583,s0:0.4,s1:1.6,t:2,life:8,spin:30,dy:0.0}
execute positioned ~ ~0.03 ~ rotated as @s run function ch:api/fx/sprite {model:"crack",color:2842040,s0:0.3,s1:1.4,t:2,life:24,spin:10,dy:0.0}
execute if score #t2 ch.storm.g matches 0 run playsound minecraft:block.copper_bulb.turn_on player @a ~ ~ ~ 0.8 1.6
function ch:api/tag_owner
scoreboard players operation #cc ch.storm.g = @s ch.v2
scoreboard players operation #d ch.storm.g = @s ch.v1
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..1.8] unless score @s ch.storm.hitc = #cc ch.storm.g at @s run function ch:kit/storm/ls/current_hit
tag @a remove ch.caster
