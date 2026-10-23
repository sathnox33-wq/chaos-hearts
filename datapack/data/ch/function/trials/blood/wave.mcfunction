# Spawns wave $(n) of the Communion.
$scoreboard players set #bw ch.tmp $(n)
execute if score #bw ch.tmp matches 1 run function ch:trials/blood/wave1
execute if score #bw ch.tmp matches 2 run function ch:trials/blood/wave2
execute if score #bw ch.tmp matches 3 run function ch:trials/blood/wave3
execute as @e[tag=ch.blood.new,distance=..60] run function ch:api/trial/adopt
execute as @e[tag=ch.blood.new,distance=..60] at @s run function ch:trials/blood/spawn_fx
tag @e[tag=ch.blood.new,distance=..60] remove ch.blood.new
playsound chaoshearts:trial_wave master @a[distance=..90] ~ ~ ~ 1 1
playsound minecraft:entity.warden.heartbeat master @a[distance=..90] ~ ~ ~ 1.5 0.7
