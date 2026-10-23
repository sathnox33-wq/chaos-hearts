# Phase 2: Golgoth roars, the floor splits into magma, Stonemites pour out, and it learns Stone Skin.
attribute @s minecraft:movement_speed base set 0.29
function ch:trials/titan/callout {m:"Golgoth roars. The quarry floor splits open!"}
playsound minecraft:entity.ravager.roar master @a ~ ~ ~ 3 0.4
execute at @e[type=marker,tag=ch.session,distance=..80,limit=1] run function ch:trials/titan/magma_a
function ch:api/fx/wave {color:16742954,r:16,t:14}
particle minecraft:lava ~ ~2 ~ 3 1 3 0 40
execute positioned ~3 ~ ~0 summon minecraft:silverfish run function ch:trials/titan/mob_mite
execute positioned ~-3 ~ ~0 summon minecraft:silverfish run function ch:trials/titan/mob_mite
execute positioned ~0 ~ ~3 summon minecraft:silverfish run function ch:trials/titan/mob_mite
execute positioned ~0 ~ ~-3 summon minecraft:silverfish run function ch:trials/titan/mob_mite
scoreboard players set @s ch.v5 40
