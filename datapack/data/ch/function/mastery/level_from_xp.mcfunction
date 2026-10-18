# #xp ch.tmp -> #lvl ch.tmp, where level L needs 2L^2+38L total XP. Starts from #old ch.tmp when that is still valid.
scoreboard players operation #lvl ch.tmp = #old ch.tmp
execute if score #lvl ch.tmp matches ..-1 run scoreboard players set #lvl ch.tmp 0
scoreboard players operation #need ch.tmp = #lvl ch.tmp
function ch:mastery/total
execute if score #need ch.tmp > #xp ch.tmp run scoreboard players set #lvl ch.tmp 0
function ch:mastery/level_loop
