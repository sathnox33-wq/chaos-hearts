# One lance target: a closing rune on the floor.
execute rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:13864191,s0:4.0,s1:2.6,t:25,life:27,spin:170,dy:0.0}
execute rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:9059583,s0:0.5,s1:3.4,t:25,life:27,spin:-170,dy:0.0}
particle minecraft:portal ~ ~0.5 ~ 0.6 0.2 0.6 0.5 20
function ch:api/later {t:25,then:"ch:trials/void/lance_hit"}
