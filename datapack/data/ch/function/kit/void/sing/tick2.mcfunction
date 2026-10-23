# The pull, the sting, the look, the warning and the collapse.
scoreboard players operation #vt ch.tmp = @s ch.t
scoreboard players operation #vt ch.tmp %= #5 ch.g
execute if score #vt ch.tmp matches 1 run function ch:kit/void/sing/anim
execute if score @s ch.v1 matches 2 run return run function ch:kit/void/sing/t_implode
scoreboard players operation #sp ch.tmp = @s ch.t
scoreboard players operation #sp ch.tmp *= #2 ch.g
scoreboard players add #sp ch.tmp 80
execute if score #sp ch.tmp matches 321.. run scoreboard players set #sp ch.tmp 320
execute store result storage ch:void s.p double 0.001 run scoreboard players get #sp ch.tmp
execute store result storage ch:void s.r float 0.1 run scoreboard players get @s ch.v2
scoreboard players operation #vt10 ch.tmp = @s ch.t
scoreboard players operation #vt10 ch.tmp %= #10 ch.g
function ch:kit/void/sing/pull with storage ch:void s
scoreboard players set #vd ch.tmp 20
execute if score #vt10 ch.tmp matches 0 as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..3.5,limit=12] run function ch:kit/void/hurt
function ch:kit/void/sing/fx
execute if score @s ch.life matches 20 run function ch:kit/void/sing/warn
execute if score @s ch.life matches ..0 run function ch:kit/void/sing/collapse
