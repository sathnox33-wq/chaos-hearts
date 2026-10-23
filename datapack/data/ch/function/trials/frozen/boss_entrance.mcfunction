# Entrance: the air shatters.
particle minecraft:snowflake ~ ~2 ~ 2 2 2 0.15 250
particle minecraft:block{block_state:"minecraft:blue_ice"} ~ ~1 ~ 1 1 1 0.3 60
particle minecraft:end_rod ~ ~2 ~ 0.5 1 0.5 0.3 40
function ch:api/fx/pillar {model:"beam",color:15924223,w:2.0,h:30.0,t:4,life:20}
execute rotated 0 0 positioned ~ ~0.1 ~ run function ch:api/fx/sprite {model:"dome",color:10217471,s0:1.0,s1:16.0,t:8,life:16,spin:90,dy:0.0}
execute rotated 0 0 run function ch:api/fx/wave {color:15924223,r:14.0,t:10}
function ch:api/fx/shake {s:3,t:20,r:60}
function ch:api/fx/light {t:20}
playsound chaoshearts:boss_roar master @a[distance=..90] ~ ~ ~ 2 0.9
playsound chaoshearts:frozen_shatter master @a[distance=..90] ~ ~ ~ 2 0.6
playsound minecraft:entity.elder_guardian.curse master @a[distance=..90] ~ ~ ~ 1 0.7
