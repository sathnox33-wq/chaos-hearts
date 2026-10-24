# Generated: signature VFX of celestial ability 4; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:16773808}
execute rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/sigil7",n:40,spin:4,dy:0,fw:0}
function ch:vfx/gor {f:"ch:vfx/tl/wings",n:240}
function ch:vfx/gof {f:"ch:vfx/tl/halo",n:240,spin:0}
execute positioned ~ ~1 ~ run function ch:vfx/go {f:"ch:vfx/tl/nova",n:6,spin:0,dy:0,fw:0}
execute rotated 0 0 run function ch:vfx/sh {s:"star8_7",k:"t",v:0}
execute rotated 0 0 run function ch:gen/vfx/cyl3 {p:'minecraft:end_rod',v:0}
execute positioned ~ ~2 ~ run function ch:vfx/sh {s:"burst64",k:"b",v:0.5}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/celestial_a4_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/celestial_a4_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/celestial_a4_v2
