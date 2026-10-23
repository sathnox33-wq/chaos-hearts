# Tether running.
scoreboard players remove @s ch.v3 1
scoreboard players set #los ch.tmp 1
scoreboard players set #ln ch.tmp 34
execute if score #r2 ch.tmp matches 0 positioned ~ ~2.4 ~ facing entity @a[tag=ch.challenger,distance=..15,limit=1] eyes run function ch:trials/blood/tether_flow
execute if score #r2 ch.tmp matches 1 positioned ~ ~2.4 ~ facing entity @a[tag=ch.challenger,distance=..15,limit=1] eyes run function ch:trials/blood/tether_check
execute unless entity @a[tag=ch.challenger,distance=..15,limit=1] run scoreboard players set #los ch.tmp 0
execute if score #los ch.tmp matches 0 run return run function ch:trials/blood/tether_snap
scoreboard players operation #m ch.tmp = @s ch.v3
scoreboard players operation #m ch.tmp %= #10 ch.g
execute if score @s ch.v3 matches ..60 if score #m ch.tmp matches 0 run function ch:trials/blood/tether_drain
