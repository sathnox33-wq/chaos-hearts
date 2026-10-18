$execute store result score #sec ch.tmp run scoreboard players get @s ch.cd$(slot)
scoreboard players add #sec ch.tmp 19
scoreboard players operation #sec ch.tmp /= #20 ch.g
execute store result storage ch:tmp n.v int 1 run scoreboard players get #sec ch.tmp
function ch:core/msg/cooling2 with storage ch:tmp n
