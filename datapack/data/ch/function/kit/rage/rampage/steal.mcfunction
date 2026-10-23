# Rampage lifesteal: banks 15% (25% in Blood for Blood) of melee damage and drinks it in 2-heart gulps.
scoreboard players operation #ls ch.tmp = @s ch.rage.dealt
scoreboard players set #p ch.tmp 15
execute if score @s ch.rage.rv matches 2 run scoreboard players set #p ch.tmp 25
scoreboard players operation #ls ch.tmp *= #p ch.tmp
scoreboard players operation #ls ch.tmp /= #100 ch.g
scoreboard players operation @s ch.rage.ls += #ls ch.tmp
particle minecraft:dust{color:[0.88,0.15,0.17],scale:1.0} ~ ~1 ~ 0.3 0.4 0.3 0 6
execute if score @s ch.rage.ls matches 40.. run function ch:kit/rage/rampage/gulp
