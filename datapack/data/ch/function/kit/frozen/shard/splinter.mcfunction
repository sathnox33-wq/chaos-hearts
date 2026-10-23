# Splinter: fragments fan out from the impact (35% damage within 2.5 blocks).
execute rotated 0 -10 run function ch:api/fx/beam {color:10217471,w:0.08,len:2.6,t:2,life:5}
execute rotated 60 -25 run function ch:api/fx/beam {color:15924223,w:0.08,len:2.6,t:2,life:5}
execute rotated 120 -5 run function ch:api/fx/beam {color:10217471,w:0.08,len:2.6,t:2,life:5}
execute rotated 180 -30 run function ch:api/fx/beam {color:6273256,w:0.08,len:2.6,t:2,life:5}
execute rotated 240 -15 run function ch:api/fx/beam {color:10217471,w:0.08,len:2.6,t:2,life:5}
execute rotated 300 -20 run function ch:api/fx/beam {color:15924223,w:0.08,len:2.6,t:2,life:5}
particle minecraft:item_snowball ~ ~ ~ 0.5 0.3 0.5 0.2 16
playsound minecraft:block.amethyst_cluster.break player @a ~ ~ ~ 0.8 1.4
scoreboard players set #f_dmg ch.tmp 18
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..2.5] at @s run function ch:kit/frozen/hurt
