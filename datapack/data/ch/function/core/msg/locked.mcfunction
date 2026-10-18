$execute store result storage ch:tmp n.v int 1 run scoreboard players get #unlock$(slot) ch.g
function ch:core/msg/locked2 with storage ch:tmp n
playsound minecraft:block.dispenser.fail player @s ~ ~ ~ 0.5 1.2
