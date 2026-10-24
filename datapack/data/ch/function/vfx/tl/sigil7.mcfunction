# Timeline: a spinning rune circle of radius 7 drawn every 3 ticks, rim sparkles between, energy rushing in
# at the start and bursting out at the end. Palette from the marker's data (see vfx/col).
function ch:vfx/load_cur
scoreboard players operation #m ch.tmp = @s ch.t
scoreboard players set #k ch.tmp 3
scoreboard players operation #m ch.tmp %= #k ch.tmp
scoreboard players operation #wl ch.tmp = @s ch.life
scoreboard players remove #wl ch.tmp 1
execute if score @s ch.t matches 0 positioned ~ ~0.1 ~ run function ch:vfx/sh {s:"inring6",k:"a",v:0.35}
execute if score #m ch.tmp matches 0 positioned ~ ~0.08 ~ run function ch:vfx/sh {s:"rune7",k:"d",v:0}
execute if score #m ch.tmp matches 1 positioned ~ ~0.12 ~ rotated ~30 0 run function ch:vfx/sh {s:"star6_7",k:"e",v:0}
execute if score #m ch.tmp matches 2 positioned ~ ~0.15 ~ run function ch:vfx/sh {s:"ring7",k:"b",v:0}
execute if score @s ch.t = #wl ch.tmp positioned ~ ~0.2 ~ run function ch:vfx/sh {s:"streak24",k:"a",v:0.55}
execute if score @s ch.t = #wl ch.tmp positioned ~ ~0.2 ~ run function ch:vfx/sh {s:"fount32",k:"b",v:0.35}
