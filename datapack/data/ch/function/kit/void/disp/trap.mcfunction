# Down: a rift opens beneath the target's new position - it collapses in 30 ticks (9 damage) unless they move.
execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:13864191,s0:5.5,s1:0.5,t:30,life:32,spin:170,dy:0.0}
execute positioned ~ ~0.05 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:1310763,s0:4.5,s1:4.5,t:30,life:32,spin:-170,dy:0.0}
playsound chaoshearts:void_rift player @a ~ ~ ~ 1 1.2
function ch:api/later {t:10,then:"ch:kit/void/step/hole_pulse"}
function ch:api/later {t:20,then:"ch:kit/void/step/hole_pulse"}
function ch:api/later {t:30,then:"ch:kit/void/disp/trap_boom"}
scoreboard players operation @e[type=marker,tag=ch.lnew,distance=..0.1] ch.v1 = #ver ch.tmp
