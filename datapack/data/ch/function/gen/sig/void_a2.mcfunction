# Generated: signature VFX of void ability 2; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:9059583}
execute anchored eyes positioned ^ ^ ^ positioned ^ ^ ^2 run function ch:vfx/sh {s:"implode3",k:"a",v:0.3}
execute anchored eyes positioned ^ ^ ^ positioned ^ ^ ^2 run function ch:vfx/sh {s:"galaxy3",k:"d",v:0}
execute anchored eyes positioned ^ ^ ^ positioned ^ ^ ^2 run function ch:gen/vfx/sphere1_5 {p:'minecraft:squid_ink',v:0}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/void_a2_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/void_a2_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/void_a2_v2
