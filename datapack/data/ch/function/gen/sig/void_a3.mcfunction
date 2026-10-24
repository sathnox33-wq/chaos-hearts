# Generated: signature VFX of void ability 3; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:9059583}
execute anchored eyes positioned ^ ^ ^ run function ch:vfx/sh {s:"braid16",k:"d",v:0}
execute anchored eyes positioned ^ ^ ^ run function ch:vfx/sh {s:"line16",k:"b",v:0}
execute positioned ~ ~1 ~ run function ch:vfx/sh {s:"sphere1",k:"k",v:0}
execute rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/spiral",n:12,spin:-45,dy:0,fw:0}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/void_a3_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/void_a3_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/void_a3_v2
