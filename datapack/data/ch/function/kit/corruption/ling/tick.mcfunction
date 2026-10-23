# As a rotling: lives out its time, hunts the nearest hostile (or a player when PvP is on), bites, follows its master.
scoreboard players remove @s ch.life 1
execute if score @s ch.v1 matches 1.. run scoreboard players remove @s ch.v1 1
execute if score @s ch.life matches ..0 run return run function ch:kit/corruption/ling/expire
scoreboard players operation #ct ch.tmp = @s ch.life
scoreboard players operation #ct ch.tmp %= #5 ch.g
execute if score #ct ch.tmp matches 0 store result score #chp ch.tmp run data get entity @s Health 10
execute if score #ct ch.tmp matches 0 if score @s ch.v2 matches 1 if score #chp ch.tmp matches ..40 run return run function ch:kit/corruption/ling/expire
tag @a remove ch.caster
function ch:api/tag_owner
tag @e[tag=ch.corruption.lt,distance=..40] remove ch.corruption.lt
tag @e[type=#ch:hostile,tag=!ch.noability,distance=..14,sort=nearest,limit=1] add ch.corruption.lt
execute unless entity @e[tag=ch.corruption.lt,distance=..14,limit=1] if score #pvp ch.g matches 1 run tag @a[tag=!ch.caster,gamemode=!creative,gamemode=!spectator,distance=..14,sort=nearest,limit=1] add ch.corruption.lt
execute if entity @e[tag=ch.corruption.lt,distance=..14,limit=1] run function ch:kit/corruption/ling/hunt
execute unless entity @e[tag=ch.corruption.lt,distance=..14,limit=1] unless entity @a[tag=ch.caster,distance=..4,limit=1] if entity @a[tag=ch.caster,distance=..40,limit=1] facing entity @a[tag=ch.caster,limit=1] feet rotated ~ 0 run function ch:kit/corruption/ling/move
execute at @s if block ~ ~-0.5 ~ #ch:passable run tp @s ~ ~-0.5 ~
execute at @s if block ~ ~-0.1 ~ #ch:passable run tp @s ~ ~-0.1 ~
execute if score #ct ch.tmp matches 0 run particle minecraft:dust{color:[0.482,0.82,0.227],scale:0.9} ~ ~1 ~ 0.25 0.4 0.25 0 2
tag @e[tag=ch.corruption.lt,distance=..40] remove ch.corruption.lt
tag @a remove ch.caster
