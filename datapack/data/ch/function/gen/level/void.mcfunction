# Generated: recomputes ch.lvl.void from ch.xp.void and reports milestones.
scoreboard players operation #old ch.tmp = @s ch.lvl.void
scoreboard players operation #xp ch.tmp = @s ch.xp.void
function ch:mastery/level_from_xp
scoreboard players operation @s ch.lvl.void = #lvl ch.tmp
execute if score #lvl ch.tmp > #old ch.tmp run function ch:mastery/level_up {h:"void",i:4}
