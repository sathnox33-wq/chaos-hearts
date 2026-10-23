# Ball Lightning lashes out.
scoreboard players set #d ch.storm.g 20
playsound minecraft:block.copper_bulb.turn_on player @a ~ ~ ~ 1 1.8
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..4.5,limit=3,sort=nearest] at @s run function ch:kit/storm/chain/ball_one
