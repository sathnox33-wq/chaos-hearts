# The Supernova gathers: light implodes on Astrael over the centre, a rising chime counts down; then it bursts.
scoreboard players remove @s ch.celestial.tb3 1
execute at @e[type=marker,tag=ch.session,distance=..80,limit=1] run tp @s ~ ~7 ~
scoreboard players operation #ce_m ch.tmp = @s ch.celestial.tb3
scoreboard players operation #ce_m ch.tmp %= #10 ch.g
execute if score #ce_m ch.tmp matches 0 positioned ~ ~1.5 ~ rotated 0 0 run function ch:api/fx/sprite {model:"orb",color:16763210,s0:16.0,s1:1.0,t:10,life:11,spin:170,dy:0.0}
execute if score #ce_m ch.tmp matches 0 run playsound minecraft:block.note_block.chime master @a ~ ~ ~ 3 0.6
execute if score #ce_m ch.tmp matches 5 run particle minecraft:end_rod ~ ~1.5 ~ 6 6 6 0.05 60
execute if score #ce_m ch.tmp matches 0..2 run particle minecraft:reverse_portal ~ ~1.5 ~ 4 4 4 0.1 30
execute if score @s ch.celestial.tb3 matches 0 positioned ~ ~1.5 ~ run function ch:trials/celestial/nova_burst
execute if score @s ch.celestial.tb3 matches 0 run data merge entity @s {NoAI:0b}
