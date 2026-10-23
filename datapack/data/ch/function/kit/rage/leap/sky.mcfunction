# Skyfall: rocket straight up; the dive is triggered at the top of the climb.
scoreboard players set @s ch.rage.lv 1
scoreboard players set @s ch.rage.leap 80
function ch:kit/rage/leap/start
execute rotated ~ -90 run function ch:api/leap {n:3}
function ch:api/fx/pillar {model:"beam",color:14689835,w:0.9,h:9.0,t:4,life:12}
particle minecraft:explosion ~ ~0.3 ~ 0.3 0.1 0.3 0 2
particle minecraft:flame ~ ~0.3 ~ 0.3 0.1 0.3 0.15 20
playsound minecraft:entity.firework_rocket.launch player @a ~ ~ ~ 1.2 0.6
playsound minecraft:entity.wind_charge.wind_burst player @a ~ ~ ~ 1 0.6
