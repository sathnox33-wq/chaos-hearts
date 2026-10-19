# The player now holds heart $(id) of type $(h) / index $(i). Registry must already say held by them.
$scoreboard players add @s ch.cnt.$(h) 1
scoreboard players add #seq ch.g 1
$scoreboard players operation @s ch.own.$(h) = #seq ch.g
$scoreboard players add @s ch.xp.$(h) 0
$scoreboard players add @s ch.lvl.$(h) 0
$scoreboard players add @s ch.awk.$(h) 0
$scoreboard players add @s ch.tree.$(h) 0
$execute unless score @s ch.active matches 1.. run function ch:heart/set_active {i:$(i)}
$scoreboard players set #i ch.tmp $(i)
function ch:gen/describe
function ch:heart/gain_fx with storage ch:tmp h
function ch:core/player/max_health
