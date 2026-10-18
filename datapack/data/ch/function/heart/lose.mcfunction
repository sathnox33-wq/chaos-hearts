# The player stops holding one heart of type $(h) (index $(i)). Registry handled by the caller.
$scoreboard players remove @s ch.cnt.$(h) 1
$execute if score @s ch.cnt.$(h) matches ..0 run scoreboard players set @s ch.own.$(h) 0
$execute if score @s ch.cnt.$(h) matches ..0 run scoreboard players set @s ch.cnt.$(h) 0
$execute if score @s ch.active matches $(i) if score @s ch.cnt.$(h) matches 0 run function ch:heart/next_active
