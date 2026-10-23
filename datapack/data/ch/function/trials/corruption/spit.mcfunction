# Spit: Nyxara lobs globs of bile high into the air; their landing spots are marked; they splash into poison puddles.
playsound minecraft:entity.llama.spit hostile @a ~ ~ ~ 2 0.5
playsound minecraft:entity.slime.jump hostile @a ~ ~ ~ 1.5 0.5
execute positioned ~ ~2 ~ rotated 0 0 run function ch:api/fx/sprite {model:"orb",color:8114490,s0:0.8,s1:0.4,t:8,life:9,spin:150,dy:8.0}
particle minecraft:item_slime ~ ~2 ~ 0.5 0.5 0.5 0.2 20
execute at @a[tag=ch.challenger,limit=1] run function ch:trials/corruption/glob
execute at @a[tag=ch.challenger,limit=1] rotated ~ 0 positioned ^2.5 ^ ^3 run function ch:trials/corruption/glob
execute at @a[tag=ch.challenger,limit=1] rotated ~ 0 positioned ^-3 ^ ^-1.5 run function ch:trials/corruption/glob
execute if score @s ch.corruption.bp matches 3.. at @a[tag=ch.challenger,limit=1] rotated ~ 0 positioned ^3.5 ^ ^-3 run function ch:trials/corruption/glob
execute if score @s ch.corruption.bp matches 3.. at @a[tag=ch.challenger,limit=1] rotated ~ 0 positioned ^-2 ^ ^4.5 run function ch:trials/corruption/glob
