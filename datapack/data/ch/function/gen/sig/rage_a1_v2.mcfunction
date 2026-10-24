# Generated: rage ability 1, variant 2.
function ch:vfx/col {color:14689835}
execute rotated ~ 0 run function ch:vfx/sh {s:"crack8_1",k:"k",v:0}
execute positioned ^ ^0.1 ^0 rotated ~ 0 run function ch:vfx/sh {s:"line16",k:"d",v:0}
execute positioned ^ ^0.2 ^ rotated ~ 0 run function ch:gen/vfx/zap16_0 {p:'minecraft:flame',v:0}
function ch:vfx/sh {s:"fount64",k:"c",v:0.45}
execute rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/ripple",n:6,spin:0,dy:0,fw:0}
