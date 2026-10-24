# Swirl sprite: a three-armed particle spiral.
execute if score #os ch.tmp matches 40..89 run function ch:vfx/sh {s:"spiral3",k:"d",v:0}
execute if score #os ch.tmp matches 90.. run function ch:vfx/sh {s:"spiral5",k:"d",v:0}
