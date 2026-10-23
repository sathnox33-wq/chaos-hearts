# Corruption aura (mastery 90): rot drips off you; awakened, spores bloom in the air.
scoreboard players operation #ct ch.tmp = #now ch.g
scoreboard players operation #ct ch.tmp %= #8 ch.g
execute if score #ct ch.tmp matches 0 run particle minecraft:dust{color:[0.482,0.82,0.227],scale:0.8} ~ ~0.1 ~ 0.4 0 0.4 0 2
execute if score #ct ch.tmp matches 4 run particle minecraft:dust{color:[0.239,0.102,0.322],scale:0.9} ~ ~0.1 ~ 0.4 0 0.4 0 2
execute if score #ct ch.tmp matches 2 run particle minecraft:sculk_soul ~ ~1 ~ 0.3 0.4 0.3 0.01 1
execute if score #t20 ch.g matches 0 positioned ~ ~0.05 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:2046478,s0:0.6,s1:2.0,t:18,life:20,spin:60,dy:0.0}
execute if score @s ch.awake matches 1 if score #ct ch.tmp matches 6 run particle minecraft:spore_blossom_air ~ ~1 ~ 0.6 0.6 0.6 0 2
