# Banner pulse: the owner and players not fighting them regenerate; mobs and the owner's opponents are weakened.
scoreboard players operation #me ch.tmp = @s ch.owner
function ch:api/fx/ring {p:"minecraft:dust{color:[1.0,0.69,0.13],scale:1.0}",r:5}
particle minecraft:dust{color:[0.88,0.15,0.17],scale:1.4} ~ ~1.5 ~ 0.1 1.5 0.1 0 8
tag @a remove ch.caster
function ch:api/tag_owner
execute as @a[distance=..5,gamemode=!spectator] unless score @s ch.opp = #me ch.tmp run effect give @s minecraft:regeneration 2 0 true
execute as @a[distance=..5,gamemode=!spectator,tag=!ch.caster] if score @s ch.opp = #me ch.tmp run function ch:api/cc {effect:"minecraft:weakness",sec:2,amp:0}
execute as @e[type=!#ch:ignore,type=!player,tag=!ch.noability,distance=..5] run function ch:api/cc {effect:"minecraft:weakness",sec:2,amp:0}
tag @a remove ch.caster
