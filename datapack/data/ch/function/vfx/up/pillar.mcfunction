# Extra layers for fx/pillar: two spiralling streams climb the column while it rises, then crown its top.
execute if score #vb ch.g matches 12.. run return 0
scoreboard players add #vb ch.g 1
$function ch:vfx/col {color:$(color)}
$data modify storage ch:vfx cur.hf set value $(h)
$data modify storage ch:vfx cur.wf set value $(w)
execute store result score #ph ch.tmp run data get storage ch:vfx cur.hf 100
$scoreboard players set #pt ch.tmp $(t)
scoreboard players add #pt ch.tmp 4
scoreboard players operation #ph ch.tmp /= #pt ch.tmp
execute store result storage ch:vfx np.dy float 0.01 run scoreboard players get #ph ch.tmp
execute store result storage ch:vfx np.n int 1 run scoreboard players get #pt ch.tmp
execute store result storage ch:vfx cur.pw float 0.006 run data get storage ch:vfx cur.wf 100
data merge storage ch:vfx {np:{f:"ch:vfx/up/pillar_f",spin:38,fw:0}}
execute rotated ~ 0 run function ch:vfx/play with storage ch:vfx np
function ch:vfx/keep_cur
function ch:vfx/sh {s:"inring2",k:"a",v:0.18}
