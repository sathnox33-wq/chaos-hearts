# As something inside the fracture: mobs nearly freeze, everyone glitters and accrues time debt.
effect give @s[type=!player,tag=!ch.boss] minecraft:slowness 1 5 true
effect give @s[type=!player,tag=!ch.boss] minecraft:mining_fatigue 1 2 true
scoreboard players add @s ch.speed.debt 1
particle minecraft:dust{color:[0.16,0.83,0.95],scale:0.7} ~ ~1 ~ 0.3 0.5 0.3 0 6
particle minecraft:reverse_portal ~ ~1 ~ 0.3 0.5 0.3 0.01 4
