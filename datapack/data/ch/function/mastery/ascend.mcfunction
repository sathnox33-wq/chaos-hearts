# Ascension XP on an awakened heart earns skill points.
$scoreboard players operation @s ch.asc.$(h) += #x ch.tmp
$scoreboard players operation #pts ch.tmp = @s ch.asc.$(h)
scoreboard players operation #pts ch.tmp /= #asc_per_pt ch.cfg
scoreboard players operation #pts ch.tmp += #awaken_pts ch.cfg
scoreboard players operation #pts ch.tmp < #max_pts ch.cfg
$execute if score #pts ch.tmp > @s ch.pts.$(h) run function ch:mastery/new_point
$scoreboard players operation @s ch.pts.$(h) > #pts ch.tmp
