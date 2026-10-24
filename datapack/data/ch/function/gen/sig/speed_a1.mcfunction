# Generated: signature VFX of speed ability 1; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:16114754}
function ch:vfx/sh {s:"streak24",k:"a",v:0.6}
execute positioned ~ ~0.1 ~ run function ch:vfx/sh {s:"ring1_5",k:"b",v:0}
function ch:vfx/gof {f:"ch:vfx/tl/trail",n:14,spin:0}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/speed_a1_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/speed_a1_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/speed_a1_v2
