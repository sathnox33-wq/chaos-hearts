# Generated: recomputes ch.lvl.infernal from ch.xp.infernal and reports milestones.
scoreboard players operation #old ch.tmp = @s ch.lvl.infernal
scoreboard players operation #xp ch.tmp = @s ch.xp.infernal
function ch:mastery/level_from_xp
scoreboard players operation @s ch.lvl.infernal = #lvl ch.tmp
execute if score #lvl ch.tmp > #old ch.tmp run function ch:mastery/level_up {h:"infernal",i:3}
