# Judgment: a pillar of light is marked on the target and strikes 6 ticks later.
execute positioned ~ ~0.05 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:16777215,s0:5.0,s1:0.8,t:6,life:7,spin:150,dy:0.0}
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16773808,w:0.1,h:18.0,t:5,life:7}
playsound minecraft:block.beacon.power_select player @a ~ ~ ~ 1 2
execute as @a[tag=ch.caster,limit=1] run function ch:kit/celestial/fx/later {t:6,then:"ch:kit/celestial/asc/pillar"}
tag @a remove ch.caster
