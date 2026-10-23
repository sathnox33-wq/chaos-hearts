# One tick of a primed boom: sparks gather, then it pops.
scoreboard players remove @s ch.speed.boom 1
execute if score @s ch.speed.boom matches 1.. run particle minecraft:electric_spark ~ ~1 ~ 0.4 0.5 0.4 0.1 2
execute if score @s ch.speed.boom matches 1.. run return run scoreboard players set #boom ch.speed.g 1
function ch:kit/speed/boom/pop
