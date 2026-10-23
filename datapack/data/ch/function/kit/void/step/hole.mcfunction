# Up: the hole you left behind is a wound in space. It shrinks for 16 ticks, then collapses on whoever stands in it.
execute store success score #ver ch.tmp if score @s ch.b3 matches 4..
execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:9059583,s0:7.0,s1:0.6,t:16,life:18,spin:170,dy:0.0}
execute positioned ~ ~0.05 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:1310763,s0:5.5,s1:1.0,t:16,life:18,spin:-170,dy:0.0}
playsound chaoshearts:void_rift player @a ~ ~ ~ 0.9 1.5
function ch:api/later {t:6,then:"ch:kit/void/step/hole_pulse"}
function ch:api/later {t:11,then:"ch:kit/void/step/hole_pulse"}
function ch:api/later {t:16,then:"ch:kit/void/step/hole_boom"}
scoreboard players operation @e[type=marker,tag=ch.lnew,distance=..0.1] ch.v1 = #ver ch.tmp
