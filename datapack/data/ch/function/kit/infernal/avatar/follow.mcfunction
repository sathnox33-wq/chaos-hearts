# An Avatar follower, every tick: orbits, crowns or winds around its owner; vanishes when the Avatar ends.
tag @a remove ch.caster
function ch:api/tag_owner
execute unless entity @a[tag=ch.caster,scores={ch.infernal.av=1..},limit=1] run return run function ch:kit/infernal/avatar/fol_end
scoreboard players set #i_9 ch.tmp 9
scoreboard players set #i_120 ch.tmp 120
scoreboard players set #i_360 ch.tmp 360
scoreboard players operation #i_a ch.tmp = #now ch.g
scoreboard players operation #i_a ch.tmp *= #i_9 ch.tmp
scoreboard players operation #i_s ch.tmp = @s ch.v1
scoreboard players operation #i_s ch.tmp *= #i_120 ch.tmp
scoreboard players operation #i_a ch.tmp += #i_s ch.tmp
scoreboard players operation #i_a ch.tmp %= #i_360 ch.tmp
execute if score @s ch.v1 matches 0..3 store result entity @s Rotation[0] float 1 run scoreboard players get #i_a ch.tmp
execute if score @s ch.v1 matches 7 store result entity @s Rotation[0] float -1 run scoreboard players get #i_a ch.tmp
execute if score @s ch.v1 matches 0 at @a[tag=ch.caster,limit=1] rotated as @s rotated ~ 0 positioned ^ ^0.6 ^1.3 run tp @s ~ ~ ~
execute if score @s ch.v1 matches 1 at @a[tag=ch.caster,limit=1] rotated as @s rotated ~ 0 positioned ^ ^1.3 ^1.5 run tp @s ~ ~ ~
execute if score @s ch.v1 matches 2 at @a[tag=ch.caster,limit=1] rotated as @s rotated ~ 0 positioned ^ ^2.0 ^1.3 run tp @s ~ ~ ~
execute if score @s ch.v1 matches 3 at @a[tag=ch.caster,limit=1] run tp @s ~ ~0.08 ~
execute if score @s ch.v1 matches 7 at @a[tag=ch.caster,limit=1] run tp @s ~ ~0.15 ~
execute if score @s ch.v1 matches 4 at @a[tag=ch.caster,limit=1] rotated ~ 0 positioned ^ ^2.15 ^-0.45 run tp @s ~ ~ ~ ~ 90
execute if score @s ch.v1 matches 5 at @a[tag=ch.caster,limit=1] rotated ~ 0 positioned ^0.4 ^1.2 ^-0.35 run tp @s ~ ~ ~ ~25 -40
execute if score @s ch.v1 matches 6 at @a[tag=ch.caster,limit=1] rotated ~ 0 positioned ^-0.4 ^1.2 ^-0.35 run tp @s ~ ~ ~ ~-25 -40
execute if score @s ch.v1 matches 0..2 at @s run particle minecraft:flame ~ ~ ~ 0.05 0.05 0.05 0.01 1
tag @a remove ch.caster
