# Absolute: kills during Absolute Zero.
execute unless score @s ch.frozen.zero matches 1.. run return 0
scoreboard players add @s ch.frozen.zk 1
execute if score @s ch.frozen.zk matches 2.. run function ch:api/feat {h:"frozen",n:3}
