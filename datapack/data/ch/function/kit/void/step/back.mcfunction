# Down: fold 9 blocks backwards (12 with Far Reach), away from whatever is in front of you.
scoreboard players set #vrs ch.tmp 18
execute if score @s ch.b1 matches 1.. run scoreboard players set #vrs ch.tmp 24
execute positioned ~ ~0.2 ~ rotated ~180 0 run function ch:kit/void/step/walk
