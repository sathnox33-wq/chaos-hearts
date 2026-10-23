# The web's telegraph.
execute rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:14540253,s0:0.5,s1:5.0,t:25,life:27,spin:90,dy:0.0}
execute rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:16777215,s0:5.0,s1:4.6,t:25,life:27,spin:-90,dy:0.0}
particle minecraft:item_cobweb ~ ~0.3 ~ 1.2 0.1 1.2 0 20
function ch:api/later {t:25,then:"ch:trials/corruption/snare_hit"}
