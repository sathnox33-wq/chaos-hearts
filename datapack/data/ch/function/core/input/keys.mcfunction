# While sneaking: a quick tap (held 1-6 ticks) of jump, sprint, left, right or back is a hotkey.
scoreboard players set @s ch.tap 1
execute if predicate ch:input/jump run scoreboard players add @s ch.kj 1
execute unless predicate ch:input/jump if score @s ch.kj matches 1.. run function ch:core/input/release {k:"kj",a:"cast1"}
execute if predicate ch:input/sprint run scoreboard players add @s ch.ks 1
execute unless predicate ch:input/sprint if score @s ch.ks matches 1.. run function ch:core/input/release {k:"ks",a:"cast2"}
execute if predicate ch:input/left run scoreboard players add @s ch.ka 1
execute unless predicate ch:input/left if score @s ch.ka matches 1.. run function ch:core/input/release {k:"ka",a:"tap_left"}
execute if predicate ch:input/right run scoreboard players add @s ch.kd 1
execute unless predicate ch:input/right if score @s ch.kd matches 1.. run function ch:core/input/release {k:"kd",a:"tap_right"}
execute if predicate ch:input/backward run scoreboard players add @s ch.kb 1
execute unless predicate ch:input/backward if score @s ch.kb matches 1.. run function ch:core/input/release {k:"kb",a:"shuffle"}
