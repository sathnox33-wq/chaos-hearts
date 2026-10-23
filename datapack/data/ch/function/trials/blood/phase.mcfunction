# Vesperine grows hungrier: phase 2 at 50% (the rain begins), phase 3 at 20% (the Blood Moon rises over the sanctum).
$scoreboard players set @s ch.v6 $(p)
execute if score @s ch.v6 matches 2 run function ch:trials/blood/phase2
execute if score @s ch.v6 matches 3 run function ch:trials/blood/phase3
