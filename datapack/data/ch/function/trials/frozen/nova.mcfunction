# Too close: Hrimvald gathers a frost nova (a 20-tick shrinking ring), then it bursts 6 blocks wide.
function ch:trials/frozen/callout {t:"The cold gathers around him... get away!"}
execute positioned ~ 100 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:15924223,s0:12.0,s1:1.0,t:20,life:22,spin:170,dy:0.0}
execute positioned ~ 100.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:3108776,s0:12.0,s1:12.0,t:20,life:22,spin:-170,dy:0.0}
playsound minecraft:block.beacon.activate master @a[distance=..60] ~ ~ ~ 1.5 1.6
function ch:api/later {t:20,then:"ch:trials/frozen/nova_boom"}
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
