# Generated: signature VFX of blood ability 3; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:10357535}
execute anchored eyes positioned ^ ^ ^ run function ch:vfx/sh {s:"braid12",k:"d",v:0}
execute anchored eyes positioned ^ ^ ^ run function ch:vfx/sh {s:"zap8_1",k:"k",v:0}
function ch:vfx/gof {f:"ch:vfx/tl/orbit",n:80,spin:30}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/blood_a3_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/blood_a3_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/blood_a3_v2
