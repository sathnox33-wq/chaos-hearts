# Extra layers for fx/orb: the heart's particle rushes into it, a dust shell forms around it and two motes orbit it.
execute if score #vb ch.g matches 12.. run return 0
scoreboard players add #vb ch.g 1
$function ch:vfx/col {color:$(color)}
$data modify storage ch:vfx cur.sf set value $(s)
execute store result score #os ch.tmp run data get storage ch:vfx cur.sf 10
execute if score #os ch.tmp matches ..19 run function ch:vfx/sh {s:"sphere0_5",k:"e",v:0}
execute if score #os ch.tmp matches 20..34 run function ch:vfx/sh {s:"sphere1",k:"d",v:0}
execute if score #os ch.tmp matches 35..59 run function ch:vfx/sh {s:"sphere1_5",k:"d",v:0}
execute if score #os ch.tmp matches 60.. run function ch:vfx/sh {s:"sphere2",k:"d",v:0}
execute if score #os ch.tmp matches ..34 run function ch:vfx/sh {s:"implode2",k:"a",v:0.2}
execute if score #os ch.tmp matches 35.. run function ch:vfx/sh {s:"implode4",k:"a",v:0.35}
execute store result storage ch:vfx cur.pw float 0.04 run scoreboard players get #os ch.tmp
$data merge storage ch:vfx {np:{f:"ch:vfx/up/orb_f",n:$(life),spin:31,dy:0,fw:0}}
execute rotated ~ 25 run function ch:vfx/play with storage ch:vfx np
function ch:vfx/keep_cur
