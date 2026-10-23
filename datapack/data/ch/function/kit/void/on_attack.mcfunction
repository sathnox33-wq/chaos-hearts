# Void melee: Null Touch shrouds the victim in Darkness (mastery 25); Ambush tears a second cut after a Void Step.
execute if score @s ch.lvl matches 25.. as @e[tag=ch.victim,limit=1] at @s run function ch:kit/void/touch
execute if score @s ch.void.st matches 1.. if score @s ch.b1 matches 4.. run function ch:kit/void/ambush
