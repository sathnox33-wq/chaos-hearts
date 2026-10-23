# Awakened: the halo crowns the Celestial (one per player, it follows them and dies if left behind).
scoreboard players set #ce_has ch.tmp 0
execute as @e[type=item_display,tag=ch.celestial.halo,distance=..5] if score @s ch.owner = #ce_pid ch.tmp run function ch:kit/celestial/fx/halo_follow
execute if score #ce_has ch.tmp matches 0 run function ch:kit/celestial/fx/halo_spawn
