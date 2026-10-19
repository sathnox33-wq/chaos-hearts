# Ends the cinematic: the challenger stands in the arena with the Trial Ward in the off hand.
spectate
execute as @a[tag=ch.challenger,limit=1] run spectate
kill @e[type=item_display,tag=ch.cam,distance=..60]
gamemode adventure @a[tag=ch.challenger,limit=1]
execute as @a[tag=ch.challenger,limit=1] run tp @s ~ ~1 ~-12 facing ~ ~1 ~
execute as @a[tag=ch.challenger,limit=1] run function ch:trial/ward
effect give @a[tag=ch.challenger,limit=1] minecraft:instant_health 1 4 true
effect give @a[tag=ch.challenger,limit=1] minecraft:saturation 1 10 true
$scoreboard players set #s$(s) ch.state 3
$scoreboard players set #s$(s) ch.t 0
$scoreboard players set #s$(s) ch.v1 0
