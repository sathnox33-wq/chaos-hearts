# Ice Prison: a circle closes at the challenger's feet; still inside after 30 ticks, they are walled in ice.
function ch:trials/frozen/callout {t:"The ice closes in! Step out!"}
execute at @a[tag=ch.challenger,distance=..90,limit=1,sort=nearest] positioned ~ 100 ~ run function ch:trials/frozen/prison_mark
