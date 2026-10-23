# Roar windup ticking.
scoreboard players remove @s ch.v3 1
particle minecraft:reverse_portal ~ ~1.5 ~ 3 1 3 0.05 10
scoreboard players operation #m ch.tmp = @s ch.v3
scoreboard players operation #m ch.tmp %= #5 ch.g
execute if score #m ch.tmp matches 0 positioned ~ ~0.2 ~ run function ch:api/fx/ring {p:"minecraft:dust{color:[0.88,0.15,0.17],scale:2.0}",r:7}
execute if score @s ch.v3 matches ..0 run function ch:trials/rage/roar_blast
