# One tethered enemy: a crackling line to its owner; straying past 7 blocks snaps it.
scoreboard players remove @s ch.storm.teth 1
execute if score @s ch.storm.teth matches 1.. run scoreboard players set #teth ch.storm.g 1
scoreboard players operation #o ch.storm.g = @s ch.storm.tow
tag @a remove ch.storm.tw
execute as @a if score @s ch.pid = #o ch.storm.g run tag @s add ch.storm.tw
execute unless entity @a[tag=ch.storm.tw,distance=..40,limit=1] run return run scoreboard players set @s ch.storm.teth 0
execute if score #t2 ch.storm.g matches 0 facing entity @a[tag=ch.storm.tw,limit=1] feet run function ch:kit/storm/chain/tether_line
execute unless entity @a[tag=ch.storm.tw,distance=..7,limit=1] run function ch:kit/storm/chain/snap
tag @a remove ch.storm.tw
