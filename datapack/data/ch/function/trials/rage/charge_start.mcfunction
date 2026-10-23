# Charge windup: Gorrath lowers his horns toward the challenger; the lane is painted on the ground for 20 ticks.
scoreboard players set @s ch.v5 0
execute if score @s ch.v6 matches 3 run scoreboard players set @s ch.v5 1
function ch:trials/rage/charge_aim
function ch:trials/rage/say {m:"Gorrath lowers his horns! Get out of the lane!"}
