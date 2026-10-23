# An enemy hit by the War Cry: Weakness (and, empowered, a staggering wound and Slowness).
execute store result score #ok ch.tmp run function ch:api/cc {effect:"minecraft:weakness",sec:5,amp:0}
execute if score #ok ch.tmp matches 1 run scoreboard players add #wk ch.tmp 1
execute if score #emp ch.tmp matches 1 run function ch:kit/rage/cry/stagger
execute at @s run particle minecraft:angry_villager ~ ~2 ~ 0.25 0.2 0.25 0 2
execute at @s run particle minecraft:dust{color:[0.88,0.15,0.17],scale:1.0} ~ ~1 ~ 0.3 0.5 0.3 0 8
execute if entity @s[type=player] run function ch:api/fx/screen {o:"vignette",color:"#E0262B",in:0,stay:4,out:12}
execute if entity @s[type=player] run playsound minecraft:entity.warden.heartbeat player @s ~ ~ ~ 1 0.8
