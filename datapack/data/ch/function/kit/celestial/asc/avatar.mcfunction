# Avatar: once a second a ring of six small stars falls around the Celestial, and nearby allies are mended.
function ch:kit/celestial/asc/setstar
scoreboard players set #ce_d ch.tmp 35
scoreboard players set #ce_r ch.tmp 18
tag @s add ch.caster
execute rotated 0 0 positioned ^ ^ ^5 run function ch:kit/celestial/star/drop
execute rotated 60 0 positioned ^ ^ ^5 run function ch:kit/celestial/star/drop
execute rotated 120 0 positioned ^ ^ ^5 run function ch:kit/celestial/star/drop
execute rotated 180 0 positioned ^ ^ ^5 run function ch:kit/celestial/star/drop
execute rotated 240 0 positioned ^ ^ ^5 run function ch:kit/celestial/star/drop
execute rotated 300 0 positioned ^ ^ ^5 run function ch:kit/celestial/star/drop
function ch:api/heal {n:2}
execute as @a[tag=!ch.caster,distance=..6,gamemode=!spectator] unless score @s ch.opp = #ce_pid ch.tmp run function ch:api/heal {n:2}
tag @s remove ch.caster
execute positioned ~ ~0.1 ~ run function ch:api/fx/ring {p:"minecraft:end_rod",r:5}
particle minecraft:totem_of_undying ~ ~1.2 ~ 0.4 0.6 0.4 0.1 10
