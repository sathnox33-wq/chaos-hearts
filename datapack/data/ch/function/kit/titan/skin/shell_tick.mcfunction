# Obsidian Shell: stores what it absorbed; in its last 15 ticks it cracks with ember light as a warning.
scoreboard players operation @s ch.titan.abs += @s ch.titan.res
execute if score #ti_t4 ch.tmp matches 0 run particle minecraft:dust{color:[0.17,0.12,0.24],scale:1.6} ~ ~1 ~ 0.6 0.8 0.6 0 8
execute if score @s ch.titan.skin matches 15 run playsound minecraft:entity.warden.sonic_charge player @a ~ ~ ~ 1 1.2
execute if score @s ch.titan.skin matches 15 run function ch:api/fx/text {text:"!",color:"#FF7A2A"}
execute if score @s ch.titan.skin matches ..15 run particle minecraft:lava ~ ~1 ~ 0.5 0.6 0.5 0 1
execute if score @s ch.titan.skin matches ..15 run particle minecraft:dust{color:[1.0,0.478,0.165],scale:1.4} ~ ~1 ~ 0.8 0.9 0.8 0 6
execute if score @s ch.titan.skin matches 10 positioned ~ ~1 ~ rotated 0 90 run function ch:api/fx/sprite {model:"crack",color:16742954,s0:0.5,s1:2.2,t:4,life:12,spin:0,dy:0.0}
execute if score @s ch.titan.skin matches 6 positioned ~ ~1 ~ rotated 90 90 run function ch:api/fx/sprite {model:"crack",color:16742954,s0:0.5,s1:2.4,t:3,life:8,spin:0,dy:0.0}
