# Timeline: a spinning three-armed funnel redrawn every 2 ticks, with the heart's particle sucked in at the base.
function ch:vfx/load_cur
scoreboard players operation #m ch.tmp = @s ch.t
scoreboard players set #k ch.tmp 2
scoreboard players operation #m ch.tmp %= #k ch.tmp
execute if score #m ch.tmp matches 0 run function ch:vfx/sh {s:"vortex6",k:"d",v:0}
execute if score #m ch.tmp matches 1 rotated ~60 0 run function ch:vfx/sh {s:"vortex6",k:"e",v:0}
execute if score #m ch.tmp matches 1 run function ch:vfx/sh {s:"inring3",k:"a",v:0.3}
