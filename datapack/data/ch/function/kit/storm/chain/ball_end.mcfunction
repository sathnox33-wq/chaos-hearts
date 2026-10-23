# Ball Lightning bursts, and the burst chains outward (3 jumps).
function ch:api/fx/orb {color:15267583,s:3.0,t:2,life:5}
function ch:api/fx/wave {color:5220607,r:3.5,t:5}
particle minecraft:electric_spark ~ ~ ~ 1 1 1 0.6 50
playsound minecraft:entity.lightning_bolt.impact player @a ~ ~ ~ 1.4 0.9
playsound chaoshearts:storm_strike player @a ~ ~ ~ 1 1.3
scoreboard players set #d ch.storm.g 50
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..3.5] at @s run function ch:kit/storm/fn/zap
function ch:api/fx/shake {s:2,t:6,r:7}
scoreboard players set #v1 ch.storm.g 3
scoreboard players add #cidn ch.storm.g 1
scoreboard players operation #v2 ch.storm.g = #cidn ch.storm.g
scoreboard players set #v3 ch.storm.g 0
scoreboard players set #v4 ch.storm.g 40
tag @e[tag=ch.storm.nx] remove ch.storm.nx
tag @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..8,sort=nearest,limit=1] add ch.storm.nx
execute if entity @e[tag=ch.storm.nx,limit=1] run function ch:kit/storm/chain/jump
