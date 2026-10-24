# Generated: signature VFX of infernal ability 4; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:16742938}
execute rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/sigil7",n:30,spin:6,dy:0,fw:0}
execute rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/vortex",n:40,spin:24,dy:0,fw:0}
function ch:vfx/gof {f:"ch:vfx/tl/charge",n:200,spin:29}
function ch:vfx/gof {f:"ch:vfx/tl/halo",n:200,spin:0}
execute rotated 0 0 run function ch:vfx/sh {s:"fangs4",k:"k",v:0}
execute rotated 0 0 run function ch:gen/vfx/helix16 {p:'minecraft:flame',v:0}
execute positioned ~ ~1 ~ run function ch:vfx/go {f:"ch:vfx/tl/nova",n:6,spin:0,dy:0,fw:0}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/infernal_a4_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/infernal_a4_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/infernal_a4_v2
