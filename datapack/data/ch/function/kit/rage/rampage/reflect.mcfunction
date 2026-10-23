# Blood for Blood: the attacker is lashed for half the damage (at least 2).
scoreboard players operation #rd ch.tmp = #pd ch.tmp
scoreboard players operation #rd ch.tmp /= #2 ch.g
execute if score #rd ch.tmp matches ..19 run scoreboard players set #rd ch.tmp 20
execute store result storage ch:tmp rage.d int 1 run scoreboard players get #rd ch.tmp
tag @s add ch.caster
execute on attacker if entity @s[type=!#ch:ignore,tag=!ch.caster] at @s run function ch:kit/rage/rampage/lash with storage ch:tmp rage
tag @s remove ch.caster
