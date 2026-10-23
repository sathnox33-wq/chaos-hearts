# Shale Stalker: a vindicator with a stone axe that hunts fast.
attribute @s minecraft:max_health base set 40
attribute @s minecraft:attack_damage base set 9
attribute @s minecraft:movement_speed base set 0.36
attribute @s minecraft:follow_range base set 48
item replace entity @s weapon.mainhand with minecraft:stone_axe
data merge entity @s {CustomName:{text:"Shale Stalker",color:"#C9A45C"},Health:40f,drop_chances:{mainhand:0f}}
function ch:api/trial/adopt
function ch:trials/titan/spawn_fx
