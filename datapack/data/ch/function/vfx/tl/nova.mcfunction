# Timeline: sphere shells swelling outward one per tick, then a full blast of the heart's particle.
function ch:vfx/load_cur
execute if score @s ch.t matches 0 run function ch:vfx/sh {s:"sphere1",k:"b",v:0}
execute if score @s ch.t matches 1 run function ch:vfx/sh {s:"sphere1_5",k:"d",v:0}
execute if score @s ch.t matches 2 run function ch:vfx/sh {s:"sphere2",k:"t",v:0}
execute if score @s ch.t matches 3 run function ch:vfx/sh {s:"sphere3",k:"d",v:0}
execute if score @s ch.t matches 4 run function ch:vfx/sh {s:"sphere4",k:"k",v:0}
execute if score @s ch.t matches 5 run function ch:vfx/sh {s:"burst64",k:"a",v:0.6}
execute if score @s ch.t matches 5 run function ch:vfx/sh {s:"sphere6",k:"e",v:0}
