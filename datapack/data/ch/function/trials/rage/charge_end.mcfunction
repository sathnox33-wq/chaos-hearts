# The charge ends; in Bloodrage he turns and charges again at once.
scoreboard players set @s ch.v2 0
function ch:trials/rage/unfreeze
tag @a remove ch.rage.hitc
kill @e[type=marker,tag=ch.rage.bdir,distance=..40]
scoreboard players remove @s ch.v5 1
execute if score @s ch.v5 matches 0.. run function ch:trials/rage/charge_aim
