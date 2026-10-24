# Generated: signature VFX of frozen ability 4; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:10217471}
execute rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/sigil7",n:40,spin:5,dy:0,fw:0}
execute rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/vortex",n:60,spin:20,dy:0,fw:0}
execute rotated 0 0 positioned ~ ~6 ~ run function ch:vfx/sh {s:"flake6",k:"t",v:0}
function ch:vfx/gof {f:"ch:vfx/tl/halo",n:200,spin:0}
execute rotated 0 0 run function ch:vfx/sh {s:"crown5",k:"d",v:0}
function ch:vfx/sh {s:"dome8",k:"e",v:0}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/frozen_a4_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/frozen_a4_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/frozen_a4_v2
