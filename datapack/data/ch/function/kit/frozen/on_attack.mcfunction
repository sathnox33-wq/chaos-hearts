# Frostbite (mastery 25): melee hits stack Frostbite; at 5 stacks (4 with Biting Cold) the target freezes solid.
execute unless score @s ch.lvl matches 25.. run return 0
execute as @e[tag=ch.victim,limit=1] at @s run function ch:kit/frozen/bite
