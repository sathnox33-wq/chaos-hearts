# Ascension ends: gravity returns gently; awakened, it ends in a Supernova.
attribute @s minecraft:gravity modifier remove ch:celestial_hover
effect clear @s minecraft:levitation
scoreboard players set @s ch.celestial.asc 0
execute unless score @s ch.celestial.ascm matches 2 run effect give @s minecraft:slow_falling 4 0 true
scoreboard players operation #ce_pid ch.tmp = @s ch.pid
execute as @e[type=item_display,tag=ch.celestial.wing,distance=..8] if score @s ch.owner = #ce_pid ch.tmp run kill @s
particle minecraft:end_rod ~ ~1 ~ 0.5 0.8 0.5 0.05 30
playsound minecraft:block.beacon.deactivate player @a ~ ~ ~ 1.2 1.2
execute if score @s ch.awake matches 1 run function ch:kit/celestial/asc/nova_charge
