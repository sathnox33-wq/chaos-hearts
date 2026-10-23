# Every 5 ticks: a ring of light at the edge (radius $(r)), motes rising, a chime once a second.
$function ch:api/fx/ring {p:"minecraft:end_rod",r:$(r)}
$particle minecraft:wax_off ~ ~0.6 ~ $(r) 0.4 $(r) 0 4
$particle minecraft:dust{color:[1.0,0.827,0.42],scale:1.2} ~ ~0.2 ~ $(r) 0.1 $(r) 0 6
execute if score @s ch.v2 matches 2 run particle minecraft:dust{color:[1.0,0.6,0.2],scale:1.4} ~ ~0.3 ~ 2 0.2 2 0 6
scoreboard players operation #ce_m ch.tmp = @s ch.v4
scoreboard players operation #ce_m ch.tmp %= #20 ch.g
execute if score #ce_m ch.tmp matches 0 run playsound minecraft:block.amethyst_block.chime player @a ~ ~ ~ 0.8 1.4
