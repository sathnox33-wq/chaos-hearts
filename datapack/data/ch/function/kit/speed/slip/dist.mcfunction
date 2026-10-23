# Adds the distance run this tick (centimetres, octagonal estimate) toward the Afterburner feat.
execute store result score #x ch.speed.g run data get entity @s Pos[0] 100
execute store result score #z ch.speed.g run data get entity @s Pos[2] 100
scoreboard players operation #dx ch.speed.g = #x ch.speed.g
scoreboard players operation #dx ch.speed.g -= @s ch.speed.px
scoreboard players operation #dz ch.speed.g = #z ch.speed.g
scoreboard players operation #dz ch.speed.g -= @s ch.speed.pz
scoreboard players operation @s ch.speed.px = #x ch.speed.g
scoreboard players operation @s ch.speed.pz = #z ch.speed.g
execute if score #dx ch.speed.g matches ..-1 run scoreboard players operation #dx ch.speed.g *= #-1 ch.g
execute if score #dz ch.speed.g matches ..-1 run scoreboard players operation #dz ch.speed.g *= #-1 ch.g
execute if score #dx ch.speed.g matches 800.. run return 0
execute if score #dz ch.speed.g matches 800.. run return 0
scoreboard players operation #hi ch.speed.g = #dx ch.speed.g
scoreboard players operation #hi ch.speed.g > #dz ch.speed.g
scoreboard players operation #lo ch.speed.g = #dx ch.speed.g
scoreboard players operation #lo ch.speed.g < #dz ch.speed.g
scoreboard players operation #lo ch.speed.g *= #c4 ch.speed.g
scoreboard players operation #lo ch.speed.g /= #c10 ch.speed.g
scoreboard players operation #hi ch.speed.g += #lo ch.speed.g
scoreboard players operation @s ch.speed.dist += #hi ch.speed.g
execute if score @s ch.speed.dist matches 200000.. run function ch:kit/speed/slip/feat
