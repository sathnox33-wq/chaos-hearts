# Blood Thorns (Blood Spike, looking down): blood seeps along a line ahead (4 ticks), then thorns burst up along
# 10 blocks, one per tick: 4.5 damage, a 3 s bleed and a short root.
summon marker ~ ~ ~ {Tags:["ch.blood.thorn","ch.blood.tnew","ch.noability"]}
execute rotated ~ 0 run tp @e[type=marker,tag=ch.blood.tnew,limit=1] ~ ~ ~ ~ 0
scoreboard players set @e[type=marker,tag=ch.blood.tnew,limit=1] ch.v1 4
scoreboard players set @e[type=marker,tag=ch.blood.tnew,limit=1] ch.v2 0
scoreboard players operation @e[type=marker,tag=ch.blood.tnew,limit=1] ch.owner = @s ch.pid
execute as @e[type=marker,tag=ch.blood.tnew,limit=1] run function ch:api/new_eid
tag @e[type=marker,tag=ch.blood.tnew] remove ch.blood.tnew
scoreboard players set #ln ch.tmp 20
execute rotated ~ 0 positioned ~ ~0.15 ~ run function ch:kit/blood/fx/line
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~0.2 ~ 0.4 0.1 0.4 0.1 20
playsound minecraft:block.honey_block.slide player @a ~ ~ ~ 1 0.5
playsound chaoshearts:blood_spike player @a ~ ~ ~ 1 0.6
return 1
