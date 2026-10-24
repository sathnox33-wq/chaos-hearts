# Generated: signature VFX of corruption ability 2; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:8114490}
execute anchored eyes positioned ^ ^ ^1 rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/sigil5",n:24,spin:-6,dy:0,fw:0}
execute rotated 0 0 run function ch:vfx/sh {s:"crack5_0",k:"k",v:0}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/corruption_a2_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/corruption_a2_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/corruption_a2_v2
