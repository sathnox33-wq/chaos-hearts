# Every tick of the Celestial trial: motes of starlight drift around the challenger; shooting stars cross the dark.
execute at @a[tag=ch.challenger,limit=1] run particle minecraft:end_rod ~ ~5 ~ 9 3 9 0.005 2
execute at @a[tag=ch.challenger,limit=1] run particle minecraft:dust{color:[1.0,0.949,0.69],scale:0.7} ~ ~3 ~ 9 2 9 0 6
scoreboard players operation #ce_m ch.tmp = #now ch.g
scoreboard players operation #ce_m ch.tmp %= #80 ch.celestial.k
execute if score #ce_m ch.tmp matches 0 positioned ~18 ~24 ~-20 rotated 130 25 run function ch:api/fx/beam {color:16773808,w:0.12,len:14.0,t:4,life:10}
execute if score #ce_m ch.tmp matches 40 positioned ~-22 ~28 ~14 rotated -60 20 run function ch:api/fx/beam {color:16765803,w:0.12,len:12.0,t:4,life:10}
execute if score #ce_m ch.tmp matches 20 positioned ~6 ~30 ~26 rotated 200 30 run function ch:api/fx/beam {color:16777215,w:0.1,len:16.0,t:4,life:10}
