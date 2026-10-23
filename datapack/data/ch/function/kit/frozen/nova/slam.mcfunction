# Frost Nova, up: a gust launches you skyward; when you land the nova is 8 blocks wide (+30% damage).
function ch:api/leap {n:2}
scoreboard players set @s ch.frozen.slam 80
scoreboard players set @s ch.frozen.sl2 8
execute rotated 0 0 run function ch:api/fx/wave {color:10217471,r:2.5,t:4}
particle minecraft:snowflake ~ ~ ~ 0.5 0.2 0.5 0.1 30
playsound minecraft:entity.breeze.jump player @a ~ ~ ~ 1 0.8
return 1
