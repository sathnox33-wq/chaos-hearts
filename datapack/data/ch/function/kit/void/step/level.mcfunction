# Level: aimed at an enemy you step out behind its back; otherwise you fold forward along the ground.
scoreboard players set #vrs ch.tmp 28
execute if score @s ch.b1 matches 1.. run scoreboard players set #vrs ch.tmp 36
execute if score @s ch.b1 matches 1.. run function ch:api/ray {range:20}
execute unless score @s ch.b1 matches 1.. run function ch:api/ray {range:15}
execute if score #rayhit ch.tmp matches 1 if entity @e[tag=ch.target,limit=1] run return run function ch:kit/void/step/aimed
execute positioned ~ ~0.2 ~ rotated ~ 0 run function ch:kit/void/step/walk
