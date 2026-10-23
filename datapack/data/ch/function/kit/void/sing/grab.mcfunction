# As an enemy inside the pull (executed at the hole): Event Horizon count, then dragged in.
execute unless score @s ch.void.sid = #sid ch.tmp run function ch:kit/void/sing/caught
execute if entity @s[type=player] run return run function ch:kit/void/sing/grabp
execute if entity @s[tag=ch.boss] run return 0
execute at @s facing entity @e[type=marker,tag=ch.void.scur,limit=1] feet run function ch:kit/void/sing/vec with storage ch:void s
function ch:api/motion
