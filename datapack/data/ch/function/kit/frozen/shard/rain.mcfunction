# Ice Shard, up: marks the spot you aim at (30 blocks); 14 ticks later icicles plunge from the sky.
function ch:api/ray {range:30}
tag @e[tag=ch.target] remove ch.target
execute at @e[type=marker,tag=ch.rayend,limit=1,sort=nearest] run summon minecraft:marker ~ ~ ~ {Tags:["ch.frozen.gm","ch.noability"]}
scoreboard players set #f_sn ch.tmp 12
execute as @e[type=marker,tag=ch.frozen.gm,limit=1] at @s run function ch:kit/frozen/gs
execute at @e[type=marker,tag=ch.frozen.gm,limit=1] align y run function ch:kit/frozen/shard/rain_mark
kill @e[type=marker,tag=ch.frozen.gm]
execute anchored eyes positioned ^ ^ ^1 run particle minecraft:snowflake ~ ~ ~ 0.2 0.2 0.2 0.05 12
playsound minecraft:entity.snow_golem.shoot player @a ~ ~ ~ 0.8 0.5
return 1
