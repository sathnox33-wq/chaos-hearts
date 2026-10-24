# Generated: signature VFX of rage ability 3; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:14689835}
function ch:vfx/gof {f:"ch:vfx/tl/orbit",n:40,spin:30}
execute rotated 0 0 run function ch:vfx/sh {s:"crown1",k:"d",v:0}
execute positioned ~ ~0.1 ~ run function ch:vfx/sh {s:"ring1_5",k:"b",v:0}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/rage_a3_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/rage_a3_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/rage_a3_v2
