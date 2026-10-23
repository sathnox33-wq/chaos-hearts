# Phase 3, the Tempest: the wind drags you around the arena and bolts fall on random marks.
scoreboard players add @s ch.v6 1
execute if score @s ch.v6 matches 22.. run function ch:trials/storm/b/tempest_bolt
execute if score #t20 ch.g matches 5 as @a[tag=ch.challenger,distance=..60,limit=1] at @s facing entity @e[type=marker,tag=ch.session,distance=..90,limit=1] feet rotated ~90 0 positioned ^ ^ ^-2 run function ch:api/push {s:0.6,y:0.1}
