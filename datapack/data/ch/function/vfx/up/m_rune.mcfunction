# Rune decal: a particle rune circle the size of the decal, with a themed outer ring.
execute if score #os ch.tmp matches 30..49 run function ch:vfx/sh {s:"rune2",k:"d",v:0}
execute if score #os ch.tmp matches 50..79 run function ch:vfx/sh {s:"rune3",k:"d",v:0}
execute if score #os ch.tmp matches 80..119 run function ch:vfx/sh {s:"rune5",k:"d",v:0}
execute if score #os ch.tmp matches 120.. run function ch:vfx/sh {s:"rune7",k:"d",v:0}
execute if score #os ch.tmp matches 50..99 positioned ~ ~0.1 ~ run function ch:vfx/sh {s:"ring3",k:"b",v:0}
execute if score #os ch.tmp matches 100.. positioned ~ ~0.1 ~ run function ch:vfx/sh {s:"ring6",k:"b",v:0}
