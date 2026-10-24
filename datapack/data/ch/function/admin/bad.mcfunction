# Internal: an admin command's error message.
$tellraw @s [{text:"✖ ",color:"red"},{text:"$(m)",color:"red"}]
playsound minecraft:block.note_block.bass player @s ~ ~ ~ 0.6 0.7
return fail
