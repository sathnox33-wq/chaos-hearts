# Internal: the wave's dust ring at radius np.r, plus an inner echo of the heart's dust fading to black.
data modify storage ch:vfx cur.r set from storage ch:vfx np.r
data modify storage ch:vfx cur.p set from storage ch:vfx cur.d
$function ch:gen/vfx/mring$(n) with storage ch:vfx cur
execute store result storage ch:vfx cur.r float 0.0075 run scoreboard players get #wr ch.tmp
data modify storage ch:vfx cur.p set from storage ch:vfx cur.k
execute rotated ~11 0 positioned ~ ~0.15 ~ run function ch:gen/vfx/mring16 with storage ch:vfx cur
