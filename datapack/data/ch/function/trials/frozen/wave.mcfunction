# Spawns wave $(n).
$scoreboard players set #fw ch.tmp $(n)
execute if score #fw ch.tmp matches 1 run function ch:trials/frozen/wave1
execute if score #fw ch.tmp matches 2 run function ch:trials/frozen/wave2
execute if score #fw ch.tmp matches 3 run function ch:trials/frozen/wave3
playsound chaoshearts:trial_wave master @a[distance=..90] ~ ~ ~ 1 1
