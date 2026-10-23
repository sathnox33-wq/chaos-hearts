# As an enemy in the cyclone: swept around the funnel and lifted (players are lifted and dragged).
execute if entity @s[type=!player,tag=!ch.boss] facing entity @e[type=marker,tag=ch.storm.cyc,limit=1,sort=nearest] feet rotated ~70 0 run function ch:api/vec {s:0.38}
execute if entity @s[type=!player,tag=!ch.boss] run scoreboard players set #vy ch.tmp 140
execute if entity @s[type=!player,tag=!ch.boss] run function ch:api/motion
execute if entity @s[type=player] run function ch:api/cc {effect:"minecraft:levitation",sec:1,amp:1}
execute if entity @s[type=player] if score #t10 ch.storm.g matches 0 positioned as @e[type=marker,tag=ch.storm.cyc,limit=1,sort=nearest] run function ch:api/pull {s:0.3}
particle minecraft:cloud ~ ~0.5 ~ 0.2 0.2 0.2 0.02 2
