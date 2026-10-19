# Generated: recomputes ch.lvl.celestial from ch.xp.celestial and reports milestones.
scoreboard players operation #old ch.tmp = @s ch.lvl.celestial
scoreboard players operation #xp ch.tmp = @s ch.xp.celestial
function ch:mastery/level_from_xp
scoreboard players operation @s ch.lvl.celestial = #lvl ch.tmp
execute if score #lvl ch.tmp > #old ch.tmp run function ch:mastery/level_up {h:"celestial",i:9}
