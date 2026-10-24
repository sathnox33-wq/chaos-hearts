# Generated: signature VFX of celestial ability 3; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:16773808}
function ch:vfx/gof {f:"ch:vfx/tl/charge",n:8,spin:60}
execute anchored eyes positioned ^ ^ ^ positioned ^ ^ ^1 run function ch:vfx/sh {s:"implode3",k:"a",v:0.3}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/celestial_a3_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/celestial_a3_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/celestial_a3_v2
