# The roar: 9 damage and a launch inside 7.5 blocks, rings of force rolling out.
scoreboard players set @s ch.v2 0
function ch:trials/rage/unfreeze
tag @s add ch.caster
execute as @a[tag=ch.challenger,distance=..7.5] run function ch:trials/rage/roar_hit
tag @s remove ch.caster
function ch:api/fx/wave {color:14689835,r:8.0,t:6}
function ch:api/later {t:3,then:"ch:trials/rage/roar_ring"}
execute positioned ~ ~2 ~ run function ch:api/fx/orb {color:16738847,s:6.0,t:3,life:7}
execute positioned ~ ~2 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"ring",color:14689835,s0:1.0,s1:10.0,t:5,life:8,spin:0,dy:0.0}
particle minecraft:explosion ~ ~1 ~ 3 0.5 3 0 8
particle minecraft:sonic_boom ~ ~2 ~ 1 0.5 1 0 3
function ch:api/fx/shake {s:3,t:12,r:20}
playsound minecraft:entity.ravager.roar master @a[distance=..90] ~ ~ ~ 3 0.7
playsound chaoshearts:rage_slam master @a[distance=..90] ~ ~ ~ 2 0.8
