# Generated: copies the active heart's level, awakening and tree into ch.lvl, ch.awake and ch.b1-3.
scoreboard players set @s ch.lvl 0
scoreboard players set @s ch.awake 0
scoreboard players set #tree ch.tmp 0
execute if score @s ch.active matches 1 run scoreboard players operation @s ch.lvl = @s ch.lvl.rage
execute if score @s ch.active matches 1 run scoreboard players operation @s ch.awake = @s ch.awk.rage
execute if score @s ch.active matches 1 run scoreboard players operation #tree ch.tmp = @s ch.tree.rage
execute if score @s ch.active matches 2 run scoreboard players operation @s ch.lvl = @s ch.lvl.speed
execute if score @s ch.active matches 2 run scoreboard players operation @s ch.awake = @s ch.awk.speed
execute if score @s ch.active matches 2 run scoreboard players operation #tree ch.tmp = @s ch.tree.speed
execute if score @s ch.active matches 3 run scoreboard players operation @s ch.lvl = @s ch.lvl.infernal
execute if score @s ch.active matches 3 run scoreboard players operation @s ch.awake = @s ch.awk.infernal
execute if score @s ch.active matches 3 run scoreboard players operation #tree ch.tmp = @s ch.tree.infernal
execute if score @s ch.active matches 4 run scoreboard players operation @s ch.lvl = @s ch.lvl.void
execute if score @s ch.active matches 4 run scoreboard players operation @s ch.awake = @s ch.awk.void
execute if score @s ch.active matches 4 run scoreboard players operation #tree ch.tmp = @s ch.tree.void
execute if score @s ch.active matches 5 run scoreboard players operation @s ch.lvl = @s ch.lvl.frozen
execute if score @s ch.active matches 5 run scoreboard players operation @s ch.awake = @s ch.awk.frozen
execute if score @s ch.active matches 5 run scoreboard players operation #tree ch.tmp = @s ch.tree.frozen
execute if score @s ch.active matches 6 run scoreboard players operation @s ch.lvl = @s ch.lvl.storm
execute if score @s ch.active matches 6 run scoreboard players operation @s ch.awake = @s ch.awk.storm
execute if score @s ch.active matches 6 run scoreboard players operation #tree ch.tmp = @s ch.tree.storm
execute if score @s ch.active matches 7 run scoreboard players operation @s ch.lvl = @s ch.lvl.blood
execute if score @s ch.active matches 7 run scoreboard players operation @s ch.awake = @s ch.awk.blood
execute if score @s ch.active matches 7 run scoreboard players operation #tree ch.tmp = @s ch.tree.blood
execute if score @s ch.active matches 8 run scoreboard players operation @s ch.lvl = @s ch.lvl.titan
execute if score @s ch.active matches 8 run scoreboard players operation @s ch.awake = @s ch.awk.titan
execute if score @s ch.active matches 8 run scoreboard players operation #tree ch.tmp = @s ch.tree.titan
execute if score @s ch.active matches 9 run scoreboard players operation @s ch.lvl = @s ch.lvl.celestial
execute if score @s ch.active matches 9 run scoreboard players operation @s ch.awake = @s ch.awk.celestial
execute if score @s ch.active matches 9 run scoreboard players operation #tree ch.tmp = @s ch.tree.celestial
execute if score @s ch.active matches 10 run scoreboard players operation @s ch.lvl = @s ch.lvl.corruption
execute if score @s ch.active matches 10 run scoreboard players operation @s ch.awake = @s ch.awk.corruption
execute if score @s ch.active matches 10 run scoreboard players operation #tree ch.tmp = @s ch.tree.corruption
scoreboard players operation @s ch.b1 = #tree ch.tmp
scoreboard players operation @s ch.b1 %= #10 ch.g
scoreboard players operation #tree ch.tmp /= #10 ch.g
scoreboard players operation @s ch.b2 = #tree ch.tmp
scoreboard players operation @s ch.b2 %= #10 ch.g
scoreboard players operation #tree ch.tmp /= #10 ch.g
scoreboard players operation @s ch.b3 = #tree ch.tmp
scoreboard players operation @s ch.b3 %= #10 ch.g
