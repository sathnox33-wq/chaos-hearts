# Generated: recomputes ch.lvl.frozen from ch.xp.frozen and reports milestones.
scoreboard players operation #old ch.tmp = @s ch.lvl.frozen
scoreboard players operation #xp ch.tmp = @s ch.xp.frozen
function ch:mastery/level_from_xp
scoreboard players operation @s ch.lvl.frozen = #lvl ch.tmp
execute if score #lvl ch.tmp > #old ch.tmp run function ch:mastery/level_up {h:"frozen",i:5}
