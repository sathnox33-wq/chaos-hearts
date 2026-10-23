# Throne room ambience: ash and embers drifting around the challenger, distant rumbling.
scoreboard players operation #ib ch.tmp = #now ch.g
scoreboard players operation #ib ch.tmp %= #4 ch.g
execute if score #ib ch.tmp matches 0 at @a[tag=ch.challenger,distance=..90] run particle minecraft:ash ~ ~3 ~ 9 3 9 0 20
execute if score #ib ch.tmp matches 0 at @a[tag=ch.challenger,distance=..90] run particle minecraft:small_flame ~ ~2 ~ 9 2 9 0.01 6
execute if score #ib ch.tmp matches 2 at @a[tag=ch.challenger,distance=..90] run particle minecraft:lava ~ ~0.2 ~ 8 0 8 0 1
execute if score #t20 ch.g matches 0 run particle minecraft:flame ~ ~-0.5 ~ 0.6 0 0.6 0.02 6
scoreboard players operation #ib ch.tmp = #now ch.g
scoreboard players set #i_k ch.tmp 120
scoreboard players operation #ib ch.tmp %= #i_k ch.tmp
execute if score #ib ch.tmp matches 0 run playsound minecraft:block.lava.ambient ambient @a[distance=..90] ~ ~ ~ 2 0.5
execute if score #ib ch.tmp matches 60 run playsound chaoshearts:infernal_rumble ambient @a[distance=..90] ~ ~ ~ 0.6 0.6
