# Hollow Seraph: a stray in gold that shoots from range.
attribute @s minecraft:max_health base set 34
attribute @s minecraft:follow_range base set 48
item replace entity @s weapon.mainhand with minecraft:bow
item replace entity @s armor.head with minecraft:golden_helmet
item replace entity @s armor.chest with minecraft:golden_chestplate
data merge entity @s {CustomName:{text:"Hollow Seraph",color:"#FFD36B"},Health:34f,drop_chances:{mainhand:0f,head:0f,chest:0f}}
function ch:api/trial/adopt
function ch:trials/celestial/spawn_fx
