# Generated: signature VFX of void ability 1; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:9059583}
execute positioned ~ ~1 ~ run function ch:vfx/sh {s:"implode2",k:"a",v:0.3}
execute rotated 0 0 positioned ~ ~0.05 ~ run function ch:vfx/sh {s:"galaxy3",k:"d",v:0}
execute positioned ~ ~1 ~ run function ch:vfx/sh {s:"sphere1",k:"k",v:0}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/void_a1_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/void_a1_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/void_a1_v2
