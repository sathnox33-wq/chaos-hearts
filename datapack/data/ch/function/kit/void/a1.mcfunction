# Void Step. Level: step to where you look (behind the enemy you aim at). Up: rise, and the hole you leave collapses.
# Down: fold backwards, leaving an echo of yourself that detonates. Awakened: cast again to return through your rift.
scoreboard players operation #vme ch.tmp = @s ch.pid
tag @e[type=marker,tag=ch.void.myrift] remove ch.void.myrift
execute if score @s ch.awake matches 1 as @e[type=marker,tag=ch.void.rift,distance=..128] if score @s ch.owner = #vme ch.tmp run tag @s add ch.void.myrift
execute if entity @e[type=marker,tag=ch.void.myrift,limit=1] run return run function ch:kit/void/step/return
scoreboard players operation #vvar ch.tmp = #var ch.tmp
scoreboard players set #vsteps ch.tmp 0
scoreboard players set #vnd ch.tmp 0
execute if score @s ch.b1 matches 5.. run scoreboard players set #vnd ch.tmp 1
kill @e[type=marker,tag=ch.void.dest]
summon marker ~ ~ ~ {Tags:["ch.void.origin","ch.noability"]}
execute if score #vvar ch.tmp matches 0 run function ch:kit/void/step/level
execute if score #vvar ch.tmp matches 1 run function ch:kit/void/step/up
execute if score #vvar ch.tmp matches 2 run function ch:kit/void/step/back
execute unless entity @e[type=marker,tag=ch.void.dest,limit=1] run return run function ch:kit/void/step/nowhere
execute if score #vsteps ch.tmp matches ..1 run return run function ch:kit/void/step/nowhere
function ch:kit/void/step/go
return 1
