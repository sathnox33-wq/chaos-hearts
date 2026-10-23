# One Lightning Strike impact (as its later marker): the bolt, damage, Skyfall, Thunder God, Forked Bolt, Thunderstorm.
function ch:kit/storm/fn/bolt
scoreboard players operation #d ch.storm.g = @s ch.v1
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..2.4] at @s run function ch:kit/storm/ls/hit
execute positioned ~ ~1 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..2.4] unless predicate ch:on_ground as @a[tag=ch.caster,limit=1] run function ch:api/feat {h:"storm",n:0}
execute if score @s ch.v3 matches 0 if entity @a[tag=ch.caster,scores={ch.awake=1},limit=1] run function ch:kit/storm/ls/charge_ground
execute if score @s ch.v3 matches 0 if entity @a[tag=ch.caster,scores={ch.b1=2..},limit=1] run function ch:kit/storm/ls/fork
execute if score @s ch.v4 matches 1 run function ch:kit/storm/ls/march
