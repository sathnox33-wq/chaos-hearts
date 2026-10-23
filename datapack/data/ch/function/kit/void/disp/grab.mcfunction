# Up: the target is ripped through a rift to just in front of you and rooted for a second.
execute at @e[tag=ch.void.dt,limit=1] run function ch:kit/void/disp/portal
execute rotated ~ 0 positioned ^ ^ ^2 if block ~ ~ ~ #ch:passable if block ~ ~1 ~ #ch:passable run return run function ch:kit/void/disp/grab2
function ch:kit/void/disp/grab2
