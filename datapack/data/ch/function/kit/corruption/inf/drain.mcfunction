# The leech drinks: 2 damage to the host, 1 heart back to you.
scoreboard players set #cd ch.tmp 20
scoreboard players operation #cnec ch.tmp = @s ch.v6
execute as @e[tag=ch.corruption.hcur,limit=1] run function ch:kit/corruption/hurt
execute as @a[tag=ch.caster,limit=1] run function ch:api/heal {n:2}
playsound minecraft:entity.generic.drink player @a ~ ~ ~ 0.6 0.6
particle minecraft:damage_indicator ~ ~1.2 ~ 0.2 0.3 0.2 0.1 4
