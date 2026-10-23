# Ambush: the first hit after a Void Step is echoed by a second cut out of the void 10 ticks later (+50% of your attack).
scoreboard players set @s ch.void.st 0
execute store result score #vam ch.tmp run attribute @s minecraft:attack_damage get 5
execute if score #vam ch.tmp matches ..9 run scoreboard players set #vam ch.tmp 10
execute as @e[tag=ch.victim,limit=1] run scoreboard players operation @s ch.void.amb = #vam ch.tmp
execute as @e[tag=ch.victim,limit=1] run scoreboard players operation @s ch.void.ambo = @a[tag=ch.caster,limit=1] ch.pid
tag @e[tag=ch.victim,limit=1] add ch.void.ambt
execute at @e[tag=ch.victim,limit=1] run function ch:kit/void/fx/ambush_mark
execute at @e[tag=ch.victim,limit=1] run function ch:api/later {t:10,then:"ch:kit/void/ambush_hit"}
