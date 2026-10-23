# One falling plague drop: a green orb plunges from the sky onto a marked spot.
execute positioned ~ ~0.05 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:13161514,s0:3.0,s1:0.6,t:10,life:11,spin:120,dy:0.0}
execute positioned ~ ~7 ~ rotated 0 0 run function ch:api/fx/sprite {model:"orb",color:8114490,s0:0.6,s1:0.8,t:10,life:11,spin:120,dy:-7.0}
function ch:api/later {t:10,then:"ch:kit/corruption/bolt/drop_hit"}
scoreboard players operation @e[type=marker,tag=ch.lnew,distance=..0.1] ch.v1 = #cnec ch.tmp
