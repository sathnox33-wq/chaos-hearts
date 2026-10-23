# As the Titan: a slam hit counts toward Fault Line and builds Tremor.
scoreboard players add @s ch.titan.sc 1
scoreboard players add @s ch.titan.trem 5
scoreboard players operation @s ch.titan.lt = #now ch.g
execute if score @s ch.titan.sc matches 3.. run function ch:api/feat {h:"titan",n:0}
