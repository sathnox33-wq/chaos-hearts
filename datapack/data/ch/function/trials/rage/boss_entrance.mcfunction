# Gorrath bursts up through the pit floor.
particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 1
function ch:api/fx/pillar {model:"flame",color:16738847,w:4.0,h:8.0,t:4,life:30}
function ch:api/fx/pillar {model:"beam",color:14689835,w:2.5,h:24.0,t:6,life:40}
function ch:api/fx/wave {color:14689835,r:10.0,t:10}
execute positioned ~ ~0.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"crack",color:14689835,s0:2.0,s1:14.0,t:5,life:100,spin:0,dy:0.0}
particle minecraft:block{block_state:"minecraft:blackstone"} ~ ~0.5 ~ 2.5 0.5 2.5 0.5 150
particle minecraft:dust{color:[0.88,0.15,0.17],scale:3.0} ~ ~1.5 ~ 1.5 1.5 1.5 0 120
particle minecraft:lava ~ ~1 ~ 1.5 0.5 1.5 0 40
particle minecraft:campfire_cosy_smoke ~ ~0.3 ~ 2 0.2 2 0.03 40
playsound minecraft:entity.ravager.roar master @a[distance=..90] ~ ~ ~ 3 0.5
playsound chaoshearts:boss_roar master @a[distance=..90] ~ ~ ~ 2 0.8
playsound chaoshearts:rage_slam master @a[distance=..90] ~ ~ ~ 2 0.6
execute as @a[tag=ch.challenger,distance=..90] run function ch:api/fx/screen {o:"rage",color:"#E0262B",in:2,stay:10,out:20}
