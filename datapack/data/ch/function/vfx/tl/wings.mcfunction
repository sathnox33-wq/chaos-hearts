# Timeline (follows its owner, facing as they face): a pair of wings drawn every 2 ticks.
function ch:vfx/load_cur
scoreboard players operation #m ch.tmp = @s ch.t
scoreboard players set #k ch.tmp 2
scoreboard players operation #m ch.tmp %= #k ch.tmp
execute if score #m ch.tmp matches 0 run function ch:vfx/sh {s:"wings1",k:"b",v:0}
execute if score #m ch.tmp matches 1 run function ch:vfx/sh {s:"wings1",k:"d",v:0}
