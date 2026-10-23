# As a target, at it: Infernal damage (#i_dmg), then sets it alight for #i_ft ticks and flashes a player's screen.
execute store result score #i_ok ch.tmp run function ch:kit/infernal/hurt
execute if score #i_ok ch.tmp matches 0 run return fail
function ch:kit/infernal/ignite
execute if entity @s[type=player] run function ch:kit/infernal/hurt_screen with storage ch:tmp ki
particle minecraft:flame ~ ~1 ~ 0.25 0.4 0.25 0.04 8
return 1
