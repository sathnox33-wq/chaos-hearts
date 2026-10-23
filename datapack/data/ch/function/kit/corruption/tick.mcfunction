# Corruption, every tick for the holder: Plagueborn, the Contagion meter, the aura.
effect clear @s minecraft:poison
effect clear @s minecraft:wither
execute if score @s ch.corruption.m matches 101.. run scoreboard players set @s ch.corruption.m 100
execute if score @s ch.corruption.mt matches 1.. run scoreboard players remove @s ch.corruption.mt 1
execute if score @s ch.corruption.mt matches ..0 if score @s ch.corruption.m matches 1.. if score #t20 ch.g matches 0 run scoreboard players remove @s ch.corruption.m 3
execute if score @s ch.corruption.m matches ..-1 run scoreboard players set @s ch.corruption.m 0
scoreboard players operation @s ch.meter = @s ch.corruption.m
execute if score @s ch.corruption.m matches 100 unless entity @s[tag=ch.corruption.full] run function ch:kit/corruption/full
execute if score @s ch.corruption.m matches ..99 run tag @s remove ch.corruption.full
execute if entity @s[tag=ch.corruption.full] if score #t20 ch.g matches 0 run particle minecraft:dust{color:[0.643,1.0,0.31],scale:1.2} ~ ~1.2 ~ 0.35 0.5 0.35 0 6
execute if score @s ch.lvl matches 90.. run function ch:kit/corruption/aura
