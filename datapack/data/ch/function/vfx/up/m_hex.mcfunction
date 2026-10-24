# Hex sprite: a hexagram and hexagon of dust.
execute if score #os ch.tmp matches 30..69 run function ch:vfx/sh {s:"star6_2",k:"d",v:0}
execute if score #os ch.tmp matches 70.. run function ch:vfx/sh {s:"star6_5",k:"d",v:0}
execute if score #os ch.tmp matches 70.. run function ch:vfx/sh {s:"hex5",k:"e",v:0}
