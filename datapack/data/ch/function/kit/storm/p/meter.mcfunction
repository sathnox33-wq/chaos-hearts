# The Static meter: how close the next arcing spark is.
scoreboard players set #every ch.storm.g 4
execute if score @s ch.b1 matches 4.. run scoreboard players set #every ch.storm.g 3
scoreboard players operation @s ch.meter = @s ch.storm.st
scoreboard players operation @s ch.meter *= #100 ch.g
scoreboard players operation @s ch.meter /= #every ch.storm.g
