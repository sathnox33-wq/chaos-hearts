# Stone Skin ends: footing returns, the shards fall, and an Obsidian Shell bursts.
attribute @s minecraft:knockback_resistance modifier remove ch:titan_skin
execute if score @s ch.titan.skm matches 1 run function ch:kit/titan/skin/shell_burst
attribute @s minecraft:movement_speed modifier remove ch:titan_shell
attribute @s minecraft:jump_strength modifier remove ch:titan_shell
scoreboard players set @s ch.titan.skin 0
scoreboard players operation #ti_pid ch.tmp = @s ch.pid
execute as @e[type=item_display,tag=ch.titan.orbit,distance=..10] if score @s ch.owner = #ti_pid ch.tmp run kill @s
particle minecraft:block{block_state:"minecraft:stone"} ~ ~1 ~ 0.4 0.7 0.4 0.1 30
playsound minecraft:block.stone.break player @a ~ ~ ~ 1 0.7
