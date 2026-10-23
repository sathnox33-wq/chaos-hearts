# As a new rotling, caster tagged.
tag @s remove ch.corruption.lnew
function ch:api/own
scoreboard players operation @s ch.life = #cll ch.tmp
scoreboard players set @s ch.v1 10
execute store success score @s ch.v2 if entity @a[tag=ch.caster,scores={ch.b2=5..},limit=1]
