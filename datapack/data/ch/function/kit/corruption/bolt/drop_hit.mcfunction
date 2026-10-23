# Later: a plague drop splashes - 2 damage and a small cloud.
scoreboard players set #cd ch.tmp 20
scoreboard players operation #cnec ch.tmp = @s ch.v1
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..2,limit=6] run function ch:kit/corruption/hurt
particle minecraft:item_slime ~ ~0.3 ~ 0.4 0.2 0.4 0.1 12
particle minecraft:dust{color:[0.482,0.82,0.227],scale:1.6} ~ ~0.3 ~ 0.5 0.3 0.5 0 12
playsound minecraft:entity.slime.squish_small player @a ~ ~ ~ 1 0.7
scoreboard players set #crad ch.tmp 20
scoreboard players set #clife ch.tmp 40
scoreboard players set #camp ch.tmp 0
scoreboard players set #cwit ch.tmp 0
execute positioned ~ ~0.5 ~ run function ch:kit/corruption/cloud/spawn
