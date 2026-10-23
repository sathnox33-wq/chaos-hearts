# Rage Leap touchdown: the slam. Full damage near the centre, 70% at the edge; everything is launched.
# Level: radius 4, 6 dmg. Skyfall: radius 6, 6 dmg + 0.5 per block fallen (max 15). Wrathfall: radius 6, 9 + 0.3 per block.
scoreboard players set @s ch.rage.leap 0
scoreboard players set @s ch.rage.air 0
scoreboard players set @s ch.rage.hang 0
scoreboard players set @s ch.rage.safe 10
effect clear @s minecraft:slow_falling
scoreboard players set #ld ch.tmp 60
execute unless score @s ch.rage.lv matches 0 run function ch:kit/rage/leap/height
execute if score @s ch.b1 matches 1.. run scoreboard players operation #ld ch.tmp *= #12 ch.rage.g
execute if score @s ch.b1 matches 1.. run scoreboard players operation #ld ch.tmp /= #10 ch.g
execute store result storage ch:tmp rage.d int 1 run scoreboard players get #ld ch.tmp
scoreboard players operation #ld ch.tmp *= #7 ch.rage.g
scoreboard players operation #ld ch.tmp /= #10 ch.g
execute store result storage ch:tmp rage.e int 1 run scoreboard players get #ld ch.tmp
scoreboard players set #hits ch.tmp 0
tag @s add ch.caster
execute if score @s ch.rage.lv matches 0 as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..2] run function ch:kit/rage/leap/hit with storage ch:tmp rage
execute if score @s ch.rage.lv matches 0 as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=2.01..4] run function ch:kit/rage/leap/hit_edge with storage ch:tmp rage
execute unless score @s ch.rage.lv matches 0 as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..3] run function ch:kit/rage/leap/hit with storage ch:tmp rage
execute unless score @s ch.rage.lv matches 0 as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=3.01..6] run function ch:kit/rage/leap/hit_edge with storage ch:tmp rage
tag @s remove ch.caster
execute if score #hits ch.tmp matches 3.. run function ch:api/feat {h:"rage",n:0}
scoreboard players operation #fa ch.tmp = #hits ch.tmp
scoreboard players operation #fa ch.tmp *= #3 ch.rage.g
execute if score @s ch.b3 matches 4.. run scoreboard players add #fa ch.tmp 25
function ch:kit/rage/fury/add
execute if score @s ch.rage.lv matches 0 run function ch:kit/rage/leap/fx_small
execute unless score @s ch.rage.lv matches 0 run function ch:kit/rage/leap/fx_big
execute if score @s ch.rage.lv matches 3 run function ch:kit/rage/rampage/wrath_land
execute unless score @s ch.rage.lv matches 3 if score @s ch.b1 matches 5.. unless score @s ch.rage.avu matches 1.. run function ch:kit/rage/leap/avalanche
