# Intro cinematic VFX: the magma heart of the Crucible flares and the eight war pillars ignite one by one.
function ch:api/fx/pillar {model:"beam",color:14689835,w:2.0,h:20.0,t:10,life:60}
function ch:api/fx/wave {color:14689835,r:12.0,t:20}
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:16738847,s0:1.0,s1:10.0,t:20,life:80,spin:170,dy:0.0}
particle minecraft:lava ~ ~0.5 ~ 2 0.2 2 0 30
playsound chaoshearts:trial_intro master @a[distance=..90] ~ ~ ~ 1 1
playsound minecraft:entity.ravager.roar master @a[distance=..90] ~ ~ ~ 2 0.5
playsound chaoshearts:rage_slam master @a[distance=..90] ~ ~ ~ 1.5 0.6
function ch:trials/rage/intro_pillars
function ch:api/later {t:60,then:"ch:trials/rage/intro_roar"}
