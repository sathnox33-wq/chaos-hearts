# Spawns wave $(n).
$scoreboard players set #iw ch.tmp $(n)
execute if score #iw ch.tmp matches 1 run function ch:trials/infernal/wave1
execute if score #iw ch.tmp matches 2 run function ch:trials/infernal/wave2
execute if score #iw ch.tmp matches 3 run function ch:trials/infernal/wave3
playsound chaoshearts:trial_wave master @a[distance=..90] ~ ~ ~ 1 1
