# Every 5 ticks: the field grows to full size over a second, churns, and withers and mires everything on it.
scoreboard players operation #cr ch.tmp = @s ch.t
execute if score #cr ch.tmp matches 21.. run scoreboard players set #cr ch.tmp 20
scoreboard players operation #cr ch.tmp *= @s ch.v2
scoreboard players operation #cr ch.tmp /= #20 ch.g
execute store result storage ch:corruption r.r float 0.1 run scoreboard players get #cr ch.tmp
execute store result storage ch:corruption r.h float 0.05 run scoreboard players get #cr ch.tmp
execute store result score #cry ch.tmp run data get entity @s Pos[1] 10
scoreboard players operation #cro ch.tmp = @s ch.owner
scoreboard players operation #cwa ch.tmp = @s ch.v3
scoreboard players operation #cmi ch.tmp = @s ch.v4
scoreboard players operation #cnec ch.tmp = @s ch.v6
scoreboard players operation #ct ch.tmp = @s ch.t
scoreboard players operation #ct ch.tmp %= #20 ch.g
function ch:kit/corruption/rot/area with storage ch:corruption r
execute if score @s ch.v1 matches 1 run effect give @a[tag=ch.caster,limit=1] minecraft:regeneration 2 0 true
execute if score #ct ch.tmp matches 0 run playsound minecraft:block.sculk.charge player @a ~ ~ ~ 0.6 0.6
scoreboard players set #cnow ch.tmp 0
execute as @e[tag=ch.corruption.inrot,distance=..48] if score @s ch.corruption.ro = #cro ch.tmp run scoreboard players add #cnow ch.tmp 1
scoreboard players operation @a[tag=ch.caster,limit=1] ch.corruption.rn = #cnow ch.tmp
execute if score @s ch.v1 matches 1 if score #ct ch.tmp matches 0 positioned ~ ~0.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:4004434,s0:2.0,s1:7.0,t:18,life:20,spin:90,dy:0.0}
execute if score @s ch.v1 matches 1 if score #ct ch.tmp matches 10 positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring_soft",color:8114490,s0:7.0,s1:1.0,t:18,life:20,spin:-90,dy:0.0}
