# Later: the glob splashes - 5 damage within 2 blocks and a puddle of poison that lingers 6 seconds.
execute as @a[tag=ch.challenger,distance=..2] run function ch:trials/corruption/strike {d:50}
effect give @a[tag=ch.challenger,distance=..2] minecraft:poison 3 0
particle minecraft:item_slime ~ ~0.3 ~ 0.6 0.2 0.6 0.2 25
particle minecraft:dust{color:[0.784,0.831,0.165],scale:2.0} ~ ~0.4 ~ 0.8 0.3 0.8 0 20
playsound minecraft:entity.slime.squish hostile @a ~ ~ ~ 1.2 0.6
playsound minecraft:entity.splash_potion.break hostile @a ~ ~ ~ 1 0.6
execute positioned ~ ~0.1 ~ run function ch:api/fx/wave {color:8114490,r:2.5,t:4}
summon marker ~ ~ ~ {Tags:["ch.corruption.tpud","ch.tmob","ch.noability"]}
scoreboard players set @e[type=marker,tag=ch.corruption.tpud,distance=..0.1,limit=1] ch.life 120
execute positioned ~ ~0.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:8114490,s0:1.0,s1:5.0,t:6,life:120,spin:30,dy:0.0}
