# Corruption: Decomposition feat - count enemies that died while standing in your Rot Ground.
scoreboard players operation #cme ch.tmp = @s ch.pid
scoreboard players set #cnow ch.tmp 0
execute as @e[tag=ch.corruption.inrot,distance=..64] if score @s ch.corruption.ro = #cme ch.tmp run scoreboard players add #cnow ch.tmp 1
execute unless score @s ch.corruption.rn matches 1.. run return 0
execute if score #cnow ch.tmp >= @s ch.corruption.rn run return 0
scoreboard players operation #cd2 ch.tmp = @s ch.corruption.rn
scoreboard players operation #cd2 ch.tmp -= #cnow ch.tmp
scoreboard players operation @s ch.corruption.rk += #cd2 ch.tmp
scoreboard players operation @s ch.corruption.rn = #cnow ch.tmp
execute if score @s ch.corruption.rk matches 10.. run function ch:api/feat {h:"corruption",n:1}
