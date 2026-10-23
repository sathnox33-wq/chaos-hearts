# The landing circle on the ground below a leaping Rage holder.
execute if score @s ch.rage.lv matches 0 positioned ~ ~0.1 ~ run function ch:api/fx/ring {p:"minecraft:dust{color:[0.88,0.15,0.17],scale:1.3}",r:4}
execute unless score @s ch.rage.lv matches 0 positioned ~ ~0.1 ~ run function ch:api/fx/ring {p:"minecraft:dust{color:[0.88,0.15,0.17],scale:1.8}",r:6}
execute unless score @s ch.rage.lv matches 0 positioned ~ ~0.1 ~ run function ch:api/fx/ring {p:"minecraft:dust{color:[1.0,0.42,0.12],scale:1.2}",r:3}
particle minecraft:dust{color:[0.88,0.15,0.17],scale:2.0} ~ ~0.15 ~ 0.1 0 0.1 0 2
