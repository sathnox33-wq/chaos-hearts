# Rampage, every tick: a double helix of blood and shadow, effect upkeep, the last-two-seconds warning.
scoreboard players remove @s ch.rage.ramp 1
execute if score #r2 ch.tmp matches 0 unless score @s ch.rage.rv matches 2 run function ch:kit/rage/rampage/helix_a
execute if score #r2 ch.tmp matches 0 if score @s ch.rage.rv matches 2 run function ch:kit/rage/rampage/helix_b
execute if score #r4 ch.tmp matches 1 run particle minecraft:flame ~ ~0.2 ~ 0.3 0.05 0.3 0.02 2
scoreboard players operation #m ch.tmp = @s ch.rage.ramp
scoreboard players operation #m ch.tmp %= #20 ch.g
execute if score #m ch.tmp matches 0 run function ch:kit/rage/rampage/buffs
execute if score @s ch.rage.ramp matches 40 run playsound minecraft:block.note_block.basedrum player @s ~ ~ ~ 1 0.6
execute if score @s ch.rage.ramp matches 20 run playsound minecraft:block.note_block.basedrum player @s ~ ~ ~ 1 0.5
execute if score @s ch.rage.ramp matches 0 run function ch:kit/rage/rampage/end
