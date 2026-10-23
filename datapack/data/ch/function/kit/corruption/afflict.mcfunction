# As a target: a soft Corruption status effect $(e) (respects the caster, PvP, creative and trials).
execute if entity @s[tag=ch.caster] run return fail
execute if entity @s[tag=ch.noability] run return fail
execute if entity @s[type=#ch:ignore] run return fail
execute if entity @s[type=player] if score #pvp ch.g matches 0 run return fail
execute if entity @s[type=player,gamemode=!survival,gamemode=!adventure] run return fail
execute if entity @s[type=player,scores={ch.trial=1..}] if entity @a[tag=ch.caster,limit=1] run return fail
$effect give @s minecraft:$(e) $(sec) $(amp)
