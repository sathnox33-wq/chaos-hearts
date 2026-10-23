# Rage feeds on pain: damage taken builds Fury (6 plus 2 per point; +50% below half health; doubled by Pain Fuels Me,
# Blood for Blood and blows from Challenged enemies), then drives Retaliation, reflection, Undying Rage and the flash.
scoreboard players operation #pd ch.tmp = @s ch.rage.dmg
scoreboard players set @s ch.rage.dmg 0
scoreboard players operation #fa ch.tmp = #pd ch.tmp
scoreboard players operation #fa ch.tmp /= #5 ch.g
scoreboard players add #fa ch.tmp 6
execute if score @s ch.b2 matches 2.. run scoreboard players operation #fa ch.tmp *= #2 ch.g
execute if score @s ch.rage.rv matches 2 if score @s ch.rage.ramp matches 1.. run scoreboard players operation #fa ch.tmp *= #2 ch.g
execute if score @s ch.rage.cry matches 1.. on attacker if entity @s[tag=ch.rage.marked] run scoreboard players operation #fa ch.tmp *= #2 ch.g
execute store result score #hp ch.tmp run data get entity @s Health 10
scoreboard players operation #uh ch.tmp = #hp ch.tmp
execute store result score #mh ch.tmp run attribute @s minecraft:max_health get 5
execute if score #hp ch.tmp <= #mh ch.tmp run scoreboard players operation #fa ch.tmp *= #3 ch.rage.g
execute if score #hp ch.tmp <= #mh ch.tmp run scoreboard players operation #fa ch.tmp /= #2 ch.g
function ch:kit/rage/fury/add
function ch:kit/rage/pain_fx
execute if score @s ch.rage.bzm matches 1 if score @s ch.rage.bzt matches 1.. if score @s ch.rage.bz matches 1.. unless score @s ch.rage.rcd matches 1.. run function ch:kit/rage/berserk/retaliate
execute if score @s ch.rage.rv matches 2 if score @s ch.rage.ramp matches 1.. run function ch:kit/rage/rampage/reflect
execute if score @s ch.b2 matches 5.. if score #uh ch.tmp matches ..60 unless score @s ch.rage.und matches 1.. run function ch:kit/rage/undying
