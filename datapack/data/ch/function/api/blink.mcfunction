# As a player: teleports up to d blocks along the look, stopping before walls, with an afterimage left behind.
$scoreboard players set #rs ch.tmp $(d)
scoreboard players operation #rs ch.tmp *= #2 ch.g
particle minecraft:reverse_portal ~ ~1 ~ 0.3 0.6 0.3 0.05 40
execute at @s positioned ~ ~0.2 ~ rotated ~ 0 run function ch:api/blink_step
