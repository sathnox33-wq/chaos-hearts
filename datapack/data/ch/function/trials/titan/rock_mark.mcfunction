# Marks a boulder landing spot (radius $(r)): an ember ring that closes in, then the fall.
$execute positioned ~ ~0.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:16742954,s0:$(d),s1:0.8,t:20,life:22,spin:120,dy:0.0}
$execute positioned ~ ~0.15 ~ run function ch:api/fx/ring {p:"minecraft:dust{color:[1.0,0.478,0.165],scale:1.8}",r:$(r)}
playsound chaoshearts:trial_telegraph master @a ~ ~ ~ 1 0.8
data modify storage ch:tmp tg set value {b:"minecraft:cobblestone",sz:"b"}
function ch:kit/titan/rock/fall_rock with storage ch:tmp tg
function ch:api/later {t:12,then:"ch:trials/titan/rock_land"}
