# #need ch.tmp (a level) -> total XP for that level: 2L^2+38L.
scoreboard players operation #sq ch.tmp = #need ch.tmp
scoreboard players operation #sq ch.tmp *= #need ch.tmp
scoreboard players operation #sq ch.tmp *= #2 ch.g
scoreboard players operation #need ch.tmp *= #38 ch.g
scoreboard players operation #need ch.tmp += #sq ch.tmp
