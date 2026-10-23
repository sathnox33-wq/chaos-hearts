# Mirror Feint: the decoy sprints forward, swelling with light, until it hits a wall or its run ends.
scoreboard players remove @s ch.v1 1
particle minecraft:cloud ~ ~0.3 ~ 0.2 0.1 0.2 0.02 2
particle minecraft:electric_spark ~ ~1 ~ 0.3 0.5 0.3 0.1 3
execute rotated as @s positioned ^ ^ ^0.8 unless block ~ ~ ~ #ch:passable run scoreboard players set @s ch.v1 0
execute rotated as @s positioned ^ ^ ^0.8 unless block ~ ~1 ~ #ch:passable run scoreboard players set @s ch.v1 0
execute if score @s ch.v1 matches 1.. rotated as @s run tp @s ^ ^ ^0.8
execute if score @s ch.v1 matches 0 run scoreboard players set @s ch.life 6
execute if score @s ch.v1 matches 0 run playsound chaoshearts:trial_telegraph player @a ~ ~ ~ 0.8 1.8
execute if score @s ch.v1 matches 0 positioned ~ ~1 ~ run function ch:api/fx/orb {color:16113986,s:1.4,t:6,life:8}
