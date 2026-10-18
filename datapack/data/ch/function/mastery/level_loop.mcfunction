execute if score #lvl ch.tmp matches 100.. run return 0
scoreboard players operation #need ch.tmp = #lvl ch.tmp
scoreboard players add #need ch.tmp 1
function ch:mastery/total
execute if score #need ch.tmp > #xp ch.tmp run return 0
scoreboard players add #lvl ch.tmp 1
function ch:mastery/level_loop
