# Generated: signature VFX of infernal ability 2; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:16742938}
execute rotated 0 0 positioned ~ ~0.05 ~ run function ch:vfx/go {f:"ch:vfx/tl/sigil3",n:12,spin:9,dy:0,fw:0}
function ch:vfx/sh {s:"streak16",k:"a",v:0.45}
execute rotated 0 0 run function ch:gen/vfx/cyl1_5 {p:'minecraft:flame',v:0}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/infernal_a2_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/infernal_a2_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/infernal_a2_v2
