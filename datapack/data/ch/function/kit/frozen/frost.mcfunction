# As a Frozen player: adds #f_fg Frost (max 100); at 100 the next Ice Shard is a Glacial Lance.
execute if score @s ch.frozen.frost matches 100.. run return 0
scoreboard players operation @s ch.frozen.frost += #f_fg ch.tmp
execute if score @s ch.frozen.frost matches 100.. run function ch:kit/frozen/frost_full
