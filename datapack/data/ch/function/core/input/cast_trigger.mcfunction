# /trigger cast set <1-4> casts without the mouse, for players who bind it to a key.
execute store result storage ch:tmp n.slot int 1 run scoreboard players get @s cast
scoreboard players set @s cast 0
execute unless items entity @s weapon.* carrot_on_a_stick[custom_data~{ch:{focus:1}}] run return run title @s actionbar {text:"Hold your Focus to cast.",color:"red"}
execute if data storage ch:tmp n{slot:1} run return run function ch:core/cast {slot:1}
execute if data storage ch:tmp n{slot:2} run return run function ch:core/cast {slot:2}
execute if data storage ch:tmp n{slot:3} run return run function ch:core/cast {slot:3}
execute if data storage ch:tmp n{slot:4} run return run function ch:core/cast {slot:4}
