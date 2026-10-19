# Generated: recomputes ch.lvl.rage from ch.xp.rage and reports milestones.
scoreboard players operation #old ch.tmp = @s ch.lvl.rage
scoreboard players operation #xp ch.tmp = @s ch.xp.rage
function ch:mastery/level_from_xp
scoreboard players operation @s ch.lvl.rage = #lvl ch.tmp
execute if score #lvl ch.tmp > #old ch.tmp run function ch:mastery/level_up {h:"rage",i:1}
