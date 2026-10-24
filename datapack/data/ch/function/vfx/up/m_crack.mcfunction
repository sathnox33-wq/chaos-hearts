# Crack decal: jagged particle fissures, glowing dust fading to black, with the heart's heavy particle in them.
execute if score #os ch.tmp matches 40..79 run function ch:vfx/sh {s:"crack3_0",k:"k",v:0}
execute if score #os ch.tmp matches 80..129 run function ch:vfx/sh {s:"crack5_1",k:"k",v:0}
execute if score #os ch.tmp matches 130.. run function ch:vfx/sh {s:"crack8_2",k:"k",v:0}
execute if score #os ch.tmp matches 80.. run function ch:vfx/sh {s:"fount16",k:"c",v:0.3}
