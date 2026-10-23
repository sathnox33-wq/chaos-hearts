# As the locked target: gives it an entity id and stores it on the caster.
execute unless score @s ch.eid matches 1.. run function ch:api/new_eid
scoreboard players operation @a[tag=ch.caster,limit=1] ch.infernal.sk = @s ch.eid
