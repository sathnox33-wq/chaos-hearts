# A polar bear is set on the challenger.
data modify entity @s AngryAt set from entity @a[tag=ch.challenger,distance=..90,limit=1,sort=nearest] UUID
data modify entity @s AngerTime set value 6000
