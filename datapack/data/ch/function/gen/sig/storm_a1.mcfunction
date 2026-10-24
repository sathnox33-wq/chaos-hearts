# Generated: signature VFX of storm ability 1; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:5220607}
execute anchored eyes positioned ^ ^ ^ run function ch:gen/vfx/zap8_0 {p:'minecraft:electric_spark',v:0}
execute positioned ~ ~1.2 ~ run function ch:vfx/sh {s:"burst16",k:"a",v:0.3}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/storm_a1_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/storm_a1_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/storm_a1_v2
