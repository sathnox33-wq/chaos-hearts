# While Stone Skin holds: counts what it resisted (Immovable), runs the shell, sheds stone, keeps the shards orbiting.
scoreboard players remove @s ch.titan.skin 1
execute if score @s ch.titan.skm matches ..1 run scoreboard players operation @s ch.titan.imm += @s ch.titan.res
execute if score @s ch.titan.imm matches 2000.. run function ch:kit/titan/skin/feat
execute if score @s ch.titan.skm matches 1 run function ch:kit/titan/skin/shell_tick
execute if score #ti_t4 ch.tmp matches 0 run particle minecraft:block{block_state:"minecraft:stone"} ~ ~1 ~ 0.35 0.6 0.35 0 3
execute if score @s ch.titan.res matches 1.. run function ch:kit/titan/skin/absorb_fx
execute as @e[type=item_display,tag=ch.titan.orbit,distance=..8] if score @s ch.owner = #ti_pid ch.tmp run function ch:kit/titan/fx/orbit
execute if score @s ch.titan.skin matches 0 run function ch:kit/titan/skin/end
