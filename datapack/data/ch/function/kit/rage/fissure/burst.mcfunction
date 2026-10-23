# The ground tears open: a crack, an erupting spike of stone and fire, and a hit on anything standing on it.
execute positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"crack",color:14689835,s0:0.5,s1:2.6,t:2,life:30,spin:40,dy:0.0}
execute positioned ~ ~-0.6 ~ run function ch:api/fx/sprite3 {model:"spike",color:3801088,a:"[0.5,0.05,0.5]",b:"[1.1,2.2,1.1]",t:2,life:10,spin:45}
execute positioned ~ ~-0.4 ~ run function ch:api/fx/sprite3 {model:"flame",color:16738847,a:"[0.6,0.05,0.6]",b:"[1.2,1.8,1.2]",t:3,life:8,spin:100}
particle minecraft:block{block_state:"minecraft:blackstone"} ~ ~0.3 ~ 0.4 0.2 0.4 0.2 18
particle minecraft:lava ~ ~0.3 ~ 0.2 0.1 0.2 0 2
particle minecraft:flame ~ ~0.3 ~ 0.3 0.4 0.3 0.04 6
execute if score #r2 ch.tmp matches 0 run playsound minecraft:block.basalt.break player @a ~ ~ ~ 1.2 0.5
playsound minecraft:block.pointed_dripstone.land player @a ~ ~ ~ 0.8 0.5
function ch:api/fx/shake {s:1,t:3,r:5}
scoreboard players operation #fe ch.tmp = @s ch.eid
execute store result storage ch:tmp rage.d int 1 run scoreboard players get @s ch.v3
tag @a remove ch.caster
function ch:api/tag_owner
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..1.8] unless score @s ch.rage.fh = #fe ch.tmp run function ch:kit/rage/fissure/hit with storage ch:tmp rage
tag @a remove ch.caster
