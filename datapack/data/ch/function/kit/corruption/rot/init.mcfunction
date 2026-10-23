# As a new rot field: variant, radius, Withering, Sticky Mire, Necrosis; the ground decals.
tag @s remove ch.corruption.rnew
function ch:api/own
function ch:api/new_eid
scoreboard players operation @s ch.v1 = #cvar ch.tmp
scoreboard players set @s ch.life 120
scoreboard players set @s ch.v2 50
execute if entity @a[tag=ch.caster,scores={ch.b2=1..},limit=1] run scoreboard players set @s ch.v2 65
execute if score #cvar ch.tmp matches 1 run scoreboard players operation @s ch.v2 *= #7 ch.corruption.k
execute if score #cvar ch.tmp matches 1 run scoreboard players operation @s ch.v2 /= #10 ch.g
execute store success score @s ch.v3 if entity @a[tag=ch.caster,scores={ch.b2=2..},limit=1]
execute store success score @s ch.v4 if entity @a[tag=ch.caster,scores={ch.b2=3..},limit=1]
execute store success score @s ch.v6 if entity @a[tag=ch.caster,scores={ch.b1=4..},limit=1]
scoreboard players set @s ch.t 0
execute unless score #cvar ch.tmp matches 1 run function ch:kit/corruption/rot/decal
execute if score #cvar ch.tmp matches 2 run function ch:kit/corruption/rot/mire_warn
