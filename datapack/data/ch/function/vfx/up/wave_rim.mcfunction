# Internal: the full-size rim of a wave: themed sparkles on the edge and embers rising off it.
data modify storage ch:vfx cur.r set from storage ch:vfx np.r
data modify storage ch:vfx cur.p set from storage ch:vfx cur.b
function ch:gen/vfx/mring32 with storage ch:vfx cur
data modify storage ch:vfx cur.p set from storage ch:vfx cur.t
execute rotated ~5 0 positioned ~ ~0.6 ~ run function ch:gen/vfx/mring16 with storage ch:vfx cur
