# Generated: recomputes ch.lvl.speed from ch.xp.speed and reports milestones.
scoreboard players operation #old ch.tmp = @s ch.lvl.speed
scoreboard players operation #xp ch.tmp = @s ch.xp.speed
function ch:mastery/level_from_xp
scoreboard players operation @s ch.lvl.speed = #lvl ch.tmp
execute if score #lvl ch.tmp > #old ch.tmp run function ch:mastery/level_up {h:"speed",i:2}
