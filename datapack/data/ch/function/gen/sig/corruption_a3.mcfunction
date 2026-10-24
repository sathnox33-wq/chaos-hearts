# Generated: signature VFX of corruption ability 3; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:8114490}
execute anchored eyes positioned ^ ^ ^ run function ch:vfx/sh {s:"zap8_2",k:"d",v:0}
execute anchored eyes positioned ^ ^ ^ positioned ^ ^ ^3 run function ch:vfx/sh {s:"skull1",k:"k",v:0}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/corruption_a3_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/corruption_a3_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/corruption_a3_v2
