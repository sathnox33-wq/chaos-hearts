# Timeline: a clock face on the ground with a racing hand (the marker turns) and a slow one.
function ch:vfx/load_cur
scoreboard players operation #m ch.tmp = @s ch.t
scoreboard players set #k ch.tmp 2
scoreboard players operation #m ch.tmp %= #k ch.tmp
execute if score #m ch.tmp matches 0 positioned ~ ~0.1 ~ rotated 0 0 run function ch:vfx/sh {s:"clock5",k:"d",v:0}
execute positioned ~ ~0.15 ~ run function ch:vfx/sh {s:"hand5",k:"b",v:0}
execute if score #m ch.tmp matches 1 positioned ~ ~0.15 ~ rotated ~150 0 run function ch:vfx/sh {s:"hand3",k:"t",v:0}
