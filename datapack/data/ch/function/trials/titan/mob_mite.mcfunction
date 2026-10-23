# Stonemite: a fast, fragile silverfish of living rock.
attribute @s minecraft:max_health base set 12
attribute @s minecraft:attack_damage base set 3
attribute @s minecraft:movement_speed base set 0.3
attribute @s minecraft:scale base set 1.3
attribute @s minecraft:follow_range base set 48
data merge entity @s {CustomName:{text:"Stonemite",color:"#C9A45C"},Health:12f}
function ch:api/trial/adopt
function ch:trials/titan/spawn_fx
