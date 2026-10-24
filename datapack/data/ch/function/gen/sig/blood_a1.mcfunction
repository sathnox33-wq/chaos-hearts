# Generated: signature VFX of blood ability 1; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:10357535}
execute anchored eyes positioned ^ ^ ^ positioned ^ ^ ^1.4 run function ch:vfx/sh {s:"heart1",k:"d",v:0}
execute anchored eyes positioned ^ ^ ^ positioned ^ ^ ^1.4 run function ch:vfx/sh {s:"implode2",k:"a",v:0.2}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/blood_a1_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/blood_a1_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/blood_a1_v2
