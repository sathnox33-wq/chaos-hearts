# Generated: signature VFX of rage ability 1; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:14689835}
execute rotated 0 0 run function ch:vfx/sh {s:"crack3_0",k:"k",v:0}
function ch:vfx/sh {s:"streak16",k:"a",v:0.4}
function ch:vfx/gof {f:"ch:vfx/tl/trail",n:24,spin:0}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/rage_a1_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/rage_a1_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/rage_a1_v2
