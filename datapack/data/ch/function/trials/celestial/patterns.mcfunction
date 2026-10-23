# Picks Astrael's next attack: Starfall barrage, Radiant Beam, Seraph Dive (phase 2), Sanctuary shield (phase 2), Supernova (phase 3).
scoreboard players remove @s ch.v1 1
scoreboard players remove @s ch.v2 1
execute if score @s ch.v1 matches ..0 run return run function ch:trials/celestial/barrage
execute if score @s ch.v2 matches ..0 run return run function ch:trials/celestial/beam
execute if score @s ch.phase matches 2.. run scoreboard players remove @s ch.v3 1
execute if score @s ch.phase matches 2.. if score @s ch.v3 matches ..0 run return run function ch:trials/celestial/dive
execute if score @s ch.phase matches 2.. run scoreboard players remove @s ch.celestial.tb1 1
execute if score @s ch.phase matches 2.. if score @s ch.celestial.tb1 matches ..0 unless score @s ch.v4 matches 1.. run function ch:trials/celestial/shield
execute if score @s ch.phase matches 3.. run scoreboard players remove @s ch.celestial.tb2 1
execute if score @s ch.phase matches 3.. if score @s ch.celestial.tb2 matches ..0 run function ch:trials/celestial/nova
