# A lightning bolt drawn from the sky at this ground point: twin columns, a scorched sigil, a shockwave, light and thunder.
function ch:api/fx/pillar {model:"beam",color:16777215,w:0.35,h:26.0,t:1,life:5}
function ch:api/fx/pillar {model:"beam",color:5220607,w:1.1,h:26.0,t:2,life:7}
execute positioned ~ ~0.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"bolt",color:15267583,s0:0.5,s1:3.2,t:2,life:14,spin:60,dy:0.0}
execute positioned ~ ~0.04 ~ rotated 0 0 run function ch:api/fx/sprite {model:"crack",color:2842040,s0:0.5,s1:4.0,t:3,life:30,spin:20,dy:0.0}
function ch:api/fx/orb {color:15267583,s:2.4,t:2,life:5}
function ch:api/fx/wave {color:5220607,r:3.0,t:5}
particle minecraft:electric_spark ~ ~6 ~ 0.12 6 0.12 0 70
particle minecraft:end_rod ~ ~8 ~ 0.08 8 0.08 0 30
particle minecraft:electric_spark ~ ~0.5 ~ 0.8 0.4 0.8 0.6 40
particle minecraft:dust{color:[0.91,0.96,1.0],scale:1.0} ~ ~0.3 ~ 0.7 0.1 0.7 0 20
particle minecraft:explosion ~ ~0.5 ~ 0 0 0 0 1
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:4}
playsound chaoshearts:storm_strike player @a ~ ~ ~ 1.5 1
playsound minecraft:entity.lightning_bolt.impact player @a ~ ~ ~ 1.4 1
playsound minecraft:entity.lightning_bolt.thunder player @a ~ ~ ~ 0.7 1.3
function ch:api/fx/shake {s:2,t:6,r:9}
