# As a plague storm: falling spores, and every 8 ticks a telegraphed plague strike on a random enemy below.
scoreboard players add @s ch.t 1
scoreboard players remove @s ch.life 1
execute if score @s ch.life matches ..0 run return run kill @s
particle minecraft:falling_spore_blossom ~ ~-0.5 ~ 8 0.5 8 0 6
particle minecraft:dust{color:[0.239,0.102,0.322],scale:2.5} ~ ~ ~ 6 0.6 6 0 6
particle minecraft:dust{color:[0.482,0.82,0.227],scale:0.9} ~ ~-3 ~ 7 3 7 0 8
scoreboard players operation #ct ch.tmp = @s ch.t
scoreboard players operation #ct ch.tmp %= #8 ch.g
execute unless score #ct ch.tmp matches 0 run return 0
tag @a remove ch.caster
function ch:api/tag_owner
scoreboard players operation #cnec ch.tmp = @s ch.v6
execute positioned ~ ~-8 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..16,sort=random,limit=1] at @s run function ch:kit/corruption/pan/storm_mark
tag @a remove ch.caster
