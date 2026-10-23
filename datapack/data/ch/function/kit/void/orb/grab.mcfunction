# As an enemy near the orb (executed at the orb): counts toward Gravity Well, then is dragged toward it.
execute unless score @s ch.void.oid = #oid ch.tmp run function ch:kit/void/orb/first
execute if entity @s[type=player] run return run function ch:kit/void/orb/grabp
execute if entity @s[tag=ch.boss] run return 0
execute at @s facing entity @e[type=item_display,tag=ch.void.cur,limit=1] feet run function ch:api/vec with storage ch:void v
function ch:api/motion
