# Seraph Dive (phase 2+): Astrael soars up; a circle closes on the challenger's spot, then it crashes down there.
scoreboard players set @s ch.v3 150
scoreboard players set @s ch.v6 26
data merge entity @s {NoAI:1b}
tp @s ~ ~7 ~
function ch:trials/celestial/callout {m:"Astrael soars... it will crash where the circle closes!"}
playsound minecraft:entity.phantom.flap master @a ~ ~ ~ 2 0.5
particle minecraft:end_rod ~ ~ ~ 0.5 3 0.5 0.1 40
execute at @a[tag=ch.challenger,limit=1] positioned ~ 100 ~ run function ch:trials/celestial/dive_mark
