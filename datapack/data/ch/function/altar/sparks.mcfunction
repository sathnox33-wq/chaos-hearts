particle minecraft:portal ~ ~2.6 ~ 0.4 0.8 0.4 0.6 30
particle minecraft:enchant ~ ~2.6 ~ 2.5 1 2.5 1 20
particle minecraft:soul_fire_flame ~-4 ~2.6 ~-4 0.05 0.1 0.05 0.01 2
particle minecraft:soul_fire_flame ~4 ~2.6 ~-4 0.05 0.1 0.05 0.01 2
particle minecraft:soul_fire_flame ~-4 ~2.6 ~4 0.05 0.1 0.05 0.01 2
particle minecraft:soul_fire_flame ~4 ~2.6 ~4 0.05 0.1 0.05 0.01 2
particle minecraft:dust{color:[0.75,0.3,1.0],scale:1.2} ~ ~0.1 ~ 2 0 2 0 12
execute as @a[distance=..8,scores={ch.lvl=100..,ch.awake=0}] run function ch:altar/call
