# Rage melee: spends Berserk Chain charges and applies Executioner.
execute if score @s ch.rage.bz matches 1.. if score @s ch.rage.bzm matches 0 if score @s ch.rage.bzt matches 1.. run function ch:kit/rage/berserk/proc
execute if score @s ch.b1 matches 4.. as @e[tag=ch.victim,limit=1] at @s run function ch:kit/rage/exec/check
