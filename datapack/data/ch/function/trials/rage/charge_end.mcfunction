# The charge ends; in Bloodrage he turns and charges again at once.
scoreboard players set @s ch.v2 0
function ch:trials/rage/unfreeze
tag @a remove ch.rage.hitc
kill @e[type=marker,tag=ch.rage.bdir,distance=..40]
execute if score @s ch.v5 matches 1.. run scoreboard players remove @s ch.v5 1
execute if score @s ch.v5 matches 0.. if score @s ch.v6 matches 3 if score @s ch.v4 matches 30.. run return run function ch:trials/rage/charge_aim
