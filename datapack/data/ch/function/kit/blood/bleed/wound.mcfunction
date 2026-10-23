# A bleed wound, credited to whoever opened it.
scoreboard players operation #o ch.tmp = @s ch.blood.bo
tag @a remove ch.caster
execute as @a if score @s ch.pid = #o ch.tmp run tag @s add ch.caster
execute if score @s ch.blood.bm matches 1 if score @a[tag=ch.caster,limit=1] ch.b2 matches 4.. run function ch:api/hit {d:15}
execute unless score @s ch.blood.bm matches 1 run function ch:api/hit {d:10}
execute if score @s ch.blood.bm matches 1 unless score @a[tag=ch.caster,limit=1] ch.b2 matches 4.. run function ch:api/hit {d:10}
tag @a remove ch.caster
particle minecraft:dust{color:[0.62,0.04,0.12],scale:1.2} ~ ~1.1 ~ 0.25 0.3 0.25 0 8
particle minecraft:damage_indicator ~ ~1.2 ~ 0.1 0.1 0.1 0 1
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~1 ~ 0.2 0.3 0.2 0.1 6
