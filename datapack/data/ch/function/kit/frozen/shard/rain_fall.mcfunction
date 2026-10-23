# Icicles plunge into the circle; the impact lands 6 ticks later.
execute rotated 0 0 positioned ~0 ~9.6 ~0 run function ch:kit/frozen/shard/icicle
execute rotated 0 0 positioned ~1.5 ~9.6 ~0.5 run function ch:kit/frozen/shard/icicle
execute rotated 0 0 positioned ~-1.2 ~9.6 ~1.1 run function ch:kit/frozen/shard/icicle
execute rotated 0 0 positioned ~0.6 ~9.6 ~-1.5 run function ch:kit/frozen/shard/icicle
execute rotated 0 0 positioned ~-1.6 ~9.6 ~-0.6 run function ch:kit/frozen/shard/icicle
execute rotated 0 0 positioned ~1.0 ~9.6 ~1.7 run function ch:kit/frozen/shard/icicle
execute rotated 0 0 positioned ~-0.4 ~9.6 ~-2.0 run function ch:kit/frozen/shard/icicle
execute rotated 0 0 positioned ~2.1 ~9.6 ~-0.9 run function ch:kit/frozen/shard/icicle
playsound minecraft:entity.arrow.shoot player @a ~ ~8 ~ 1 0.5
function ch:api/later {t:6,then:"ch:kit/frozen/shard/rain_hit"}
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
