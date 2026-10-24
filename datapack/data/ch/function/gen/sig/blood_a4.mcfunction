# Generated: signature VFX of blood ability 4; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:10357535}
execute rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/sigil7",n:40,spin:4,dy:0,fw:0}
execute positioned ~ ~9 ~ run function ch:vfx/sh {s:"sphere2",k:"d",v:0}
execute positioned ~ ~9 ~ run function ch:vfx/sh {s:"sphere1_5",k:"k",v:0}
execute positioned ~ ~9 ~ run function ch:vfx/sh {s:"ring6",k:"t",v:0}
execute rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/spiral",n:40,spin:20,dy:0,fw:0}
function ch:vfx/gof {f:"ch:vfx/tl/charge",n:240,spin:23}
execute anchored eyes positioned ^ ^ ^ positioned ^ ^2 ^5 run function ch:vfx/sh {s:"heart4",k:"d",v:0}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/blood_a4_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/blood_a4_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/blood_a4_v2
