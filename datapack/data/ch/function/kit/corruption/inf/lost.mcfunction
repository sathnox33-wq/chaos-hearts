# The host is gone before the burst. Blight Lord (awakened): the infection leaps to the nearest enemy within 8.
execute unless entity @s[tag=ch.corruption.fa] run return run function ch:kit/corruption/inf/fade
function ch:kit/corruption/inf/load
tag @e[tag=ch.corruption.jt] remove ch.corruption.jt
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,tag=!ch.corruption.host,distance=..8,sort=nearest,limit=1] run tag @s add ch.corruption.jt
execute unless entity @e[tag=ch.corruption.jt,limit=1] run return run function ch:kit/corruption/inf/fade
execute positioned ~ ~1 ~ facing entity @e[tag=ch.corruption.jt,limit=1] eyes run function ch:kit/corruption/inf/jline
execute as @e[tag=ch.corruption.jt,limit=1] at @s run function ch:kit/corruption/inf/plant
tag @e[tag=ch.corruption.jt] remove ch.corruption.jt
playsound minecraft:entity.zombie.infect player @a ~ ~ ~ 1 1.2
tag @a remove ch.caster
kill @s
