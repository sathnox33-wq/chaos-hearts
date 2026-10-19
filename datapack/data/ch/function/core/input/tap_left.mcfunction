# Ability 3 is a double tap of left, so strafing while crouched does not cast it by accident.
execute if score @s ch.dta matches 1.. run return run function ch:core/input/cast3
scoreboard players set @s ch.dta 8
