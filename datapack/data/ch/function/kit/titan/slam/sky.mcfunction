# Up: Skybreaker. Launch skyward; the landing spot is marked on the ground below, and you crash onto it.
function ch:api/leap {n:2}
scoreboard players set @s ch.titan.air 50
scoreboard players set @s ch.titan.airt 0
scoreboard players set @s ch.titan.airm 0
scoreboard players operation @s ch.titan.ad = #ti_d ch.tmp
scoreboard players operation @s ch.titan.acat = #ti_cat ch.tmp
attribute @s minecraft:fall_damage_multiplier modifier add ch:titan_fall -1 add_multiplied_total
function ch:api/fx/wave {color:8025194,r:2.5,t:5}
function ch:kit/titan/fx/debris
particle minecraft:gust ~ ~0.2 ~ 0.3 0 0.3 0 2
playsound minecraft:entity.breeze.wind_burst player @a ~ ~ ~ 1 0.6
playsound chaoshearts:titan_slam player @a ~ ~ ~ 0.6 1.5
return 1
