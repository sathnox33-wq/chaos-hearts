# Generated: signature VFX of speed ability 4; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:16114754}
execute rotated 0 0 positioned ~ ~0.05 ~ run function ch:vfx/go {f:"ch:vfx/tl/clock",n:80,spin:18,dy:0,fw:0}
execute rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/sigil7",n:30,spin:-4,dy:0,fw:0}
function ch:vfx/gof {f:"ch:vfx/tl/orbit",n:100,spin:22}
execute rotated 0 0 positioned ~ ~3 ~ run function ch:vfx/sh {s:"clock8",k:"e",v:0}
execute positioned ~ ~1 ~ run function ch:vfx/sh {s:"sphere3",k:"t",v:0}
execute rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/ripple",n:10,spin:0,dy:0,fw:0}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/speed_a4_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/speed_a4_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/speed_a4_v2
