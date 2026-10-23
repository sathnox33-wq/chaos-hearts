# Chooses the next attack in a rotation that grows with the phase.
scoreboard players add @s ch.t 1
scoreboard players operation #a ch.tmp = @s ch.t
scoreboard players operation #a ch.tmp %= #4 ch.g
scoreboard players set @s ch.v4 70
execute if score @s ch.v6 matches 2 run scoreboard players set @s ch.v4 55
execute if score @s ch.v6 matches 3 run scoreboard players set @s ch.v4 40
execute if score #a ch.tmp matches 2 unless score @s ch.v6 matches 2.. run scoreboard players set #a ch.tmp 0
execute if score #a ch.tmp matches 3 unless score @s ch.v6 matches 3 run scoreboard players set #a ch.tmp 1
execute if score #a ch.tmp matches 0 run return run function ch:trials/rage/charge_start
execute if score #a ch.tmp matches 1 run return run function ch:trials/rage/roar_start
execute if score #a ch.tmp matches 2 run return run function ch:trials/rage/meteors
execute if score #a ch.tmp matches 3 run return run function ch:trials/rage/eruption
