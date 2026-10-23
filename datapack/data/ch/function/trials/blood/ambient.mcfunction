# The sanctum's air (as the session, every tick): spores and drifting blood around the challenger, the challenger's
# open wounds (each second they bleed and Vesperine drinks), and the Blood Moon's glow in phase 3.
scoreboard players operation #r2 ch.tmp = #now ch.g
scoreboard players operation #r2 ch.tmp %= #2 ch.g
scoreboard players operation #m ch.tmp = #now ch.g
scoreboard players operation #m ch.tmp %= #4 ch.g
execute if score #m ch.tmp matches 0 at @a[tag=ch.challenger,distance=..60,limit=1] run particle minecraft:crimson_spore ~ ~2 ~ 8 2 8 0 20
execute if score #m ch.tmp matches 2 at @a[tag=ch.challenger,distance=..60,limit=1] run particle minecraft:dust{color:[0.62,0.04,0.12],scale:0.8} ~ ~4 ~ 8 2 8 0 8
execute if score #m ch.tmp matches 1 if entity @e[type=item_display,tag=ch.blood.tmoon,distance=..30,limit=1] run particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~14 ~ 14 1 14 0 20
execute as @a[tag=ch.challenger,distance=..60,scores={ch.blood.tbl=1..}] at @s run function ch:trials/blood/tbleed
