# Down: arming for a second, then a near-invisible flicker. An enemy within 3 blocks trips it.
execute if score @s ch.t matches 20 run playsound minecraft:block.respawn_anchor.set_spawn player @a ~ ~ ~ 0.6 1.8
execute if score @s ch.t matches 20 rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:9059583,s0:0.2,s1:2.4,t:5,life:8,spin:120,dy:0.0}
execute if score @s ch.t matches ..19 run particle minecraft:portal ~ ~ ~ 0.2 0.2 0.2 0.5 3
execute if score #vt ch.tmp matches 0 run particle minecraft:dust{color:[0.039,0.0,0.078],scale:0.7} ~ ~ ~ 0.1 0.1 0.1 0 1
execute if score #vt ch.tmp matches 5 run particle minecraft:reverse_portal ~ ~ ~ 0.05 0.05 0.05 0.01 1
execute if score @s ch.t matches 20.. if entity @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..3,limit=1] run function ch:kit/void/orb/trip_start
