# Gorrath bleeds and grows angrier: phase 2 at 50% (he swells, meteors join), phase 3 at 20% (Bloodrage).
$scoreboard players set @s ch.v6 $(p)
execute if score @s ch.v6 matches 2 run function ch:trials/rage/phase2
execute if score @s ch.v6 matches 3 run function ch:trials/rage/phase3
