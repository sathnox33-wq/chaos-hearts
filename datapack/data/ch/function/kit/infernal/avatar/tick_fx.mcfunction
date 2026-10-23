# Avatar body visuals.
$particle $(fl) ~ ~1 ~ 0.3 0.6 0.3 0.02 4
particle minecraft:small_flame ~ ~1.8 ~ 0.2 0.2 0.2 0.02 1
$execute if score #i_p ch.tmp matches 0..4 run function ch:api/fx/ring {p:"minecraft:dust{color:$(dc),scale:1.1}",r:1.6}
execute if score @s ch.infernal.avm matches 1 run particle minecraft:flame ~ ~-0.1 ~ 0.15 0 0.15 0.12 4
