# Infernal aura (mastery 90): embers curl off your body and a faint ring of fire smoulders at your feet.
scoreboard players operation #i_m ch.tmp = #now ch.g
scoreboard players operation #i_m ch.tmp %= #4 ch.g
execute unless score #i_m ch.tmp matches 0 run return 0
execute if score @s ch.awake matches 1 run particle minecraft:soul_fire_flame ~ ~0.1 ~ 0.3 0 0.3 0.01 2
execute unless score @s ch.awake matches 1 run particle minecraft:flame ~ ~0.1 ~ 0.3 0 0.3 0.01 2
particle minecraft:small_flame ~ ~1.2 ~ 0.35 0.5 0.35 0.01 1
particle minecraft:ash ~ ~1.5 ~ 0.6 0.6 0.6 0 2
execute if score #t20 ch.g matches 0 run particle minecraft:lava ~ ~0.3 ~ 0.2 0 0.2 0 1
execute if score #t20 ch.g matches 0 unless score @s ch.awake matches 1 rotated 0 0 positioned ~ ~0.08 ~ run function ch:api/fx/sprite {model:"ring_soft",color:9182208,s0:1.2,s1:2.4,t:12,life:16,spin:120,dy:0.0}
execute if score #t20 ch.g matches 0 if score @s ch.awake matches 1 rotated 0 0 positioned ~ ~0.08 ~ run function ch:api/fx/sprite {model:"ring_soft",color:1723035,s0:1.2,s1:2.4,t:12,life:16,spin:120,dy:0.0}
