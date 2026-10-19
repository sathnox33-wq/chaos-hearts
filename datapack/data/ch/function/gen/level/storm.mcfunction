# Generated: recomputes ch.lvl.storm from ch.xp.storm and reports milestones.
scoreboard players operation #old ch.tmp = @s ch.lvl.storm
scoreboard players operation #xp ch.tmp = @s ch.xp.storm
function ch:mastery/level_from_xp
scoreboard players operation @s ch.lvl.storm = #lvl ch.tmp
execute if score #lvl ch.tmp > #old ch.tmp run function ch:mastery/level_up {h:"storm",i:6}
