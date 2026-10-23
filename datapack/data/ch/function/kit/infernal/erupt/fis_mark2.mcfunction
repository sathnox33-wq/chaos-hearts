# A glowing crack, then a geyser $(t) ticks later.
$execute rotated 0 0 positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"crack",color:$(c),s0:0.5,s1:$(dia),t:6,life:$(t),spin:0,dy:0.0}
$execute rotated 0 0 positioned ~ ~0.08 ~ run function ch:api/fx/sprite {model:"ring_soft",color:$(c2),s0:$(dia),s1:$(dia),t:10,life:$(t),spin:90,dy:0.0}
$particle $(fl) ~ ~0.2 ~ 0.6 0 0.6 0.02 8
particle minecraft:lava ~ ~0.2 ~ 0.4 0 0.4 0 2
$function ch:api/later {t:$(t),then:"ch:kit/infernal/erupt/fis_boom"}
data modify entity @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] data.e set from storage ch:tmp ki
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
