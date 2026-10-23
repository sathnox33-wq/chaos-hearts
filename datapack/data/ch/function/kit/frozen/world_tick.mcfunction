# Frozen world tick: ice blocks, the Glacier Ram, implosions, blizzards and frozen-solid enemies.
execute if entity @e[type=marker,tag=ch.frozen.ice,limit=1] as @e[type=marker,tag=ch.frozen.ice] at @s run function ch:kit/frozen/wall/blk
execute if entity @e[type=block_display,tag=ch.frozen.ram,limit=1] as @e[type=block_display,tag=ch.frozen.ram] at @s run function ch:kit/frozen/wall/ram_tick
execute if entity @e[type=marker,tag=ch.frozen.imp,limit=1] as @e[type=marker,tag=ch.frozen.imp] at @s run function ch:kit/frozen/nova/imp_tick
execute if entity @e[type=marker,tag=ch.frozen.storm,limit=1] as @e[type=marker,tag=ch.frozen.storm] at @s run function ch:kit/frozen/zero/storm
execute if entity @e[tag=ch.frozen.solid,limit=1] as @e[tag=ch.frozen.solid] at @s run function ch:kit/frozen/solid_tick
