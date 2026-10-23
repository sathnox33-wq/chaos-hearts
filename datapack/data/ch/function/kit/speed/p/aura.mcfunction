# Speed aura (mastery 90): gold motes orbit you and a gilded wake follows your steps.
execute if score #t20 ch.g matches 0..4 rotated 0 0 run particle minecraft:end_rod ^ ^1.1 ^0.7 0 0 0 0 1
execute if score #t20 ch.g matches 5..9 rotated 90 0 run particle minecraft:end_rod ^ ^1.3 ^0.7 0 0 0 0 1
execute if score #t20 ch.g matches 10..14 rotated 180 0 run particle minecraft:end_rod ^ ^1.1 ^0.7 0 0 0 0 1
execute if score #t20 ch.g matches 15..19 rotated 270 0 run particle minecraft:end_rod ^ ^0.9 ^0.7 0 0 0 0 1
execute if predicate ch:sprinting run particle minecraft:dust{color:[0.96,0.88,0.26],scale:0.7} ~ ~0.3 ~ 0.2 0.05 0.2 0 2
execute if score @s ch.awake matches 1 run particle minecraft:electric_spark ~ ~1 ~ 0.3 0.5 0.3 0.02 1
execute if score #t20 ch.g matches 0 positioned ~ ~0.4 ~ rotated ~ 0 run function ch:api/fx/sprite {model:"feather",color:16113986,s0:0.2,s1:0.5,t:10,life:16,spin:120,dy:1.2}
