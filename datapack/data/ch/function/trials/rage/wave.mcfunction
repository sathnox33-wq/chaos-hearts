# Spawns wave $(n) of the Crucible.
$scoreboard players set #rw ch.tmp $(n)
execute if score #rw ch.tmp matches 1 run function ch:trials/rage/wave1
execute if score #rw ch.tmp matches 2 run function ch:trials/rage/wave2
execute if score #rw ch.tmp matches 3 run function ch:trials/rage/wave3
execute as @e[tag=ch.rage.new,distance=..60] run function ch:api/trial/adopt
execute as @e[tag=ch.rage.new,distance=..60] at @s run function ch:trials/rage/spawn_fx
tag @e[tag=ch.rage.new,distance=..60] remove ch.rage.new
playsound chaoshearts:trial_wave master @a[distance=..90] ~ ~ ~ 1 1
playsound minecraft:entity.ravager.roar master @a[distance=..90] ~ ~ ~ 1 0.8
