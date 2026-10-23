# The Obsidian Shell explodes: 4 damage plus a third of what it absorbed (up to 14), 5 blocks around.
scoreboard players operation #ti_d ch.tmp = @s ch.titan.abs
scoreboard players operation #ti_d ch.tmp /= #3 ch.titan.k
scoreboard players add #ti_d ch.tmp 40
execute if score #ti_d ch.tmp matches 141.. run scoreboard players set #ti_d ch.tmp 140
scoreboard players add #ti_cid ch.titan.cid 1
scoreboard players operation #ti_cid ch.tmp = #ti_cid ch.titan.cid
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:16742954,s:6.0,t:3,life:7}
execute positioned ~ ~1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"shard",color:2760509,s0:1.0,s1:5.0,t:4,life:9,spin:170,dy:0.0}
function ch:api/fx/wave {color:3880238,r:6,t:6}
function ch:api/fx/wave {color:16742954,r:4,t:4}
data modify storage ch:tmp tg set value {b:"minecraft:obsidian",sz:"s"}
execute rotated 0 -20 positioned ~ ~1 ~ run function ch:kit/titan/fx/chunk
execute rotated 45 -40 positioned ~ ~1 ~ run function ch:kit/titan/fx/chunk
execute rotated 90 -10 positioned ~ ~1 ~ run function ch:kit/titan/fx/chunk
execute rotated 135 -35 positioned ~ ~1 ~ run function ch:kit/titan/fx/chunk
execute rotated 180 -20 positioned ~ ~1 ~ run function ch:kit/titan/fx/chunk
execute rotated 225 -45 positioned ~ ~1 ~ run function ch:kit/titan/fx/chunk
execute rotated 270 -15 positioned ~ ~1 ~ run function ch:kit/titan/fx/chunk
execute rotated 315 -30 positioned ~ ~1 ~ run function ch:kit/titan/fx/chunk
particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 1
particle minecraft:block{block_state:"minecraft:obsidian"} ~ ~1 ~ 1 1 1 0.4 80
particle minecraft:lava ~ ~1 ~ 1 0.5 1 0 12
playsound minecraft:block.glass.break player @a ~ ~ ~ 1.5 0.5
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 1.3 0.7
playsound chaoshearts:titan_quake player @a ~ ~ ~ 1.2 1.2
function ch:api/fx/shake {s:3,t:10,r:10}
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:6}
title @s clear
execute positioned ~ ~1 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..5] run function ch:kit/titan/skin/burst_hit
