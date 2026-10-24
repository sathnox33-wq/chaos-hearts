# Timeline (follows its owner): a halo over the head and a ring at the feet, alternating.
function ch:vfx/load_cur
scoreboard players operation #m ch.tmp = @s ch.t
scoreboard players set #k ch.tmp 2
scoreboard players operation #m ch.tmp %= #k ch.tmp
execute if score #m ch.tmp matches 0 positioned ~ ~2.25 ~ run function ch:vfx/sh {s:"ring0_5",k:"b",v:0}
execute if score #m ch.tmp matches 1 positioned ~ ~0.1 ~ run function ch:vfx/sh {s:"ring1",k:"d",v:0}
execute if score #m ch.tmp matches 1 positioned ~ ~2.3 ~ run function ch:vfx/sh {s:"ring0_5",k:"e",v:0}
