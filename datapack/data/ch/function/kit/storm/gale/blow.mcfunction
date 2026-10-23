# As an enemy hit by Gale Burst (executed at the caster): blown away (Strong Gust: much harder).
scoreboard players add #pushed ch.storm.g 1
execute unless entity @a[tag=ch.caster,scores={ch.b2=1..},limit=1] run function ch:api/push {s:1.6,y:0.5}
execute if entity @a[tag=ch.caster,scores={ch.b2=1..},limit=1] run function ch:api/push {s:2.1,y:0.6}
execute if entity @s[type=player] if entity @a[tag=ch.caster,scores={ch.b2=1..},limit=1] run function ch:api/push {s:2.1,y:0.6}
execute at @s run particle minecraft:cloud ~ ~1 ~ 0.3 0.5 0.3 0.1 8
execute at @s run particle minecraft:small_gust ~ ~1 ~ 0.3 0.3 0.3 0 2
