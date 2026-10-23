# The blizzard breaks.
particle minecraft:snowflake ~ ~2 ~ 4 2 4 0.1 60
playsound minecraft:block.powder_snow.break player @a ~ ~ ~ 1.4 1.2
tag @a remove ch.caster
kill @s
