# Generated: signature VFX of titan ability 1; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:13215836}
execute rotated 0 0 run function ch:vfx/sh {s:"crack5_0",k:"k",v:0}
function ch:vfx/sh {s:"fount32",k:"a",v:0.4}
function ch:gen/vfx/streak24 {p:'minecraft:cloud',v:0.3}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/titan_a1_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/titan_a1_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/titan_a1_v2
