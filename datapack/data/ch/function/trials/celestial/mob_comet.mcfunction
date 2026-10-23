# Comet: a big glowing phantom that dives from above.
attribute @s minecraft:max_health base set 22
attribute @s minecraft:attack_damage base set 5
attribute @s minecraft:scale base set 1.4
attribute @s minecraft:follow_range base set 64
data merge entity @s {CustomName:{text:"Comet",color:"#FFC94A"},Health:22f,Glowing:1b}
function ch:api/trial/adopt
function ch:trials/celestial/spawn_fx
