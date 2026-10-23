# Marks a strike at an enemy's feet: a closing ring and a falling glob, landing in 12 ticks.
execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:13161514,s0:4.0,s1:0.8,t:12,life:13,spin:150,dy:0.0}
execute positioned ~ ~9 ~ rotated 0 0 run function ch:api/fx/sprite {model:"orb",color:8114490,s0:0.9,s1:1.2,t:12,life:13,spin:150,dy:-9.0}
playsound minecraft:entity.llama.spit player @a ~ ~ ~ 0.8 0.5
function ch:api/later {t:12,then:"ch:kit/corruption/pan/storm_hit"}
scoreboard players operation @e[type=marker,tag=ch.lnew,distance=..0.1] ch.v1 = #cnec ch.tmp
