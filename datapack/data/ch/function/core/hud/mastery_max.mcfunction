# Mastery dock at level 100: all pips lit; awakened hearts show Ascension progress toward the next skill point.
scoreboard players set #pips ch.tmp 7
scoreboard players set #lb ch.tmp 7
scoreboard players set #pn ch.tmp 1
scoreboard players set #pd ch.tmp 1
execute unless score @s ch.awake matches 1 run return 0
scoreboard players set #lb ch.tmp 8
scoreboard players operation #pn ch.tmp = #ma ch.tmp
scoreboard players operation #pn ch.tmp %= #asc_per_pt ch.cfg
scoreboard players operation #pd ch.tmp = #asc_per_pt ch.cfg
execute if score #mp ch.tmp >= #max_pts ch.cfg run scoreboard players set #lb ch.tmp 9
execute if score #mp ch.tmp >= #max_pts ch.cfg run scoreboard players operation #pn ch.tmp = #pd ch.tmp
