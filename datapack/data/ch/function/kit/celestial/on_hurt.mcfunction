# Celestial holder was hurt: during Ascension the light around them flares where the blow landed.
execute if score @s ch.celestial.asc matches 1.. run particle minecraft:end_rod ~ ~1.2 ~ 0.4 0.5 0.4 0.08 10
execute if score @s ch.celestial.asc matches 1.. run playsound minecraft:block.amethyst_block.hit player @a ~ ~ ~ 1 1.4
