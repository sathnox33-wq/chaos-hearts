# An eruption ring counting down; at zero its radius bursts.
scoreboard players remove @s ch.life 1
execute if score @s ch.life matches 1.. run return 0
execute if score @s ch.v1 matches 3 run function ch:trials/rage/burst3
execute if score @s ch.v1 matches 6 run function ch:trials/rage/burst6
execute if score @s ch.v1 matches 9 run function ch:trials/rage/burst9
execute if score @s ch.v1 matches 12 run function ch:trials/rage/burst12
execute if score @s ch.v1 matches 15 run function ch:trials/rage/burst15
kill @s
