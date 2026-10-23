# The rotling bites: 3 damage and plague.
scoreboard players set @s ch.v1 16
scoreboard players set #cd ch.tmp 30
scoreboard players set #cnec ch.tmp 0
execute as @e[tag=ch.corruption.lt,limit=1] run function ch:kit/corruption/hurt
execute as @e[tag=ch.corruption.lt,limit=1] run function ch:kit/corruption/poison {sec:3,amp:0}
playsound minecraft:entity.zombie.attack_wooden_door player @a ~ ~ ~ 0.4 1.6
playsound minecraft:entity.husk.ambient player @a ~ ~ ~ 0.6 0.7
particle minecraft:item_slime ^ ^1 ^0.8 0.2 0.2 0.2 0.05 6
