# Spike fans: lines of blood spikes ripple across the floor toward the challenger (three, five in phase 3).
playsound minecraft:entity.evoker.prepare_attack master @a[distance=..90] ~ ~ ~ 2 0.7
execute facing entity @a[tag=ch.challenger,distance=..80,limit=1] feet rotated ~ 0 run function ch:trials/blood/spike_line
execute facing entity @a[tag=ch.challenger,distance=..80,limit=1] feet rotated ~20 0 run function ch:trials/blood/spike_line
execute facing entity @a[tag=ch.challenger,distance=..80,limit=1] feet rotated ~-20 0 run function ch:trials/blood/spike_line
execute if score @s ch.v6 matches 3 facing entity @a[tag=ch.challenger,distance=..80,limit=1] feet rotated ~40 0 run function ch:trials/blood/spike_line
execute if score @s ch.v6 matches 3 facing entity @a[tag=ch.challenger,distance=..80,limit=1] feet rotated ~-40 0 run function ch:trials/blood/spike_line
