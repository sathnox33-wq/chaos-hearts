# Haven: health the owner regains inside their sanctuary is counted.
scoreboard players operation #ce_h ch.tmp = @s ch.health
scoreboard players operation #ce_h ch.tmp -= @s ch.celestial.hp
execute if score #ce_h ch.tmp matches 1.. run scoreboard players operation @s ch.celestial.hv += #ce_h ch.tmp
scoreboard players operation @s ch.celestial.hp = @s ch.health
execute if score @s ch.celestial.hv matches 40.. run function ch:api/feat {h:"celestial",n:1}
