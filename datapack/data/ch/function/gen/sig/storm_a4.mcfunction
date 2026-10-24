# Generated: signature VFX of storm ability 4; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:5220607}
execute rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/bolts",n:60,spin:137,dy:0,fw:0}
execute rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/sigil7",n:30,spin:9,dy:0,fw:0}
function ch:vfx/gof {f:"ch:vfx/tl/orbit",n:200,spin:40}
execute rotated 0 0 run function ch:vfx/sh {s:"vortex10",k:"e",v:0}
execute positioned ~ ~8 ~ run function ch:gen/vfx/dome8 {p:'minecraft:cloud',v:0}
function ch:vfx/sh {s:"bolt0",k:"b",v:0}
function ch:vfx/sh {s:"bolt2",k:"b",v:0}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/storm_a4_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/storm_a4_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/storm_a4_v2
