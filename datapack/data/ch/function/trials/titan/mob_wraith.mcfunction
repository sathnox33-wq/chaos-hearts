# Dust Wraith: a gaunt husk wrapped in drifting grit.
attribute @s minecraft:max_health base set 28
attribute @s minecraft:attack_damage base set 6
attribute @s minecraft:movement_speed base set 0.3
attribute @s minecraft:follow_range base set 48
item replace entity @s armor.head with minecraft:gravel
data merge entity @s {CustomName:{text:"Dust Wraith",color:"#7A746A"},Health:28f,IsBaby:0b,drop_chances:{head:0f}}
effect give @s minecraft:speed infinite 0 true
function ch:api/trial/adopt
function ch:trials/titan/spawn_fx
