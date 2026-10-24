# Frame of the pillar layer: four points of a quadruple helix around the climbing marker; a crown at the top.
function ch:vfx/load_cur
function ch:vfx/up/pillar_p with storage ch:vfx cur
scoreboard players operation #wl ch.tmp = @s ch.life
scoreboard players remove #wl ch.tmp 1
execute if score @s ch.t = #wl ch.tmp run function ch:vfx/sh {s:"burst32",k:"a",v:0.2}
execute if score @s ch.t = #wl ch.tmp run function ch:vfx/sh {s:"ring1_5",k:"b",v:0}
