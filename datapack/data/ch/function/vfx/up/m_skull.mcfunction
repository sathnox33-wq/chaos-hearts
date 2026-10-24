# Skull sprite: an upright particle skull facing the same way.
execute if score #os ch.tmp matches 10..29 positioned ~ ~0.5 ~ run function ch:vfx/sh {s:"skull1",k:"d",v:0}
execute if score #os ch.tmp matches 30.. positioned ~ ~1 ~ run function ch:vfx/sh {s:"skull2",k:"d",v:0}
