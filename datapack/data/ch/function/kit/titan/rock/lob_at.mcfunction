# The target spot (World Breaker adds two more 3 blocks to each side).
scoreboard players set #ti_found ch.tmp 1
execute as @a[tag=ch.caster,limit=1] run function ch:kit/titan/rock/lob_set
execute if entity @a[tag=ch.caster,scores={ch.b3=5..},limit=1] positioned ~3 ~ ~1 as @a[tag=ch.caster,limit=1] run function ch:kit/titan/rock/lob_set
execute if entity @a[tag=ch.caster,scores={ch.b3=5..},limit=1] positioned ~-3 ~ ~-1 as @a[tag=ch.caster,limit=1] run function ch:kit/titan/rock/lob_set
