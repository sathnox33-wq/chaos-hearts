# A sliding display moves ch.v6 tenths of a block along its facing, smoothed by its teleport duration.
tag @s remove ch.titan.slide
execute store result storage ch:tmp tsl.d float 0.1 run scoreboard players get @s ch.v6
function ch:kit/titan/fx/slide_go with storage ch:tmp tsl
