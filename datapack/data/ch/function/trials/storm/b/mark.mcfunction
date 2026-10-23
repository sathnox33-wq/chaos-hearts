# A strike mark: crackling sigil, shrinking ring, rising sparks.
function ch:api/later {t:25,then:"ch:trials/storm/b/strike"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run function ch:trials/storm/b/cfg
execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:5220607,s0:0.5,s1:4.6,t:5,life:25,spin:170,dy:0.0}
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:15267583,s0:4.8,s1:0.6,t:25,life:25,spin:-170,dy:0.0}
particle minecraft:electric_spark ~ ~3 ~ 0.3 3 0.3 0 30
playsound chaoshearts:trial_telegraph master @a[distance=..40] ~ ~ ~ 1 1.4
