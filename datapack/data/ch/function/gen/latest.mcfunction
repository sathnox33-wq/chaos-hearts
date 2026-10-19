# Generated: finds the most recently acquired heart (#bestidx ch.tmp, 0 if none).
scoreboard players set #best ch.tmp 0
scoreboard players set #bestidx ch.tmp 0
execute if score @s ch.own.rage > #best ch.tmp run scoreboard players set #bestidx ch.tmp 1
execute if score @s ch.own.rage > #best ch.tmp run scoreboard players operation #best ch.tmp = @s ch.own.rage
execute if score @s ch.own.speed > #best ch.tmp run scoreboard players set #bestidx ch.tmp 2
execute if score @s ch.own.speed > #best ch.tmp run scoreboard players operation #best ch.tmp = @s ch.own.speed
execute if score @s ch.own.infernal > #best ch.tmp run scoreboard players set #bestidx ch.tmp 3
execute if score @s ch.own.infernal > #best ch.tmp run scoreboard players operation #best ch.tmp = @s ch.own.infernal
execute if score @s ch.own.void > #best ch.tmp run scoreboard players set #bestidx ch.tmp 4
execute if score @s ch.own.void > #best ch.tmp run scoreboard players operation #best ch.tmp = @s ch.own.void
execute if score @s ch.own.frozen > #best ch.tmp run scoreboard players set #bestidx ch.tmp 5
execute if score @s ch.own.frozen > #best ch.tmp run scoreboard players operation #best ch.tmp = @s ch.own.frozen
execute if score @s ch.own.storm > #best ch.tmp run scoreboard players set #bestidx ch.tmp 6
execute if score @s ch.own.storm > #best ch.tmp run scoreboard players operation #best ch.tmp = @s ch.own.storm
execute if score @s ch.own.blood > #best ch.tmp run scoreboard players set #bestidx ch.tmp 7
execute if score @s ch.own.blood > #best ch.tmp run scoreboard players operation #best ch.tmp = @s ch.own.blood
execute if score @s ch.own.titan > #best ch.tmp run scoreboard players set #bestidx ch.tmp 8
execute if score @s ch.own.titan > #best ch.tmp run scoreboard players operation #best ch.tmp = @s ch.own.titan
execute if score @s ch.own.celestial > #best ch.tmp run scoreboard players set #bestidx ch.tmp 9
execute if score @s ch.own.celestial > #best ch.tmp run scoreboard players operation #best ch.tmp = @s ch.own.celestial
execute if score @s ch.own.corruption > #best ch.tmp run scoreboard players set #bestidx ch.tmp 10
execute if score @s ch.own.corruption > #best ch.tmp run scoreboard players operation #best ch.tmp = @s ch.own.corruption
