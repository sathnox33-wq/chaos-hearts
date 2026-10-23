# Frozen per-player tick: Frost meter, Coldborn frost-walking, Absolute Zero timer, Frost Nova slam landing, aura, health tracking.
scoreboard players operation @s ch.meter = @s ch.frozen.frost
execute if score #t20 ch.g matches 0 if score @s ch.frozen.frost matches 1..99 run scoreboard players remove @s ch.frozen.frost 1
execute if score @s ch.frozen.frost matches 100.. run particle minecraft:snowflake ~ ~1.2 ~ 0.3 0.5 0.3 0.01 1
scoreboard players operation #f_m ch.tmp = #now ch.g
scoreboard players operation #f_m ch.tmp %= #2 ch.g
execute if score #f_m ch.tmp matches 0 unless predicate ch:input/sneak if predicate ch:on_ground run function ch:kit/frozen/frostwalk
execute if score @s ch.frozen.zero matches 1.. run scoreboard players remove @s ch.frozen.zero 1
execute if score @s ch.frozen.slam matches 1.. run function ch:kit/frozen/nova/slam_tick
execute if score @s ch.lvl matches 90.. run function ch:kit/frozen/aura
execute store result score @s ch.frozen.hp run data get entity @s Health 10
