# Phase 3, from ambient at the centre: the infestation's radius grows from 2 to 14 blocks over the fight.
scoreboard players operation #cr ch.tmp = @e[tag=ch.corruption.boss,distance=..80,limit=1] ch.v2
scoreboard players operation #cr ch.tmp /= #4 ch.g
scoreboard players add #cr ch.tmp 20
execute if score #cr ch.tmp matches 141.. run scoreboard players set #cr ch.tmp 140
execute store result storage ch:corruption tr.r float 0.1 run scoreboard players get #cr ch.tmp
execute store result storage ch:corruption tr.h float 0.05 run scoreboard players get #cr ch.tmp
execute store result storage ch:corruption tr.d float 0.2 run scoreboard players get #cr ch.tmp
function ch:trials/corruption/rotarea with storage ch:corruption tr
