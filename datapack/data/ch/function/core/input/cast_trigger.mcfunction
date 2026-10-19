# /trigger cast set <1-4> casts, for players who bind it to a key or prefer typing.
execute store result storage ch:tmp n.slot int 1 run scoreboard players get @s cast
scoreboard players set @s cast 0
execute if data storage ch:tmp n{slot:1} run return run function ch:core/cast {slot:1}
execute if data storage ch:tmp n{slot:2} run return run function ch:core/cast {slot:2}
execute if data storage ch:tmp n{slot:3} run return run function ch:core/cast {slot:3}
execute if data storage ch:tmp n{slot:4} run return run function ch:core/cast {slot:4}
execute if data storage ch:tmp n{slot:5} run return run function ch:core/input/shuffle
