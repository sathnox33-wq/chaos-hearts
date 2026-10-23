# Storm, every tick for its holder: Stormborn rain speed, the Static meter, wind wall, Tempest and the aura.
execute if score #t20 ch.g matches 0 run function ch:kit/storm/p/rain
execute if score @s ch.storm.temp matches 1.. run function ch:kit/storm/tempest/tick
execute unless score @s ch.storm.temp matches 1.. if score @s ch.lvl matches 25.. run function ch:kit/storm/p/meter
execute unless score @s ch.storm.temp matches 1.. unless score @s ch.lvl matches 25.. run scoreboard players set @s ch.meter 0
execute if score @s ch.storm.ww matches 1.. run function ch:kit/storm/gale/wall
execute if score @s ch.lvl matches 90.. if score #t3 ch.storm.g matches 0 run function ch:kit/storm/p/aura
