# Internal: builds the dust particle specs for vfx/col.
$data modify storage ch:vfx cur.d set value "minecraft:dust{color:[$(cr),$(cg),$(cb)],scale:1.4}"
$data modify storage ch:vfx cur.e set value "minecraft:dust{color:[$(cr),$(cg),$(cb)],scale:0.7}"
$data modify storage ch:vfx cur.t set value "minecraft:dust_color_transition{from_color:[$(cr),$(cg),$(cb)],to_color:[1.0,1.0,1.0],scale:1.2}"
$data modify storage ch:vfx cur.k set value "minecraft:dust_color_transition{from_color:[$(cr),$(cg),$(cb)],to_color:[0.05,0.02,0.05],scale:1.6}"
