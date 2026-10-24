# Generated: signature VFX of corruption ability 4; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:8114490}
execute rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/sigil7",n:40,spin:-3,dy:0,fw:0}
execute anchored eyes positioned ^ ^ ^ positioned ^ ^1.5 ^5 run function ch:vfx/sh {s:"skull4",k:"d",v:0}
execute rotated 0 0 run function ch:vfx/sh {s:"crack8_1",k:"k",v:0}
execute rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/ripple",n:18,spin:0,dy:0,fw:0}
function ch:vfx/gof {f:"ch:vfx/tl/halo",n:160,spin:0}
execute positioned ~ ~1 ~ run function ch:vfx/sh {s:"implode8",k:"a",v:0.6}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/corruption_a4_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/corruption_a4_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/corruption_a4_v2
