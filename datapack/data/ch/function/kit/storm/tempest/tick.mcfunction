# Tempest, every tick as its caster: the storm cloud above, flight, and a volley of telegraphed bolts each second.
scoreboard players remove @s ch.storm.temp 1
scoreboard players operation @s ch.meter = @s ch.storm.temp
scoreboard players operation @s ch.meter *= #100 ch.g
scoreboard players operation @s ch.meter /= @s ch.storm.tmax
execute if score #t2 ch.storm.g matches 0 run function ch:kit/storm/tempest/cloud
execute if score @s ch.b3 matches 5.. run function ch:kit/storm/tempest/fly
execute unless score @s ch.b3 matches 5.. if score #t20 ch.g matches 0 run effect give @s minecraft:slow_falling 2 0 true
execute if score #t20 ch.g matches 0 run function ch:kit/storm/tempest/volley
execute if score @s ch.storm.temp matches ..0 run function ch:kit/storm/tempest/end
