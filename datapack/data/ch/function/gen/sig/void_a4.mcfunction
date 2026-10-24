# Generated: signature VFX of void ability 4; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:9059583}
execute rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/sigil7",n:30,spin:-5,dy:0,fw:0}
function ch:vfx/gof {f:"ch:vfx/tl/orbit",n:120,spin:-26}
execute rotated 0 0 positioned ~ ~0.05 ~ run function ch:vfx/sh {s:"galaxy6",k:"d",v:0}
execute positioned ~ ~1 ~ run function ch:vfx/sh {s:"implode8",k:"a",v:0.7}
execute anchored eyes positioned ^ ^ ^ positioned ^ ^1 ^6 run function ch:vfx/sh {s:"eye4",k:"k",v:0}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/void_a4_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/void_a4_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/void_a4_v2
