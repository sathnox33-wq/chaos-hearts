# Generated: signature VFX of storm ability 3; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:5220607}
execute anchored eyes positioned ^ ^ ^ run function ch:vfx/sh {s:"zap16_1",k:"b",v:0}
execute anchored eyes positioned ^ ^ ^ run function ch:gen/vfx/zap16_2 {p:'minecraft:electric_spark',v:0}
function ch:vfx/gof {f:"ch:vfx/tl/charge",n:12,spin:60}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/storm_a3_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/storm_a3_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/storm_a3_v2
