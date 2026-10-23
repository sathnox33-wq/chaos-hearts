# A marching Thunderstorm bolt, $(t) ticks out, telegraphed by a shrinking ring.
$function ch:api/later {t:$(t),then:"ch:kit/storm/ls/strike_plain"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run function ch:kit/storm/fn/cfg
$execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:5220607,s0:3.0,s1:0.5,t:$(t),life:$(t),spin:170,dy:0.0}
particle minecraft:electric_spark ~ ~2 ~ 0.3 2 0.3 0 12
