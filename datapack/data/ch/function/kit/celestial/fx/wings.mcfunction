# Keeps the wings of light on the Celestial (spawned once, refreshed each tick).
scoreboard players operation #ce_flap ch.tmp = #now ch.g
scoreboard players operation #ce_flap ch.tmp /= #10 ch.g
scoreboard players operation #ce_flap ch.tmp %= #2 ch.g
scoreboard players set #ce_has ch.tmp 0
execute as @e[type=item_display,tag=ch.celestial.wing,distance=..6] if score @s ch.owner = #ce_pid ch.tmp run scoreboard players set #ce_has ch.tmp 1
execute if score #ce_has ch.tmp matches 0 run function ch:kit/celestial/fx/wings_spawn
execute as @e[type=item_display,tag=ch.celestial.wing,distance=..6] if score @s ch.owner = #ce_pid ch.tmp run function ch:kit/celestial/fx/feather
