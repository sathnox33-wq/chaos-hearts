# As a chain marker: find the nearest enemy within 7 blocks this chain has not struck, and jump to it.
execute unless entity @a[tag=ch.caster,limit=1] run return 0
scoreboard players operation #v1 ch.storm.g = @s ch.v1
scoreboard players operation #v2 ch.storm.g = @s ch.v2
scoreboard players operation #v3 ch.storm.g = @s ch.v3
scoreboard players operation #v4 ch.storm.g = @s ch.v4
tag @e[tag=ch.storm.cx] remove ch.storm.cx
execute as @e[type=!#ch:ignore,distance=..9] if score @s ch.storm.cid = #v2 ch.storm.g run tag @s add ch.storm.cx
tag @e[tag=ch.storm.nx] remove ch.storm.nx
tag @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,tag=!ch.storm.cx,distance=..7,sort=nearest,limit=1] add ch.storm.nx
tag @e[tag=ch.storm.cx] remove ch.storm.cx
execute if entity @e[tag=ch.storm.nx,limit=1] run function ch:kit/storm/chain/jump
