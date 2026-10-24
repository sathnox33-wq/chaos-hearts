# Timeline: forked bolts striking around the marker every 3 ticks (it turns 137 degrees a tick).
function ch:vfx/load_cur
scoreboard players operation #m ch.tmp = @s ch.t
scoreboard players set #k ch.tmp 3
scoreboard players operation #m ch.tmp %= #k ch.tmp
scoreboard players operation #wl ch.tmp = @s ch.life
scoreboard players remove #wl ch.tmp 1
execute if score #m ch.tmp matches 0 positioned ^ ^ ^3 run function ch:vfx/sh {s:"bolt0",k:"b",v:0}
execute if score #m ch.tmp matches 1 positioned ^ ^ ^4 run function ch:vfx/sh {s:"bolt2",k:"d",v:0}
execute if score #m ch.tmp matches 2 positioned ^ ^ ^2 run function ch:vfx/sh {s:"bolt3",k:"b",v:0}
execute if score #m ch.tmp matches 0 positioned ^ ^ ^3 run function ch:vfx/sh {s:"streak8",k:"a",v:0.3}
