# The orb's look: gyroscope rings collapsing into it, black dust, portal light being swallowed.
scoreboard players operation #vf ch.tmp = @s ch.t
scoreboard players operation #vf ch.tmp %= #4 ch.g
execute if score #vf ch.tmp matches 0 rotated 0 30 run function ch:api/fx/sprite {model:"ring",color:9059583,s0:2.4,s1:0.6,t:5,life:6,spin:170,dy:0.0}
execute if score #vf ch.tmp matches 1 rotated 90 -40 run function ch:api/fx/sprite {model:"ring",color:13864191,s0:2.2,s1:0.5,t:5,life:6,spin:-170,dy:0.0}
execute if score #vf ch.tmp matches 2 rotated 45 70 run function ch:api/fx/sprite {model:"ring_soft",color:9059583,s0:2.8,s1:0.6,t:5,life:6,spin:170,dy:0.0}
execute if score #vf ch.tmp matches 3 rotated 135 -65 run function ch:api/fx/sprite {model:"ring",color:1310763,s0:2.4,s1:0.6,t:5,life:6,spin:-170,dy:0.0}
particle minecraft:portal ~ ~ ~ 0 0 0 2 8
particle minecraft:dust{color:[0.039,0.0,0.078],scale:1.6} ~ ~ ~ 0.25 0.25 0.25 0 2
execute if score #vt ch.tmp matches 0 run playsound minecraft:block.portal.ambient player @a ~ ~ ~ 0.4 1.6
