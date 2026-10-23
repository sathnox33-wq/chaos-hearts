# Chooses her next cast: tether, spike fans, Crimson Step, crimson rain (phase 2+), blood bolts (phase 3).
scoreboard players add @s ch.t 1
scoreboard players operation #a ch.tmp = @s ch.t
scoreboard players operation #a ch.tmp %= #4 ch.g
scoreboard players set @s ch.v4 70
execute if score @s ch.v6 matches 2 run scoreboard players set @s ch.v4 60
execute if score @s ch.v6 matches 3 run scoreboard players set @s ch.v4 45
execute if score #a ch.tmp matches 0 if score @s ch.v3 matches 1.. run scoreboard players set #a ch.tmp 1
execute if score #a ch.tmp matches 0 run function ch:trials/blood/tether_start
execute if score #a ch.tmp matches 1 run function ch:trials/blood/spikes
execute if score #a ch.tmp matches 2 if score @s ch.v6 matches 2.. run function ch:trials/blood/rain
execute if score #a ch.tmp matches 2 unless score @s ch.v6 matches 2.. run function ch:trials/blood/spikes
execute if score #a ch.tmp matches 3 run function ch:trials/blood/step
execute if score #a ch.tmp matches 3 if score @s ch.v6 matches 3 run function ch:trials/blood/bolts
