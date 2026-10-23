# As a freshly summoned Void trial mob: hand it to the trial framework.
tag @s remove ch.void.tn
function ch:api/trial/adopt
data modify entity @s AngryAt set from entity @a[tag=ch.challenger,limit=1] UUID
data merge entity @s {AngerTime:1200}
