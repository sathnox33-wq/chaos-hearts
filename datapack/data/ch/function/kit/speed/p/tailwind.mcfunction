# Tailwind: allies near you (players not fighting you) get Speed II while your Slipstream runs.
scoreboard players operation #pid ch.speed.g = @s ch.pid
execute as @a[distance=0.1..6,gamemode=!spectator] run function ch:kit/speed/p/tailwind_one
