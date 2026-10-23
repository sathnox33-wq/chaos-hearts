# The ground splits and a boulder of $(b) is wrenched up over the Titan's head (8-tick windup).
$execute positioned ~ ~-1.2 ~ rotated ~ -90 summon block_display run data merge entity @s {block_state:{Name:"$(b)"},Tags:["ch.fx","ch.noability","ch.titan.slide","ch.titan.lift"],teleport_duration:7,view_range:2.0f,transformation:{left_rotation:[0.15f,0.2f,0.1f,0.96f],right_rotation:[0f,0f,0f,1f],translation:[-0.65f,-0.65f,-0.65f],scale:[1.3f,1.3f,1.3f]}}
execute as @e[type=block_display,tag=ch.titan.lift,distance=..2,limit=1,sort=nearest] unless score @s ch.life matches 1.. run function ch:kit/titan/rock/lift_init
$particle minecraft:block{block_state:"$(b)"} ~ ~0.3 ~ 0.6 0.2 0.6 0.2 40
$particle minecraft:dust_pillar{block_state:"$(b)"} ~ ~0.1 ~ 0.6 0.1 0.6 0.2 12
execute positioned ~ ~0.04 ~ rotated ~ 0 run function ch:api/fx/sprite {model:"crack",color:16742954,s0:0.4,s1:2.4,t:3,life:30,spin:0,dy:0.0}
particle minecraft:campfire_cosy_smoke ~ ~0.2 ~ 0.6 0 0.6 0.02 6
playsound minecraft:block.stone.break player @a ~ ~ ~ 1.5 0.5
playsound minecraft:entity.ravager.attack player @a ~ ~ ~ 0.8 0.6
playsound chaoshearts:titan_boulder player @a ~ ~ ~ 0.6 0.7
function ch:api/fx/shake {s:1,t:6,r:5}
