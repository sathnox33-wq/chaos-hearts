# Charging: 1.15 blocks a tick down the lane; whoever is caught takes 11 and is flung. A wall stops him cold.
scoreboard players remove @s ch.v3 1
execute rotated as @e[type=marker,tag=ch.rage.bdir,distance=..40,limit=1] rotated ~ 0 unless block ^ ^0.6 ^2 #ch:passable run return run function ch:trials/rage/crash
execute rotated as @e[type=marker,tag=ch.rage.bdir,distance=..40,limit=1] rotated ~ 0 unless block ^ ^1.6 ^2 #ch:passable run return run function ch:trials/rage/crash
execute rotated as @e[type=marker,tag=ch.rage.bdir,distance=..40,limit=1] rotated ~ 0 run tp @s ^ ^ ^1.15 ~ 0
particle minecraft:campfire_cosy_smoke ~ ~0.3 ~ 0.5 0.1 0.5 0.02 3
particle minecraft:block{block_state:"minecraft:blackstone"} ~ ~0.2 ~ 0.6 0.1 0.6 0.2 6
particle minecraft:flame ~ ~1.5 ~ 0.6 0.6 0.6 0.02 3
execute if score #m ch.tmp matches 0 run playsound minecraft:entity.ravager.step master @a[distance=..90] ~ ~ ~ 2 0.6
tag @s add ch.caster
execute as @a[tag=ch.challenger,tag=!ch.rage.hitc,distance=..2.9] run function ch:trials/rage/charge_hit
tag @s remove ch.caster
execute if score @s ch.v3 matches ..0 run function ch:trials/rage/charge_end
