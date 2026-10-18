# An ability came off cooldown.
playsound minecraft:block.note_block.chime player @s ~ ~ ~ 0.4 1.8
$execute if score @s ch.cdm$(s) matches 200.. run playsound minecraft:block.amethyst_block.chime player @s ~ ~ ~ 0.8 1.2
