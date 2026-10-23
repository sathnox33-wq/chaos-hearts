# Speed, every tick: wakes, decoys, delayed sonic booms, time fractures and the armour vault safety sweep.
scoreboard players operation #t2 ch.speed.g = #now ch.g
scoreboard players operation #t2 ch.speed.g %= #2 ch.g
scoreboard players operation #t4 ch.speed.g = #now ch.g
scoreboard players operation #t4 ch.speed.g %= #4 ch.g
scoreboard players operation #t5 ch.speed.g = #now ch.g
scoreboard players operation #t5 ch.speed.g %= #5 ch.g
scoreboard players operation #t10 ch.speed.g = #now ch.g
scoreboard players operation #t10 ch.speed.g %= #10 ch.g
execute if entity @e[type=marker,tag=ch.speed.wake,limit=1] as @e[type=marker,tag=ch.speed.wake] at @s run function ch:kit/speed/slip/wake
execute if entity @e[type=mannequin,tag=ch.speed.decoy,limit=1] as @e[type=mannequin,tag=ch.speed.decoy] at @s run function ch:kit/speed/van/dtick
execute if score #boom ch.speed.g matches 1 run function ch:kit/speed/boom/run
execute if entity @e[type=marker,tag=ch.speed.frac,limit=1] as @e[type=marker,tag=ch.speed.frac] at @s run function ch:kit/speed/frac/tick
execute if entity @e[type=marker,tag=ch.speed.anchor,limit=1] as @e[type=marker,tag=ch.speed.anchor] run function ch:kit/speed/frac/anchor_tick
execute if score #t20 ch.g matches 7 if entity @e[type=armor_stand,tag=ch.speed.vault,limit=1] as @e[type=armor_stand,tag=ch.speed.vault] run function ch:kit/speed/van/sweep
