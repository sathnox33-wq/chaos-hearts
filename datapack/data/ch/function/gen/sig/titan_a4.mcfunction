# Generated: signature VFX of titan ability 4; variant in #sig_v ch.tmp (0 level, 1 up, 2 down).
function ch:vfx/col {color:13215836}
execute rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/sigil7",n:30,spin:3,dy:0,fw:0}
execute rotated 0 0 run function ch:vfx/sh {s:"fangs6",k:"k",v:0}
execute rotated 0 0 run function ch:vfx/sh {s:"crack8_0",k:"k",v:0}
execute rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/ripple",n:14,spin:0,dy:0,fw:0}
execute rotated 0 0 run function ch:vfx/sh {s:"cyl4",k:"e",v:0}
function ch:vfx/sh {s:"fount64",k:"a",v:0.6}
function ch:gen/vfx/dome8 {p:'minecraft:cloud',v:0}
function ch:vfx/gof {f:"ch:vfx/tl/halo",n:200,spin:0}
execute if score #sig_v ch.tmp matches 0 run function ch:gen/sig/titan_a4_v0
execute if score #sig_v ch.tmp matches 1 run function ch:gen/sig/titan_a4_v1
execute if score #sig_v ch.tmp matches 2 run function ch:gen/sig/titan_a4_v2
