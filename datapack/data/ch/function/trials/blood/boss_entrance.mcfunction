# Vesperine rises from a column of blood.
function ch:api/fx/pillar {model:"beam",color:10357535,w:3.0,h:20.0,t:8,life:40}
function ch:api/fx/pillar {model:"flame",color:16723263,w:2.5,h:6.0,t:5,life:30}
function ch:api/fx/wave {color:10357535,r:10.0,t:12}
execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:16723263,s0:1.0,s1:12.0,t:8,life:60,spin:170,dy:0.0}
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~2 ~ 1.5 2 1.5 0.4 150
particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~6 ~ 3 1 3 0 60
playsound minecraft:entity.evoker.prepare_summon master @a[distance=..90] ~ ~ ~ 2 0.6
playsound chaoshearts:blood_drink master @a[distance=..90] ~ ~ ~ 2 0.6
playsound chaoshearts:boss_roar master @a[distance=..90] ~ ~ ~ 2 1.2
execute as @a[tag=ch.challenger,distance=..90] run function ch:api/fx/screen {o:"blood",color:"#9E0B1F",in:2,stay:10,out:20}
