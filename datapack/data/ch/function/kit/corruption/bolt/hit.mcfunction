# The bolt strikes an enemy: its damage and a dose of plague (the cloud follows from the end function).
scoreboard players operation #cd ch.tmp = @s ch.v4
scoreboard players operation #cnec ch.tmp = @s ch.v6
execute as @e[tag=ch.target] run function ch:kit/corruption/hurt
execute as @e[tag=ch.target] run function ch:kit/corruption/poison {sec:4,amp:0}
execute if score @s ch.v2 matches 1 as @e[tag=ch.target] run function ch:kit/corruption/afflict {e:"wither",sec:4,amp:1}
