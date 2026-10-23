# Speed melee hit: breaks Afterimage (Shade Ambush strikes), then releases a charged Momentum strike.
execute if score @s ch.speed.van matches 1.. run function ch:kit/speed/van/strike
execute if score @s ch.lvl matches 25.. if score @s ch.speed.spr matches 60.. run function ch:kit/speed/p/mstrike
