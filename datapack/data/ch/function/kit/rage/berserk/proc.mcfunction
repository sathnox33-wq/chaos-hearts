# A charged Berserk hit: spends a charge and sends a shockwave from the victim that grows with every link.
scoreboard players remove @s ch.rage.bz 1
scoreboard players add @s ch.rage.cnt 1
scoreboard players operation #bc ch.tmp = @s ch.rage.cnt
scoreboard players set #bd ch.tmp 15
execute if score @s ch.b1 matches 2.. run scoreboard players set #bd ch.tmp 19
execute if score #bc ch.tmp matches 3.. run scoreboard players operation #bd ch.tmp *= #2 ch.g
scoreboard players operation #cl ch.tmp = @s ch.b1
scoreboard players set #fa ch.tmp 6
function ch:kit/rage/fury/add
execute as @e[tag=ch.victim,limit=1] at @s run function ch:kit/rage/berserk/shock
execute if score @s ch.rage.bz matches ..0 run function ch:kit/rage/berserk/end
