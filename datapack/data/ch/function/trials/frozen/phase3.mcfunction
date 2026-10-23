# Phase 3: an endless blizzard, and the snowfield cracks into slick blue ice.
function ch:trials/frozen/callout {t:"THE LAST WINTER: the storm never ends!"}
execute at @e[type=marker,tag=ch.session,distance=..90,limit=1,sort=nearest] run function ch:trials/frozen/p3_floor
