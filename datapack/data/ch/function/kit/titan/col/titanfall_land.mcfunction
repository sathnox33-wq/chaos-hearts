# Titanfall lands: 10 damage and a launch to everything within 6 blocks, three rings of slabs, then the Colossus.
scoreboard players set @s ch.titan.sc 0
scoreboard players set #ti_big ch.tmp 1
function ch:kit/titan/fx/ring8
function ch:api/fx/wave {color:16742954,r:7,t:8}
execute positioned ~ ~0.04 ~ rotated ~ 0 run function ch:api/fx/sprite {model:"crack",color:16742954,s0:1.0,s1:8.0,t:3,life:60,spin:0,dy:0.0}
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 1.5 0.5
playsound chaoshearts:titan_quake player @a ~ ~ ~ 1.6 0.8
execute positioned ~ ~0.8 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..6] run function ch:kit/titan/slam/hurt_big
scoreboard players set @s ch.titan.colm 0
function ch:kit/titan/col/begin
