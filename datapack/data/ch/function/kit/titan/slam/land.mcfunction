# A slam leap lands. Skybreaker: a crater of erupting slabs launches and dazes everything within 4.5 blocks.
scoreboard players set @s ch.titan.air 0
scoreboard players set @s ch.titan.fall 12
scoreboard players operation #ti_d ch.tmp = @s ch.titan.ad
scoreboard players operation #ti_cat ch.tmp = @s ch.titan.acat
scoreboard players set #ti_big ch.tmp 0
execute if score #ti_cat ch.tmp matches 1 run scoreboard players set #ti_big ch.tmp 1
execute if score @s ch.titan.col matches 1.. run scoreboard players set #ti_big ch.tmp 1
scoreboard players add #ti_cid ch.titan.cid 1
scoreboard players operation #ti_cid ch.tmp = #ti_cid ch.titan.cid
execute if score @s ch.titan.airm matches 1 run return run function ch:kit/titan/col/titanfall_land
scoreboard players set @s ch.titan.sc 0
function ch:api/fx/wave {color:13214812,r:5.5,t:8}
function ch:api/fx/wave {color:3880238,r:3.0,t:5}
execute positioned ~ ~0.04 ~ rotated ~ 0 run function ch:api/fx/sprite {model:"crack",color:16742954,s0:0.6,s1:5.0,t:3,life:50,spin:0,dy:0.0}
function ch:kit/titan/fx/ring8
function ch:kit/titan/fx/later {t:3,then:"ch:kit/titan/slam/ring_fx"}
function ch:kit/titan/fx/debris
particle minecraft:explosion_emitter ~ ~0.5 ~ 0 0 0 0 1
particle minecraft:campfire_cosy_smoke ~ ~0.3 ~ 1.5 0.1 1.5 0.03 14
playsound chaoshearts:titan_quake player @a ~ ~ ~ 1.4 1
playsound minecraft:item.mace.smash_ground_heavy player @a ~ ~ ~ 1.4 0.5
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 1 0.7
function ch:api/fx/shake {s:3,t:10,r:12}
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:8}
function ch:api/fx/screen {o:"titan",color:"#C9A45C",in:1,stay:4,out:10}
execute if score #ti_cat ch.tmp matches 1 run function ch:kit/titan/slam/cat_fx
execute positioned ~ ~0.8 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..4.5] run function ch:kit/titan/slam/hurt_big
execute if score #ti_cat ch.tmp matches 1 positioned ~ ~0.8 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=4.5..6.5] run function ch:kit/titan/slam/hurt_big
