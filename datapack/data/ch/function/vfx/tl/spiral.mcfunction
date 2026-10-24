# Timeline: a turning ground galaxy redrawn every 2 ticks with sparks flung off its rim.
function ch:vfx/load_cur
scoreboard players operation #m ch.tmp = @s ch.t
scoreboard players set #k ch.tmp 2
scoreboard players operation #m ch.tmp %= #k ch.tmp
execute if score #m ch.tmp matches 0 positioned ~ ~0.1 ~ run function ch:vfx/sh {s:"spiral5",k:"d",v:0}
execute if score #m ch.tmp matches 1 positioned ~ ~0.1 ~ run function ch:vfx/sh {s:"spiral3",k:"t",v:0}
execute if score #m ch.tmp matches 1 positioned ~ ~0.2 ~ run function ch:vfx/sh {s:"streak8",k:"a",v:0.35}
