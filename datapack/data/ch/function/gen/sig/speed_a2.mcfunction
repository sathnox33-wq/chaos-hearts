# Generated: signature VFX of speed ability 2; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:16114754}
execute positioned ~ ~1 ~ run function ch:vfx/sh {s:"sphere1",k:"t",v:0}
execute positioned ~ ~1 ~ run function ch:vfx/sh {s:"burst32",k:"b",v:0.3}
execute rotated 0 0 run function ch:gen/vfx/cyl1 {p:'minecraft:electric_spark',v:0}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/speed_a2_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/speed_a2_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/speed_a2_v2
