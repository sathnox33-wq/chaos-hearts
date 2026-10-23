# Lightning Strike. Level: a crackling mark under the target, then the bolt (it follows them a little).
# Up: Stormcall, the bolt hits you and bursts out as a nova. Down: Ground Current, lightning races along the floor.
scoreboard players set #v1 ch.storm.g 70
execute if score @s ch.b1 matches 1.. run scoreboard players set #v1 ch.storm.g 84
execute if score #var ch.tmp matches 1 run return run function ch:kit/storm/ls/call
execute if score #var ch.tmp matches 2 run return run function ch:kit/storm/ls/current_start
function ch:api/ray {range:30}
scoreboard players set #v2 ch.storm.g 0
execute as @e[tag=ch.target,limit=1] run function ch:kit/storm/ls/lock
scoreboard players set #v3 ch.storm.g 0
scoreboard players set #v4 ch.storm.g 0
execute if score @s ch.b1 matches 5.. run scoreboard players set #v4 ch.storm.g 1
summon minecraft:marker ~ ~ ~ {Tags:["ch.storm.gm","ch.noability"]}
scoreboard players set #gn ch.storm.g 0
execute if entity @e[tag=ch.target,limit=1] at @e[tag=ch.target,limit=1] run tp @e[type=marker,tag=ch.storm.gm,limit=1] ~ ~ ~
execute unless entity @e[tag=ch.target,limit=1] at @e[type=marker,tag=ch.rayend,limit=1] run function ch:kit/storm/fn/ground
execute at @e[type=marker,tag=ch.storm.gm,limit=1] rotated ~ 0 run function ch:kit/storm/ls/mark
kill @e[type=marker,tag=ch.storm.gm]
playsound minecraft:item.trident.thunder player @a ~ ~ ~ 0.6 1.4
particle minecraft:electric_spark ^-0.4 ^1.6 ^0.6 0.1 0.1 0.1 0.2 8
return 1
