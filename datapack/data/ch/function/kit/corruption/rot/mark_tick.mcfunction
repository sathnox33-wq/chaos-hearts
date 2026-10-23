# As an enemy marked as standing in rot: the mark fades 12 ticks after it leaves.
scoreboard players remove @s ch.corruption.rt 1
execute if score @s ch.corruption.rt matches ..0 run tag @s remove ch.corruption.inrot
