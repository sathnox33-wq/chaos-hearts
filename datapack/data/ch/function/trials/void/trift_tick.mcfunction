# As a trial rift (driven from ambient): pulls the challenger within 11 blocks, then bursts for 9 damage within 3.2.
scoreboard players remove @s ch.life 1
particle minecraft:portal ~ ~ ~ 0 0 0 3 20
particle minecraft:dust{color:[0.039,0.0,0.078],scale:1.8} ~ ~ ~ 0.5 0.5 0.5 0 4
scoreboard players operation #vb ch.tmp = @s ch.life
scoreboard players operation #vb ch.tmp %= #10 ch.void.k
execute if score #vb ch.tmp matches 0 as @a[tag=ch.challenger,distance=1.5..11,limit=1] run function ch:api/pull {s:0.4}
execute if score #vb ch.tmp matches 5 rotated 45 60 run function ch:api/fx/sprite {model:"ring",color:13864191,s0:3.0,s1:0.4,t:5,life:6,spin:170,dy:0.0}
execute if score @s ch.life matches 1.. run return 0
execute as @a[tag=ch.challenger,distance=..3.2] run function ch:trials/void/strike {d:90}
particle minecraft:reverse_portal ~ ~ ~ 0.3 0.3 0.3 0.8 100
particle minecraft:sonic_boom ~ ~ ~ 0 0 0 0 1
function ch:api/fx/orb {color:9059583,s:6.0,t:3,life:6}
function ch:api/fx/light {t:5}
playsound chaoshearts:void_collapse hostile @a ~ ~ ~ 1.5 1.2
playsound minecraft:entity.ender_dragon.flap hostile @a ~ ~ ~ 2 0.6
function ch:api/fx/shake {s:2,t:8,r:12}
kill @s
