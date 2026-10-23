# Frost Nova. Level: an instant burst that freezes everything within 6 blocks. Up: leap and crash down in a bigger nova. Down: Glacial Implosion, a 1 s collapsing ring that drags enemies in, then freezes them solid.
scoreboard players operation #f_var ch.tmp = #var ch.tmp
execute if score #f_var ch.tmp matches 1 run return run function ch:kit/frozen/nova/slam
execute if score #f_var ch.tmp matches 2 run return run function ch:kit/frozen/nova/implode
scoreboard players set #f_nf ch.tmp 30
function ch:kit/frozen/nova/burst {r:6,dia:12.0,d:40}
return 1
