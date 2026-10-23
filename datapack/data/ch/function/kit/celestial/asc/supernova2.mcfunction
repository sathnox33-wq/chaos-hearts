# The Supernova itself, centred on the Celestial.
function ch:api/fx/orb {color:16777215,s:12.0,t:3,life:8}
execute rotated 0 0 run function ch:api/fx/sprite {model:"star",color:16763210,s0:1.0,s1:14.0,t:4,life:10,spin:170,dy:0.0}
execute positioned ~ ~-1 ~ run function ch:api/fx/wave {color:16765803,r:10,t:10}
execute positioned ~ ~-1 ~ run function ch:api/fx/wave {color:16777215,r:6,t:6}
particle minecraft:explosion_emitter ~ ~ ~ 0 0 0 0 1
particle minecraft:end_rod ~ ~ ~ 0.5 0.5 0.5 0.6 120
particle minecraft:firework ~ ~ ~ 1 1 1 0.5 80
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 1.6 1.4
playsound chaoshearts:celestial_nova player @a ~ ~ ~ 2 1
playsound minecraft:entity.firework_rocket.large_blast player @a ~ ~ ~ 2 0.6
function ch:api/fx/shake {s:3,t:16,r:20}
function ch:api/fx/light {t:10}
execute as @a[distance=..20] run function ch:api/fx/screen {o:"flash",color:"#FFFFFF",in:0,stay:4,out:20}
scoreboard players set #ce_d ch.tmp 100
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..6] run function ch:kit/celestial/asc/nova_hit
