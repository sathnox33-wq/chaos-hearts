# The hole's particles: light spiralling in, black dust, inward ripples of bent space, a low drone.
scoreboard players operation #vf ch.tmp = @s ch.t
scoreboard players operation #vf ch.tmp %= #4 ch.g
particle minecraft:portal ~ ~ ~ 0 0 0 4 14
execute if score #vf ch.tmp matches 0 run particle minecraft:dust{color:[0.039,0.0,0.078],scale:2.0} ~ ~ ~ 1.4 0.4 1.4 0 8
execute if score #vf ch.tmp matches 2 run particle minecraft:dust{color:[0.827,0.549,1.0],scale:1.2} ~ ~ ~ 2.5 0.5 2.5 0 8
execute if score #vf ch.tmp matches 1 run particle minecraft:end_rod ~ ~ ~ 1.5 1.5 1.5 0 2
execute if score #vf ch.tmp matches 0 unless entity @s[tag=ch.void.mini] positioned ~ ~-1.4 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring_soft",color:9059583,s0:18.0,s1:0.6,t:10,life:11,spin:170,dy:0.0}
execute if score #vf ch.tmp matches 2 rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:1310763,s0:9.0,s1:0.4,t:8,life:9,spin:-170,dy:0.0}
execute if score #vt10 ch.tmp matches 0 run playsound minecraft:block.portal.ambient player @a ~ ~ ~ 1.2 0.5
execute if score #vt10 ch.tmp matches 5 run playsound minecraft:entity.warden.heartbeat player @a ~ ~ ~ 1 0.6
