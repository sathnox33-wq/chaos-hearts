# The altar takes the challenger: they rise in a column of light while the world fades out.
effect give @s minecraft:levitation 1 3 true
effect give @s minecraft:blindness 3 0 true
effect give @s minecraft:resistance 3 4 true
scoreboard players operation #i ch.tmp = @s ch.active
function ch:gen/describe
function ch:trial/enter_fx2 with storage ch:tmp h
