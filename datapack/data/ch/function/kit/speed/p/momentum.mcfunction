# Momentum: 3 seconds of sprinting charges the next melee hit. The meter shows the charge.
execute if score @s ch.speed.spr matches ..59 if predicate ch:sprinting run function ch:kit/speed/p/charge
execute if score @s ch.speed.spr matches ..59 unless predicate ch:sprinting run scoreboard players set @s ch.speed.spr 0
execute if score @s ch.speed.spr matches 60.. if score #t2 ch.speed.g matches 0 run particle minecraft:electric_spark ~ ~1 ~ 0.25 0.4 0.25 0.05 2
execute if score @s ch.speed.spr matches 60.. if score #t10 ch.speed.g matches 0 run particle minecraft:dust{color:[0.96,0.88,0.26],scale:0.7} ~ ~0.2 ~ 0.3 0.05 0.3 0 4
scoreboard players operation @s ch.meter = @s ch.speed.spr
scoreboard players operation @s ch.meter *= #c5 ch.speed.g
scoreboard players operation @s ch.meter /= #c3 ch.speed.g
