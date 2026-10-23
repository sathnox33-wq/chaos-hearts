# Airborne before the slam: an icy trail; on landing, the big nova.
scoreboard players remove @s ch.frozen.slam 1
scoreboard players remove @s ch.frozen.sl2 1
particle minecraft:snowflake ~ ~0.5 ~ 0.3 0.3 0.3 0.02 3
particle minecraft:dust{color:[0.61,0.91,1.0],scale:1.4} ~ ~0.5 ~ 0.2 0.3 0.2 0 2
execute if score @s ch.frozen.sl2 matches ..0 if predicate ch:on_ground run function ch:kit/frozen/nova/slam_land
