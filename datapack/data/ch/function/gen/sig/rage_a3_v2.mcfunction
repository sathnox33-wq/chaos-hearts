# Generated: rage ability 3, variant 2.
function ch:vfx/col {color:14689835}
execute rotated 0 0 run function ch:vfx/go {f:"ch:vfx/tl/spiral",n:20,spin:36,dy:0,fw:0}
execute positioned ~ ~1 ~ rotated 0 0 run function ch:vfx/sh {s:"arc4",k:"d",v:0}
execute positioned ~ ~1 ~ rotated 180 0 run function ch:vfx/sh {s:"arc4",k:"t",v:0}
function ch:vfx/sh {s:"streak24",k:"a",v:0.5}
