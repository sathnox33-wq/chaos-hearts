# Boulderback: a ravager carrying a mossy boulder on its back.
attribute @s minecraft:max_health base set 90
attribute @s minecraft:attack_damage base set 10
attribute @s minecraft:follow_range base set 48
data merge entity @s {CustomName:{text:"Boulderback",color:"#C9A45C"},Health:90f}
function ch:api/trial/adopt
execute summon block_display run function ch:trials/titan/ravager_rock
function ch:trials/titan/spawn_fx
playsound minecraft:entity.ravager.roar master @a ~ ~ ~ 1.5 0.7
