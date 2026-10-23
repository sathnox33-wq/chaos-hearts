# The Crimson Rain warning: a blood rune circle on the ground and a gathering cloud above it.
execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:10357535,s0:1.0,s1:7.0,t:8,life:40,spin:90,dy:0.0}
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:16723263,s0:7.0,s1:7.0,t:2,life:40,spin:0,dy:0.0}
execute positioned ~ ~7 ~ rotated 0 0 run function ch:api/fx/sprite {model:"cloud",color:2818054,s0:1.0,s1:6.0,t:12,life:42,spin:30,dy:0.0}
particle minecraft:dust{color:[0.62,0.04,0.12],scale:1.4} ~ ~0.2 ~ 2.5 0.05 2.5 0 30
playsound chaoshearts:trial_telegraph player @a ~ ~ ~ 0.8 1.4
function ch:api/later {t:16,then:"ch:kit/blood/spike/rain_fall"}
scoreboard players set @e[type=marker,tag=ch.lnew,distance=..0.5,limit=1,sort=nearest] ch.v1 1
