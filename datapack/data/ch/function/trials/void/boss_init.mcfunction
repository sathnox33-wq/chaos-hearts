# As the new boss.
tag @s remove ch.void.tn
function ch:api/trial/boss {name:"The Hollow Sovereign",color:"purple"}
scoreboard players set @s ch.void.bt 0
scoreboard players set @s ch.void.bp 1
data modify entity @s AngryAt set from entity @a[tag=ch.challenger,limit=1] UUID
data merge entity @s {AngerTime:2400}
