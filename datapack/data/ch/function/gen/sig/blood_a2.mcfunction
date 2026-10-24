# Generated: signature VFX of blood ability 2; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:10357535}
execute anchored eyes positioned ^ ^ ^ positioned ^ ^-0.3 ^1.6 run function ch:vfx/sh {s:"heart2",k:"k",v:0}
execute positioned ~ ~1.2 ~ run function ch:vfx/sh {s:"burst64",k:"a",v:0.35}
function ch:vfx/gof {f:"ch:vfx/tl/charge",n:20,spin:40}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/blood_a2_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/blood_a2_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/blood_a2_v2
