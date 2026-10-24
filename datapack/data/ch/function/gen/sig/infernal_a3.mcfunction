# Generated: signature VFX of infernal ability 3; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:16742938}
execute anchored eyes positioned ^ ^ ^6 run function ch:vfx/sh {s:"fangs2",k:"k",v:0}
execute anchored eyes positioned ^ ^ ^6 rotated 0 0 run function ch:vfx/sh {s:"crack5_0",k:"k",v:0}
execute anchored eyes positioned ^ ^ ^6 rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/sigil5",n:20,spin:7,dy:0,fw:0}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/infernal_a3_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/infernal_a3_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/infernal_a3_v2
