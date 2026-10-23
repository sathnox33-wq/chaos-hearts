# As an Infernal player: adds #i_hg Heat (max 100) and announces Overheat when it fills.
execute if score @s ch.infernal.heat matches 100.. run return 0
scoreboard players operation @s ch.infernal.heat += #i_hg ch.tmp
execute if score @s ch.infernal.heat matches 100.. run function ch:kit/infernal/heat_full
