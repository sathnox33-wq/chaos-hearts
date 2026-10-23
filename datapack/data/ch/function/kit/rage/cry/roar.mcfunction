# The War Cry itself, as the caster.
scoreboard players set #emp ch.tmp 0
execute if score @s ch.rage.fury matches 30.. run scoreboard players set #emp ch.tmp 1
scoreboard players set #fs ch.tmp 30
execute if score #emp ch.tmp matches 1 run function ch:kit/rage/fury/spend
execute if score #emp ch.tmp matches 0 run effect give @s minecraft:strength 6 0
execute if score #emp ch.tmp matches 1 run effect give @s minecraft:strength 6 1
execute if score @s ch.b2 matches 4.. run effect give @s minecraft:resistance 5 0
scoreboard players set #wk ch.tmp 0
scoreboard players set #hits ch.tmp 0
scoreboard players operation #me ch.tmp = @s ch.pid
tag @s add ch.caster
execute if score @s ch.b3 matches 2.. run function ch:kit/rage/cry/tag_allies
execute if score @s ch.b3 matches 1.. as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,tag=!ch.rage.ally,distance=..10.4] run function ch:kit/rage/cry/weaken
execute unless score @s ch.b3 matches 1.. as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,tag=!ch.rage.ally,distance=..8] run function ch:kit/rage/cry/weaken
execute as @a[tag=ch.rage.ally] run function ch:kit/rage/cry/ally
tag @a remove ch.rage.ally
tag @s remove ch.caster
execute if score #wk ch.tmp matches 5.. run function ch:api/feat {h:"rage",n:2}
execute if score @s ch.b3 matches 5.. run function ch:kit/rage/banner/plant
execute if score @s ch.b3 matches 1.. run function ch:kit/rage/cry/fx {r:10.4,e:"#E0262B"}
execute unless score @s ch.b3 matches 1.. run function ch:kit/rage/cry/fx {r:8.0,e:"#E0262B"}
execute if score #emp ch.tmp matches 1 run function ch:kit/rage/cry/fx_emp
