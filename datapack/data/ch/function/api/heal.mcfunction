# As a living entity: heals about n half hearts (instant health bursts for the bulk, regeneration for the rest).
$scoreboard players set #h ch.tmp $(n)
execute if entity @s[type=#ch:undead] run return fail
execute if score #h ch.tmp matches 8.. run effect give @s minecraft:instant_health 1 1 true
execute if score #h ch.tmp matches 8.. run scoreboard players remove #h ch.tmp 8
execute if score #h ch.tmp matches 4.. run effect give @s minecraft:instant_health 1 0 true
execute if score #h ch.tmp matches 4.. run scoreboard players remove #h ch.tmp 4
execute if score #h ch.tmp matches 1.. run effect give @s minecraft:regeneration 2 2 true
particle minecraft:heart ~ ~1.8 ~ 0.3 0.2 0.3 0 3
