# Blood Challenge (War Cry, looking up): a war horn to the sky; enemies within 9 are dragged to you and marked for
# 5 s. Every blow a marked enemy lands on you feeds you double Fury. You gain Resistance I to take them.
scoreboard players set @s ch.rage.cry 100
effect give @s minecraft:resistance 5 0
execute if score @s ch.b2 matches 4.. run effect give @s minecraft:resistance 5 1
tag @s add ch.caster
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..9] run function ch:kit/rage/cry/mark
tag @s remove ch.caster
execute if score @s ch.b3 matches 5.. run function ch:kit/rage/banner/plant
function ch:api/fx/pillar {model:"beam",color:14689835,w:0.8,h:18.0,t:5,life:16}
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:14689835,s0:2.0,s1:18.0,t:6,life:16,spin:90,dy:0.0}
execute positioned ~ ~0.5 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:16738847,s0:2.0,s1:6.0,t:10,life:13,spin:120,dy:6.0}
execute positioned ~ ~3 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring_soft",color:14689835,s0:1.0,s1:4.0,t:10,life:13,spin:-120,dy:8.0}
particle minecraft:dust{color:[0.88,0.15,0.17],scale:2.0} ~ ~2 ~ 0.3 3 0.3 0 50
function ch:api/fx/shake {s:1,t:12,r:12}
function ch:api/fx/screen {o:"rage",color:"#E0262B",in:1,stay:4,out:10}
playsound minecraft:event.raid.horn player @a ~ ~ ~ 1.5 0.8
playsound minecraft:entity.ravager.roar player @a ~ ~ ~ 1.2 0.6
playsound chaoshearts:rage_warcry player @a ~ ~ ~ 1.2 0.8
return 1
