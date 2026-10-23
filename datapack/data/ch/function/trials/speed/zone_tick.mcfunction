# A clock field: shimmers, and anyone in it is slowed.
scoreboard players remove @s ch.life 1
execute if score @s ch.life matches ..0 run return run kill @s
execute if score #t5 ch.speed.g matches 0 run function ch:api/fx/ring {p:"minecraft:dust{color:[0.16,0.83,0.95],scale:0.7}",r:4}
execute if score #t5 ch.speed.g matches 0 run particle minecraft:reverse_portal ~ ~0.5 ~ 2 0.3 2 0.01 4
execute if score #t10 ch.speed.g matches 0 run effect give @a[tag=ch.challenger,distance=..4] minecraft:slowness 2 2 true
execute if score #t10 ch.speed.g matches 0 run effect give @a[tag=ch.challenger,distance=..4] minecraft:mining_fatigue 2 1 true
