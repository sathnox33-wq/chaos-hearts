# Star sprite: a star polygon of dust and a spray of sparkles.
execute if score #os ch.tmp matches 20..59 run function ch:vfx/sh {s:"star5_2",k:"d",v:0}
execute if score #os ch.tmp matches 60.. run function ch:vfx/sh {s:"star5_3",k:"d",v:0}
function ch:vfx/sh {s:"burst16",k:"b",v:0.2}
