# Golgoth rises out of the quarry floor.
particle minecraft:block{block_state:"minecraft:stone"} ~ ~1 ~ 2 0.3 2 0.3 200
particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 1
function ch:api/fx/wave {color:13214812,r:10,t:12}
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:13214812,w:3.0,h:20.0,t:6,life:30}
scoreboard players set #ti_big ch.tmp 1
function ch:kit/titan/fx/ring12
function ch:kit/titan/fx/ring16
playsound minecraft:entity.iron_golem.repair master @a ~ ~ ~ 3 0.4
playsound chaoshearts:titan_colossus master @a ~ ~ ~ 2 0.6
playsound chaoshearts:titan_quake master @a ~ ~ ~ 2 0.6
