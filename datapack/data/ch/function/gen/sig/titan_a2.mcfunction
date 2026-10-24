# Generated: signature VFX of titan ability 2; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:13215836}
execute rotated 0 0 run function ch:vfx/sh {s:"hex2",k:"d",v:0}
execute rotated 0 0 run function ch:vfx/sh {s:"cyl1_5",k:"e",v:0}
execute positioned ~ ~1 ~ run function ch:vfx/sh {s:"sphere1_5",k:"c",v:0}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/titan_a2_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/titan_a2_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/titan_a2_v2
