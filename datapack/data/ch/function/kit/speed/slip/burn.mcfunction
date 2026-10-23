# As an enemy in the Afterburner wake.
scoreboard players set #d ch.speed.g 25
function ch:kit/speed/fn/hit
particle minecraft:flame ~ ~0.5 ~ 0.3 0.4 0.3 0.02 6
particle minecraft:electric_spark ~ ~1 ~ 0.3 0.4 0.3 0.1 6
