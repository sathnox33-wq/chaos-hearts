# Intro cinematic VFX: the six blood pools boil, the altar's heart beats and a red moon swells over the sanctum.
function ch:api/fx/pillar {model:"beam",color:10357535,w:1.6,h:22.0,t:12,life:70}
function ch:api/fx/wave {color:10357535,r:10.0,t:20}
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:16723263,s0:1.0,s1:8.0,t:20,life:90,spin:-170,dy:0.0}
execute positioned ~ ~16 ~ run function ch:api/fx/orb {color:10357535,s:7.0,t:40,life:120}
particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~12 ~ 10 1 10 0 120
playsound chaoshearts:trial_intro master @a[distance=..90] ~ ~ ~ 1 1
playsound minecraft:entity.warden.heartbeat master @a[distance=..90] ~ ~ ~ 2 0.5
playsound chaoshearts:blood_moon master @a[distance=..90] ~ ~ ~ 1.5 0.7
function ch:trials/blood/intro_pools
function ch:api/later {t:40,then:"ch:trials/blood/intro_beat"}
function ch:api/later {t:80,then:"ch:trials/blood/intro_beat"}
