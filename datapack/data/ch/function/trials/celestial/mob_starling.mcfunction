# Starling: a quick golden vex.
attribute @s minecraft:max_health base set 16
attribute @s minecraft:attack_damage base set 4
attribute @s minecraft:follow_range base set 48
item replace entity @s weapon.mainhand with minecraft:golden_sword
data merge entity @s {CustomName:{text:"Starling",color:"#FFF2B0"},Health:16f,drop_chances:{mainhand:0f}}
function ch:api/trial/adopt
function ch:trials/celestial/spawn_fx
