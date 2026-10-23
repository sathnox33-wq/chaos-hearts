# A blood thorn bursts from the ground.
execute positioned ~ ~-0.5 ~ run function ch:api/fx/sprite3 {model:"spike",color:10357535,a:"[0.4,0.05,0.4]",b:"[1.0,2.2,1.0]",t:2,life:14,spin:45}
execute positioned ~0.4 ~-0.5 ~-0.3 run function ch:api/fx/sprite3 {model:"spike",color:16723263,a:"[0.2,0.05,0.2]",b:"[0.5,1.2,0.5]",t:3,life:12,spin:-45}
execute positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"crack",color:2818054,s0:0.4,s1:2.2,t:2,life:20,spin:30,dy:0.0}
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~0.4 ~ 0.3 0.3 0.3 0.2 14
particle minecraft:dust{color:[0.62,0.04,0.12],scale:1.4} ~ ~0.6 ~ 0.3 0.5 0.3 0 6
playsound minecraft:block.pointed_dripstone.land player @a ~ ~ ~ 0.9 0.6
scoreboard players operation #fe ch.tmp = @s ch.eid
scoreboard players set #bt ch.tmp 60
scoreboard players set #bm ch.tmp 0
tag @a remove ch.caster
function ch:api/tag_owner
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..1.6] unless score @s ch.blood.hit = #fe ch.tmp run function ch:kit/blood/spike/thorn_hit
tag @a remove ch.caster
