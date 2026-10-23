# As a frozen-solid entity, every tick: frost vapour; thaws when the time runs out.
scoreboard players remove @s ch.frozen.fz 1
execute if score #t20 ch.g matches 0 run particle minecraft:snowflake ~ ~1.2 ~ 0.3 0.5 0.3 0.01 3
execute if score @s ch.frozen.fz matches ..0 run function ch:kit/frozen/thaw
