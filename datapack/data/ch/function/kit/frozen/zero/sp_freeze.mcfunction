# Everything within 12 blocks freezes solid and is marked to shatter.
scoreboard players set #f_ft ch.tmp 50
execute positioned ~ ~1 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..12] at @s run function ch:kit/frozen/zero/sp_mark
playsound minecraft:block.glass.place player @a ~ ~ ~ 2 0.5
function ch:api/later {t:20,then:"ch:kit/frozen/zero/sp_crack"}
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
function ch:api/later {t:40,then:"ch:kit/frozen/zero/sp_shatter"}
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
