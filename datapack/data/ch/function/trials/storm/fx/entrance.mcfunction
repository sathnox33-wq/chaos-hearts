# Voltaris descends with three bolts.
function ch:kit/storm/fn/bolt
execute positioned ~1.5 ~ ~1 run function ch:kit/storm/fn/bolt
execute positioned ~-1.5 ~ ~-1 run function ch:kit/storm/fn/bolt
particle minecraft:electric_spark ~ ~2 ~ 1.2 2 1.2 0.3 120
playsound chaoshearts:storm_thunder master @a[distance=..80] ~ ~ ~ 2 0.7
