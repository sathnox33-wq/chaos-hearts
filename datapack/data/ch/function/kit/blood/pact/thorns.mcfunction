# Blood Ward: whoever struck you is lashed (1.5) and bleeds for 3 s.
tag @s add ch.caster
scoreboard players set #bt ch.tmp 60
scoreboard players set #bm ch.tmp 0
execute on attacker if entity @s[type=!#ch:ignore,tag=!ch.caster] at @s run function ch:kit/blood/pact/lash
tag @s remove ch.caster
