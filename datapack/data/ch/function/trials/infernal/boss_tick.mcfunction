# Ignaroth, every tick: decorations, his hazards, and the attack cycle of the current phase.
tag @s add ch.infernal.bself
scoreboard players add @s ch.infernal.bt 1
execute as @e[type=item_display,tag=ch.infernal.bdeco,distance=..60] run function ch:trials/infernal/deco
execute as @e[type=block_display,tag=ch.infernal.tmet,distance=..90] at @s run function ch:trials/infernal/met_fall
execute as @e[type=marker,tag=ch.infernal.twave,distance=..90] at @s run function ch:trials/infernal/wave_tick
execute as @e[type=marker,tag=ch.infernal.tdash,distance=..90] at @s run function ch:trials/infernal/dash_tick
execute as @e[type=marker,tag=ch.infernal.tgate,distance=..90] at @s run function ch:trials/infernal/gate_tick
scoreboard players operation #ib ch.tmp = @s ch.infernal.bt
scoreboard players operation #ib ch.tmp %= #4 ch.g
execute if score #ib ch.tmp matches 0 run particle minecraft:flame ~ ~2.5 ~ 0.6 1.2 0.6 0.02 5
execute if score #ib ch.tmp matches 2 run particle minecraft:lava ~ ~2 ~ 0.5 0.8 0.5 0 1
execute if score @s ch.infernal.ph matches ..1 run function ch:trials/infernal/cycle1
execute if score @s ch.infernal.ph matches 2 run function ch:trials/infernal/cycle2
execute if score @s ch.infernal.ph matches 3.. run function ch:trials/infernal/cycle3
tag @s remove ch.infernal.bself
