# Generated: signature VFX of celestial ability 1; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:16773808}
execute anchored eyes positioned ^ ^ ^ positioned ^ ^ ^1.5 rotated ~ ~-90 run function ch:vfx/sh {s:"star5_2",k:"d",v:0}
execute anchored eyes positioned ^ ^ ^ positioned ^ ^ ^1.5 run function ch:vfx/sh {s:"burst16",k:"b",v:0.2}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/celestial_a1_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/celestial_a1_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/celestial_a1_v2
