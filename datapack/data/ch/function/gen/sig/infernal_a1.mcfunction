# Generated: signature VFX of infernal ability 1; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:16742938}
execute anchored eyes positioned ^ ^ ^ positioned ^ ^ ^1 run function ch:vfx/sh {s:"implode2",k:"a",v:0.25}
execute anchored eyes positioned ^ ^ ^ run function ch:vfx/sh {s:"cone6",k:"d",v:0}
execute anchored eyes positioned ^ ^ ^ run function ch:vfx/sh {s:"conefill6",k:"a",v:0}
execute positioned ~ ~0.1 ~ run function ch:gen/vfx/ring1 {p:'minecraft:lava',v:0}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/infernal_a1_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/infernal_a1_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/infernal_a1_v2
