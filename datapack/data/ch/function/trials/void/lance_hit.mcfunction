# Later: the lance strikes - 7 damage within 1.6 blocks.
execute as @a[tag=ch.challenger,distance=..1.6] run function ch:trials/void/strike {d:70}
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:9059583,w:1.3,h:20.0,t:2,life:8}
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:15259903,w:0.5,h:20.0,t:2,life:6}
particle minecraft:end_rod ~ ~1 ~ 0.2 2 0.2 0.1 20
particle minecraft:reverse_portal ~ ~0.5 ~ 0.5 0.2 0.5 0.4 30
playsound minecraft:entity.warden.sonic_boom hostile @a ~ ~ ~ 0.6 1.8
function ch:api/fx/light {t:4}
