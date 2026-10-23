# As a target, caster tagged: sets it alight for #i_ft ticks and remembers who lit it.
execute if entity @s[type=player] run function ch:kit/infernal/ignite_player
execute unless entity @s[type=player] run function ch:kit/infernal/ignite_mob
tag @s add ch.infernal.lit
scoreboard players operation @s ch.infernal.by = @a[tag=ch.caster,limit=1] ch.pid
scoreboard players operation @s ch.infernal.lu = #now ch.g
scoreboard players operation @s ch.infernal.lu += #i_ft ch.tmp
scoreboard players add @s ch.infernal.lu 40
scoreboard players operation @a[tag=ch.caster,limit=1] ch.infernal.lbt = #now ch.g
