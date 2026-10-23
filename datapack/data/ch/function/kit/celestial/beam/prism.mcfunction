# Prism: at the first enemy hit the beam splits into two half-strength beams at 35 degrees, half as long.
scoreboard players operation #ce_d ch.tmp /= #2 ch.g
scoreboard players set #ce_first ch.tmp 1
scoreboard players set #ce_max ch.tmp 28
tag @e[type=!#ch:ignore,distance=..2] add ch.celestial.bt
scoreboard players set #ce_n ch.tmp 0
execute rotated ~35 ~ positioned ^ ^ ^0.6 run function ch:kit/celestial/beam/march
execute store result storage ch:tmp cb.len float 0.5 run scoreboard players get #ce_n ch.tmp
execute rotated ~35 ~ positioned ^ ^ ^0.6 run function ch:kit/celestial/beam/draw with storage ch:tmp cb
scoreboard players set #ce_n ch.tmp 0
execute rotated ~-35 ~ positioned ^ ^ ^0.6 run function ch:kit/celestial/beam/march
execute store result storage ch:tmp cb.len float 0.5 run scoreboard players get #ce_n ch.tmp
execute rotated ~-35 ~ positioned ^ ^ ^0.6 run function ch:kit/celestial/beam/draw with storage ch:tmp cb
execute positioned ~ ~-1 ~ run tag @e[type=!#ch:ignore,distance=..2.5] remove ch.celestial.bt
execute as @e[tag=ch.celestial.bt] at @s run function ch:kit/celestial/beam/hurt
tag @e[tag=ch.celestial.bt] remove ch.celestial.bt
function ch:api/fx/orb {color:10259711,s:2.2,t:2,life:6}
playsound minecraft:block.amethyst_cluster.break player @a ~ ~ ~ 1.2 1.8
