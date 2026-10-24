# Generated: signature VFX of frozen ability 3; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:10217471}
execute rotated 0 0 positioned ~ ~0.05 ~ run function ch:vfx/sh {s:"flake6",k:"d",v:0}
execute positioned ~ ~1 ~ run function ch:vfx/go {f:"ch:vfx/tl/nova",n:6,spin:0,dy:0,fw:0}
execute rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/ripple",n:8,spin:0,dy:0,fw:0}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/frozen_a3_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/frozen_a3_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/frozen_a3_v2
