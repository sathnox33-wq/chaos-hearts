# Chain Lightning. Level: a bolt that leaps enemy to enemy (5 jumps, Conductor 7).
# Up: Ball Lightning, a slow orb that lashes everything near it, then bursts into a chain. Down: Arc Snare, tether
# everyone around you; whoever strays more than 7 blocks is struck hard and dragged back.
execute if score #var ch.tmp matches 1 run return run function ch:kit/storm/chain/ball
execute if score #var ch.tmp matches 2 run return run function ch:kit/storm/chain/snare
tag @e[tag=ch.storm.nx] remove ch.storm.nx
function ch:api/ray {range:20}
tag @e[tag=ch.target,limit=1] add ch.storm.nx
execute unless entity @e[tag=ch.storm.nx,limit=1] run tag @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..8,sort=nearest,limit=1] add ch.storm.nx
execute unless entity @e[tag=ch.storm.nx,limit=1] run return fail
scoreboard players set #v1 ch.storm.g 5
execute if score @s ch.b1 matches 3.. run scoreboard players set #v1 ch.storm.g 7
scoreboard players add #cidn ch.storm.g 1
scoreboard players operation #v2 ch.storm.g = #cidn ch.storm.g
scoreboard players set #v3 ch.storm.g 0
scoreboard players set #v4 ch.storm.g 50
playsound minecraft:item.trident.thunder player @a ~ ~ ~ 0.5 1.8
playsound chaoshearts:storm_chain player @a ~ ~ ~ 1 1
function ch:api/fx/screen {o:"storm",color:"#4FA8FF",in:0,stay:2,out:6}
execute anchored eyes positioned ^ ^-0.3 ^0.6 run function ch:kit/storm/chain/jump
return 1
