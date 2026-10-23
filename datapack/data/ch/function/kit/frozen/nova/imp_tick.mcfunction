# The collapsing ring, every tick.
tag @a remove ch.caster
function ch:api/tag_owner
scoreboard players remove @s ch.life 1
execute store result storage ch:tmp kf.r float 0.45 run scoreboard players get @s ch.life
function ch:kit/frozen/nova/imp_fx with storage ch:tmp kf
scoreboard players operation #f_p ch.tmp = @s ch.life
scoreboard players operation #f_p ch.tmp %= #4 ch.g
execute if score #f_p ch.tmp matches 0 as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..9.5] run function ch:api/pull {s:0.5}
execute if score @s ch.life matches ..0 run function ch:kit/frozen/nova/imp_end
tag @a remove ch.caster
