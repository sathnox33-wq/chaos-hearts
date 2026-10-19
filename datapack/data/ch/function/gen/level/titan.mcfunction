# Generated: recomputes ch.lvl.titan from ch.xp.titan and reports milestones.
scoreboard players operation #old ch.tmp = @s ch.lvl.titan
scoreboard players operation #xp ch.tmp = @s ch.xp.titan
function ch:mastery/level_from_xp
scoreboard players operation @s ch.lvl.titan = #lvl ch.tmp
execute if score #lvl ch.tmp > #old ch.tmp run function ch:mastery/level_up {h:"titan",i:8}
