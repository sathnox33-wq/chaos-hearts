# Timeline: the marker climbs (dy) drawing a widening double spiral behind it, then bursts at the top.
function ch:vfx/load_cur
function ch:vfx/tl/rise_p with storage ch:vfx cur
scoreboard players operation #wl ch.tmp = @s ch.life
scoreboard players remove #wl ch.tmp 1
execute if score @s ch.t = #wl ch.tmp run function ch:vfx/sh {s:"burst64",k:"a",v:0.4}
execute if score @s ch.t = #wl ch.tmp run function ch:vfx/sh {s:"sphere2",k:"b",v:0}
