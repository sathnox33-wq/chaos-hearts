# Charging visuals: the danger ring, a swelling core and a rising whine.
scoreboard players operation #i_p ch.tmp = @s ch.infernal.nova
scoreboard players operation #i_p ch.tmp %= #4 ch.g
$execute if score #i_p ch.tmp matches 0 run function ch:api/fx/ring {p:"minecraft:dust{color:$(dc),scale:2.0}",r:7}
$execute if score #i_p ch.tmp matches 0 run function ch:api/fx/orb {color:$(c3),s:1.8,t:4,life:5}
$particle $(fl) ~ ~1 ~ 0.4 0.8 0.4 0.05 6
particle minecraft:lava ~ ~1 ~ 0.4 0.4 0.4 0 1
execute if score #i_p ch.tmp matches 2 run playsound minecraft:block.beacon.ambient player @a ~ ~ ~ 1.4 1.6
execute if score @s ch.infernal.nova matches 20 run playsound minecraft:entity.blaze.ambient player @a ~ ~ ~ 1.4 0.8
execute if score @s ch.infernal.nova matches 10 run playsound minecraft:entity.blaze.ambient player @a ~ ~ ~ 1.4 1.3
