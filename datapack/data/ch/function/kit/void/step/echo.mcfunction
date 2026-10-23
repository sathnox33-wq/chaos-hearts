# Down: a black echo of you stays where you stood, flickering for a second before it detonates.
execute store success score #ver ch.tmp if score @s ch.b3 matches 4..
execute rotated 0 0 run function ch:api/fx/sprite3 {model:"beam",color:655380,a:"[0.6,1.8,0.6]",b:"[0.5,1.8,0.5]",t:20,life:22,spin:0}
execute positioned ~ ~1.75 ~ rotated ~ 0 run function ch:api/fx/sprite {model:"orb",color:1310763,s0:0.45,s1:0.55,t:20,life:22,spin:170,dy:0.0}
execute positioned ~ ~0.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:13864191,s0:0.5,s1:7.0,t:20,life:22,spin:170,dy:0.0}
particle minecraft:squid_ink ~ ~1 ~ 0.25 0.6 0.25 0.01 20
function ch:api/later {t:7,then:"ch:kit/void/step/echo_pulse"}
function ch:api/later {t:14,then:"ch:kit/void/step/echo_pulse"}
function ch:api/later {t:20,then:"ch:kit/void/step/echo_boom"}
scoreboard players operation @e[type=marker,tag=ch.lnew,distance=..0.1] ch.v1 = #ver ch.tmp
