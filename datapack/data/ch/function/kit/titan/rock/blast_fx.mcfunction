# The boulder of $(b) bursts: shockwave, crater, flung chunks, smoke, light and a heavy crash.
function ch:api/fx/wave {color:13214812,r:4.2,t:6}
execute positioned ~ ~0.04 ~ rotated 0 0 run function ch:api/fx/sprite {model:"crack",color:16742954,s0:0.6,s1:4.0,t:3,life:40,spin:0,dy:0.0}
execute positioned ~ ~0.5 ~ run function ch:api/fx/orb {color:16757575,s:3.0,t:2,life:5}
function ch:kit/titan/fx/debris
$particle minecraft:block{block_state:"$(b)"} ~ ~0.5 ~ 1.2 0.4 1.2 0.3 80
$particle minecraft:dust_pillar{block_state:"$(b)"} ~ ~0.2 ~ 1 0.1 1 0.2 20
particle minecraft:explosion ~ ~0.5 ~ 0.8 0.3 0.8 0 4
particle minecraft:campfire_cosy_smoke ~ ~0.4 ~ 1 0.2 1 0.03 10
playsound chaoshearts:titan_boulder player @a ~ ~ ~ 1.4 1
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 1 0.7
playsound minecraft:block.stone.break player @a ~ ~ ~ 1.5 0.5
function ch:api/fx/shake {s:2,t:8,r:10}
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:6}
