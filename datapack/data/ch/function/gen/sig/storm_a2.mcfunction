# Generated: signature VFX of storm ability 2; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:5220607}
execute rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/ripple",n:9,spin:0,dy:0,fw:0}
function ch:vfx/sh {s:"streak24",k:"c",v:0.6}
execute rotated 0 0 run function ch:vfx/sh {s:"vortex6",k:"e",v:0}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/storm_a2_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/storm_a2_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/storm_a2_v2
