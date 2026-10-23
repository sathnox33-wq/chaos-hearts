# Phase 3: Golgoth swells larger, the sky starts to fall, the magma spreads.
attribute @s minecraft:scale base set 3.1
attribute @s minecraft:attack_damage base set 18
function ch:trials/titan/callout {m:"THE SKY FALLS. Watch the ground for the marks!"}
playsound minecraft:entity.wither.spawn master @a ~ ~ ~ 1 0.5
playsound chaoshearts:titan_colossus master @a ~ ~ ~ 2 0.5
execute at @e[type=marker,tag=ch.session,distance=..80,limit=1] run function ch:trials/titan/magma_b
particle minecraft:explosion_emitter ~ ~2 ~ 0 0 0 0 1
function ch:api/fx/wave {color:13214812,r:20,t:16}
scoreboard players set @s ch.titan.tb1 20
