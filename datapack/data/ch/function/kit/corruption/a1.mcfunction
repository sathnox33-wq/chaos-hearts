# Plague Bolt. Level: a fast bolt of rot that bursts into a lingering poison cloud. Up: a lobbed plague mortar that
# arcs down into a bigger cloud and a splash of damage. Down: spew bile in a cone at point-blank range.
# At 100 Contagion the bolt is a Pestilence Bolt: +60% damage, a 50% wider cloud and Wither II.
scoreboard players operation #cvar ch.tmp = #var ch.tmp
scoreboard players set #cpest ch.tmp 0
execute if score @s ch.corruption.m matches 100.. run scoreboard players set #cpest ch.tmp 1
execute if score #cpest ch.tmp matches 1 run function ch:kit/corruption/bolt/pest
execute store success score #cnec ch.tmp if score @s ch.b1 matches 4..
scoreboard players set #cd ch.tmp 40
execute if score @s ch.b1 matches 1.. run scoreboard players set #cd ch.tmp 50
execute if score #cpest ch.tmp matches 1 run scoreboard players operation #cd ch.tmp *= #16 ch.corruption.k
execute if score #cpest ch.tmp matches 1 run scoreboard players operation #cd ch.tmp /= #10 ch.g
execute if score #cvar ch.tmp matches 2 run return run function ch:kit/corruption/bolt/spew
execute if score #cvar ch.tmp matches 0 run function ch:api/proj {item:"minecraft:slime_ball",scale:0.7,speed:6,life:30,hit:"ch:kit/corruption/bolt/hit",step:"ch:kit/corruption/bolt/step",end:"ch:kit/corruption/bolt/end",pierce:0,ignore:"ch.powner"}
execute if score #cvar ch.tmp matches 1 run function ch:api/proj {item:"minecraft:slime_ball",scale:0.9,speed:5,life:70,hit:"ch:kit/corruption/bolt/hit",step:"ch:kit/corruption/bolt/step",end:"ch:kit/corruption/bolt/end",pierce:0,ignore:"ch.powner"}
execute as @e[type=item_display,tag=ch.proj,tag=ch.lnew,distance=..3,limit=1,sort=nearest] run function ch:kit/corruption/bolt/style
playsound chaoshearts:corruption_bolt player @a ~ ~ ~ 1 1
playsound minecraft:entity.witch.throw player @a ~ ~ ~ 1 0.6
playsound minecraft:entity.spider.ambient player @a ~ ~ ~ 0.4 0.6
execute anchored eyes positioned ^ ^ ^1 rotated ~ ~90 run function ch:api/fx/sprite {model:"ring",color:8114490,s0:0.3,s1:1.8,t:3,life:6,spin:170,dy:0.0}
particle minecraft:item_slime ^ ^1.5 ^1 0.2 0.2 0.2 0.05 8
return 1
