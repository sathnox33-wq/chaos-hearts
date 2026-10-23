# Lifesteal percent into #rate ch.tmp: 10, 15 with Thirst, doubled at night with Night Feeder, at least 40 under the Blood Moon (inside it for Crimson Eclipse).
scoreboard players set #rate ch.tmp 10
execute if score @s ch.b1 matches 1.. run scoreboard players set #rate ch.tmp 15
execute store result score #tod ch.tmp run time query daytime
execute if score @s ch.b1 matches 3.. if score #tod ch.tmp matches 13000..23000 run scoreboard players operation #rate ch.tmp *= #2 ch.g
scoreboard players set #in ch.tmp 0
execute if score @s ch.blood.moon matches 1.. if score @s ch.blood.mv matches 0 run scoreboard players set #in ch.tmp 1
execute if score @s ch.blood.moon matches 1.. if score @s ch.blood.mv matches 1 if entity @e[type=marker,tag=ch.blood.moonv,distance=..14,limit=1] run scoreboard players set #in ch.tmp 1
execute if score #in ch.tmp matches 1 if score #rate ch.tmp matches ..39 run scoreboard players set #rate ch.tmp 40
