# The blizzard field, every tick (it follows its owner in Eye of the Storm).
tag @a remove ch.caster
function ch:api/tag_owner
scoreboard players remove @s ch.life 1
scoreboard players add @s ch.v3 1
execute if score @s ch.life matches ..0 run return run function ch:kit/frozen/zero/end
execute if score @s ch.v2 matches 1 if entity @a[tag=ch.caster,limit=1] run tp @s @a[tag=ch.caster,limit=1]
execute if score @s ch.v1 matches 0 run data modify storage ch:tmp kz set value {r:10.0,rs:6.0,dia:20.0}
execute if score @s ch.v1 matches 1 run data modify storage ch:tmp kz set value {r:12.5,rs:7.5,dia:25.0}
execute if score @s ch.v1 matches 2 run data modify storage ch:tmp kz set value {r:7.0,rs:4.2,dia:14.0}
execute if score @s ch.v1 matches 3 run data modify storage ch:tmp kz set value {r:8.75,rs:5.2,dia:17.5}
execute at @s run function ch:kit/frozen/zero/storm2 with storage ch:tmp kz
tag @a remove ch.caster
