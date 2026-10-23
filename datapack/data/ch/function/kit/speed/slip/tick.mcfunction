# Slipstream, every tick as the runner: wake, distance, Phase Runner health, Tailwind, Vortex Lap.
scoreboard players remove @s ch.speed.slip 1
function ch:kit/speed/slip/dist
execute if score @s ch.b2 matches 5.. store result score @s ch.speed.hp run data get entity @s Health 1
execute unless score @s ch.speed.smode matches 2 if score #t2 ch.speed.g matches 0 run function ch:kit/speed/slip/drop
execute if score @s ch.speed.smode matches 2 run function ch:kit/speed/slip/vortex
execute if score @s ch.b3 matches 2.. if score #t20 ch.g matches 0 run function ch:kit/speed/p/tailwind
execute if score @s ch.speed.slip matches 0 if score @s ch.speed.smode matches 2 run function ch:kit/speed/slip/fling
