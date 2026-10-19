# Key $(k) was released: it counts as a tap if it was held at most 6 ticks.
$execute if score @s ch.$(k) matches ..6 run function ch:core/input/$(a)
$scoreboard players set @s ch.$(k) 0
