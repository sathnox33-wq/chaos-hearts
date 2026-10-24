# Generated: signature VFX of titan ability 3; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:13215836}
execute rotated 0 0 run function ch:vfx/sh {s:"crack3_2",k:"k",v:0}
function ch:vfx/sh {s:"fount32",k:"a",v:0.45}
execute positioned ~ ~1.5 ~ run function ch:vfx/sh {s:"implode2",k:"c",v:0.3}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/titan_a3_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/titan_a3_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/titan_a3_v2
