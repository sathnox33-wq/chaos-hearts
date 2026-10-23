# Later: the web closes.
particle minecraft:cloud ~ ~0.5 ~ 0.8 0.2 0.8 0.02 25
particle minecraft:item_cobweb ~ ~0.5 ~ 1 0.5 1 0 40
playsound minecraft:block.wool.place hostile @a ~ ~ ~ 1.5 0.6
execute as @a[tag=ch.challenger,distance=..2.4,limit=1] run function ch:trials/corruption/snared
