# Fills storage ch:vfx cur from a decimal RGB colour: d (dust), t (dust fading to white), k (dust fading to black)
# and the themed particles a, b, c of the heart that uses this colour (generic sparkles when unknown).
data remove storage ch:vfx cur
$data modify storage ch:vfx cur set from storage ch:vfx th.c$(color)
execute unless data storage ch:vfx cur.a run data modify storage ch:vfx cur set value {a:"minecraft:end_rod",b:"minecraft:electric_spark",c:"minecraft:cloud"}
$scoreboard players set #cc ch.tmp $(color)
scoreboard players set #c256 ch.tmp 256
scoreboard players operation #cb ch.tmp = #cc ch.tmp
scoreboard players operation #cb ch.tmp %= #c256 ch.tmp
scoreboard players operation #cc ch.tmp /= #c256 ch.tmp
scoreboard players operation #cg ch.tmp = #cc ch.tmp
scoreboard players operation #cg ch.tmp %= #c256 ch.tmp
scoreboard players operation #cc ch.tmp /= #c256 ch.tmp
execute store result storage ch:vfx cur.cr double 0.0039216 run scoreboard players get #cc ch.tmp
execute store result storage ch:vfx cur.cg double 0.0039216 run scoreboard players get #cg ch.tmp
execute store result storage ch:vfx cur.cb double 0.0039216 run scoreboard players get #cb ch.tmp
function ch:vfx/col_mk with storage ch:vfx cur
