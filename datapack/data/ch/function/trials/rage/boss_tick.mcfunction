# Gorrath's brain, every tick: the halo spins, fury smoulders, and he runs one attack at a time.
# ch.v2: 0 free, 1 charge windup, 2 charging, 3 roar windup, 4 dazed after a wall crash. ch.v4: ticks to next attack.
scoreboard players add @s ch.v1 1
scoreboard players operation #m ch.tmp = @s ch.v1
scoreboard players operation #m ch.tmp %= #5 ch.g
execute if score #m ch.tmp matches 0 run function ch:trials/rage/boss_aura
execute if score @s ch.v2 matches 1 run return run function ch:trials/rage/charge_wind
execute if score @s ch.v2 matches 2 run return run function ch:trials/rage/charge_run
execute if score @s ch.v2 matches 3 run return run function ch:trials/rage/roar_wind
execute if score @s ch.v2 matches 4 run return run function ch:trials/rage/dazed
execute as @e[type=marker,tag=ch.rage.met,distance=..64] at @s run function ch:trials/rage/met_tick
execute as @e[type=marker,tag=ch.rage.ring,distance=..64] at @s run function ch:trials/rage/ring_tick
scoreboard players remove @s ch.v4 1
execute if score @s ch.v4 matches ..0 run function ch:trials/rage/pick
