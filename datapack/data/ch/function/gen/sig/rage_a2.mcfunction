# Generated: signature VFX of rage ability 2; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:14689835}
execute rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/sigil5",n:16,spin:-8,dy:0,fw:0}
function ch:vfx/gof {f:"ch:vfx/tl/charge",n:12,spin:41}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/rage_a2_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/rage_a2_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/rage_a2_v2
