# Blink Strike: Vael vanishes; three ticks of the clock; a gold mark appears behind you; then it is there.
execute if score @s ch.v2 matches 1 run function ch:trials/speed/b/blink_out
execute if score @s ch.v2 matches 4 as @a[tag=ch.challenger,limit=1] at @s run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 1 1.4
execute if score @s ch.v2 matches 6 as @a[tag=ch.challenger,limit=1] at @s rotated ~ 0 positioned ^ ^ ^-2.4 run function ch:trials/speed/b/blink_mark
execute if score @s ch.v2 matches 8 as @a[tag=ch.challenger,limit=1] at @s run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 1 1.6
execute if score @s ch.v2 matches 10 as @a[tag=ch.challenger,limit=1] at @s run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 1 1.8
execute if score @s ch.v2 matches 12 run function ch:trials/speed/b/blink_in
execute if score @s ch.v2 matches 24.. run function ch:trials/speed/b/end
