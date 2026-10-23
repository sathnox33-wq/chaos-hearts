# Moves the caster through the fold: vanish at the origin, arrive at the destination, then the variant's aftermath.
function ch:kit/void/step/vanish
execute if score @s ch.b1 matches 3.. run function ch:kit/void/step/wake
execute at @e[type=marker,tag=ch.void.dest,limit=1] run tp @s ~ ~ ~
execute if entity @e[tag=ch.void.sst,limit=1] at @s run tp @s ~ ~ ~ facing entity @e[tag=ch.void.sst,limit=1] eyes
execute if entity @e[tag=ch.void.sst,limit=1] as @e[tag=ch.void.sst,limit=1] at @s run function ch:kit/void/step/blindside
execute at @s run function ch:kit/void/step/arrive
execute store success score #ver ch.tmp if score @s ch.b3 matches 4..
execute if score #vnd ch.tmp matches 1 as @e[tag=ch.void.path,distance=..32] at @s run function ch:kit/void/step/rend
tag @e[tag=ch.void.path] remove ch.void.path
tag @e[tag=ch.void.sst] remove ch.void.sst
execute if score #vvar ch.tmp matches 1 at @e[type=marker,tag=ch.void.origin,limit=1] run function ch:kit/void/step/hole
execute if score #vvar ch.tmp matches 2 at @e[type=marker,tag=ch.void.origin,limit=1] run function ch:kit/void/step/echo
execute if score #vvar ch.tmp matches 1 run effect give @s minecraft:slow_falling 3 0 true
execute if score @s ch.b1 matches 4.. run scoreboard players set @s ch.void.st 40
scoreboard players operation @s ch.void.dist += #vsteps ch.tmp
execute if score @s ch.void.dist matches 2000.. run function ch:api/feat {h:"void",n:0}
execute if score @s ch.awake matches 1 at @e[type=marker,tag=ch.void.origin,limit=1] run function ch:kit/void/step/rift
execute unless score @s ch.awake matches 1 if score @s ch.b1 matches 2.. run function ch:api/cooldown {slot:1,t:120}
kill @e[type=marker,tag=ch.void.origin]
kill @e[type=marker,tag=ch.void.dest]
