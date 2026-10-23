# Eruption, down: the ground under you splits; 6 ticks later it erupts and the blast rockets you upward.
data modify storage ch:tmp ki merge value {r:3.2,dia:6.4,rh:1.5,d:60}
execute align y run function ch:kit/infernal/erupt/self_fx with storage ch:tmp ki
function ch:api/later {t:6,then:"ch:kit/infernal/erupt/self_boom"}
data modify entity @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] data.e set from storage ch:tmp ki
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
effect give @s minecraft:resistance 1 1 true
return 1
