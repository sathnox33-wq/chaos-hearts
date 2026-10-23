# As a new Flame Wall segment: owner, lifetime, flags, ground snap and the rising column of fire.
tp @s ~ ~ ~ ~ ~
tag @s add ch.infernal.post
tag @s add ch.noability
scoreboard players operation @s ch.owner = @a[tag=ch.caster,limit=1] ch.pid
scoreboard players operation @s ch.life = #i_dur ch.tmp
scoreboard players set @s ch.v1 0
scoreboard players operation @s ch.v2 = #i_mt ch.tmp
scoreboard players operation @s ch.v5 = #i_cs ch.tmp
scoreboard players operation @s ch.v6 = #i_aw ch.tmp
scoreboard players set #i_sn ch.tmp 4
execute at @s run function ch:kit/infernal/gs
execute at @s run function ch:kit/infernal/wall/rise with storage ch:tmp ki
