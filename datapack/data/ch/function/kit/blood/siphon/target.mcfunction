# One tethered target: breaks beyond 14 blocks or without line of sight, otherwise blood flows and every 10 ticks
# the caster drinks.
execute unless entity @a[tag=ch.caster,distance=..14,limit=1] run return run function ch:kit/blood/siphon/snap
scoreboard players set #los ch.tmp 1
scoreboard players set #ln ch.tmp 28
execute positioned ~ ~1 ~ facing entity @a[tag=ch.caster,limit=1] eyes run function ch:kit/blood/siphon/flow
execute if score #los ch.tmp matches 0 run return run function ch:kit/blood/siphon/snap
scoreboard players add #tc ch.tmp 1
execute if score #m ch.tmp matches 0 run function ch:kit/blood/siphon/sip
