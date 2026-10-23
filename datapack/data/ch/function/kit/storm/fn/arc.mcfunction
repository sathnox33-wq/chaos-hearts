# Draws a jagged arc from here to the entity tagged ch.storm.nx (at most 16 blocks), then a beam along it.
scoreboard players set #as ch.storm.g 0
execute facing entity @e[tag=ch.storm.nx,limit=1] eyes run function ch:kit/storm/fn/arc_step
execute store result storage ch:kstorm b.len float 0.4 run scoreboard players get #as ch.storm.g
data modify storage ch:kstorm b.color set value 16777215
data modify storage ch:kstorm b.w set value 0.12
data modify storage ch:kstorm b.t set value 1
data modify storage ch:kstorm b.life set value 5
execute facing entity @e[tag=ch.storm.nx,limit=1] eyes run function ch:api/fx/beam with storage ch:kstorm b
data modify storage ch:kstorm b.color set value 5220607
data modify storage ch:kstorm b.w set value 0.45
data modify storage ch:kstorm b.life set value 7
execute facing entity @e[tag=ch.storm.nx,limit=1] eyes run function ch:api/fx/beam with storage ch:kstorm b
