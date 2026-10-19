# Generated: recomputes ch.lvl.corruption from ch.xp.corruption and reports milestones.
scoreboard players operation #old ch.tmp = @s ch.lvl.corruption
scoreboard players operation #xp ch.tmp = @s ch.xp.corruption
function ch:mastery/level_from_xp
scoreboard players operation @s ch.lvl.corruption = #lvl ch.tmp
execute if score #lvl ch.tmp > #old ch.tmp run function ch:mastery/level_up {h:"corruption",i:10}
