# Seeking Flame: turns the fireball a little toward its locked target each tick.
scoreboard players operation #i_e ch.tmp = @s ch.v5
execute as @e[type=!#ch:ignore,distance=..40] if score @s ch.eid = #i_e ch.tmp run tag @s add ch.infernal.st
execute unless entity @e[tag=ch.infernal.st,limit=1] run return run scoreboard players set @s ch.v5 0
execute positioned ^ ^ ^3 facing entity @e[tag=ch.infernal.st,limit=1] eyes positioned ^ ^ ^1.2 run summon marker ~ ~ ~ {Tags:["ch.infernal.aim","ch.noability"]}
execute facing entity @e[type=marker,tag=ch.infernal.aim,limit=1,sort=nearest] feet run tp @s ~ ~ ~ ~ ~
kill @e[type=marker,tag=ch.infernal.aim]
tag @e[tag=ch.infernal.st] remove ch.infernal.st
