# Generated: signature VFX of celestial ability 2; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:16773808}
execute rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/sigil5",n:60,spin:3,dy:0,fw:0}
function ch:vfx/gor {f:"ch:vfx/tl/wings",n:40}
function ch:vfx/sh {s:"dome5",k:"e",v:0}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/celestial_a2_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/celestial_a2_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/celestial_a2_v2
