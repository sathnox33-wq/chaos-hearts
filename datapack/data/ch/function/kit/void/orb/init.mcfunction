# As a new orb, caster tagged: snapshot the variant and the Gravity branch.
tag @s remove ch.void.onew
function ch:api/own
function ch:api/new_eid
scoreboard players operation @s ch.v1 = #vvar ch.tmp
scoreboard players set @s ch.life 60
execute if score #vvar ch.tmp matches 1 run scoreboard players set @s ch.life 70
execute if score #vvar ch.tmp matches 2 run scoreboard players set @s ch.life 200
execute if entity @a[tag=ch.caster,scores={ch.b2=4..},limit=1] run scoreboard players operation @s ch.life *= #3 ch.void.k
execute if entity @a[tag=ch.caster,scores={ch.b2=4..},limit=1] run scoreboard players operation @s ch.life /= #2 ch.g
scoreboard players set @s ch.v2 200
execute if entity @a[tag=ch.caster,scores={ch.b2=1..},limit=1] run scoreboard players set @s ch.v2 280
scoreboard players set @s ch.v4 20
execute if entity @a[tag=ch.caster,scores={ch.b2=2..},limit=1] run scoreboard players set @s ch.v4 26
scoreboard players set @s ch.v3 0
execute store success score @s ch.v5 if entity @a[tag=ch.caster,scores={ch.b2=5..},limit=1]
execute store success score @s ch.v6 if entity @a[tag=ch.caster,scores={ch.b3=4..},limit=1]
scoreboard players set @s ch.t 0
