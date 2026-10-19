# Generated: recomputes ch.lvl.blood from ch.xp.blood and reports milestones.
scoreboard players operation #old ch.tmp = @s ch.lvl.blood
scoreboard players operation #xp ch.tmp = @s ch.xp.blood
function ch:mastery/level_from_xp
scoreboard players operation @s ch.lvl.blood = #lvl ch.tmp
execute if score #lvl ch.tmp > #old ch.tmp run function ch:mastery/level_up {h:"blood",i:7}
