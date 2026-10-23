# Void aura (mastery 90): space bends around you; awakened, a starless shadow pools at your feet.
scoreboard players operation #vt ch.tmp = #now ch.g
scoreboard players operation #vt ch.tmp %= #4 ch.g
execute if score #vt ch.tmp matches 0 run particle minecraft:portal ~ ~1 ~ 0.3 0.5 0.3 0.4 3
execute if score #vt ch.tmp matches 2 run particle minecraft:dust{color:[0.541,0.235,1.0],scale:0.8} ~ ~0.2 ~ 0.4 0.05 0.4 0 2
execute if score #t20 ch.g matches 0 positioned ~ ~0.05 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring_soft",color:1310763,s0:0.4,s1:2.2,t:18,life:20,spin:90,dy:0.0}
execute if score @s ch.awake matches 1 if score #vt ch.tmp matches 1 run particle minecraft:dust{color:[0.039,0.0,0.078],scale:1.6} ~ ~0.1 ~ 0.35 0 0.35 0 2
execute if score @s ch.awake matches 1 if score #t20 ch.g matches 10 run particle minecraft:reverse_portal ~ ~1.8 ~ 0.2 0.1 0.2 0.02 6
