# Wind Wall: a ring of wind around you turns projectiles back for 3 seconds.
scoreboard players remove @s ch.storm.ww 1
execute if score #t3 ch.storm.g matches 0 positioned ~ ~1 ~ run function ch:api/fx/ring {p:"minecraft:cloud",r:2.6}
execute if score #t10 ch.storm.g matches 0 positioned ~ ~0.8 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring_soft",color:15267583,s0:5.0,s1:5.4,t:10,life:11,spin:170,dy:0.6}
scoreboard players operation #pid ch.storm.g = @s ch.pid
execute as @e[type=#minecraft:impact_projectiles,tag=!ch.storm.defl,distance=..3.6,limit=10] at @s run function ch:kit/storm/gale/deflect
