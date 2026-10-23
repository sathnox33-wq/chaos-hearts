# The orb ends: implosion damage by variant, Gravity Well feat, Collapse spawns a miniature Singularity.
scoreboard players operation #vd ch.tmp = @s ch.v4
scoreboard players operation #vd ch.tmp *= #2 ch.g
execute if score @s ch.v1 matches 1 run scoreboard players operation #vd ch.tmp = @s ch.v4
execute if score @s ch.v1 matches 1 run scoreboard players operation #vd ch.tmp *= #3 ch.void.k
execute if score @s ch.v1 matches 3 run scoreboard players operation #vd ch.tmp = @s ch.v4
execute if score @s ch.v1 matches 3 run scoreboard players operation #vd ch.tmp *= #34 ch.void.k
execute if score @s ch.v1 matches 3 run scoreboard players operation #vd ch.tmp /= #10 ch.g
execute if score @s ch.v1 matches 2 run return run function ch:kit/void/orb/fizzle
execute if score @s ch.v1 matches 1 as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..5.5,limit=12] run function ch:kit/void/orb/slam
execute unless score @s ch.v1 matches 1 as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..3.5,limit=12] run function ch:kit/void/orb/burst
playsound chaoshearts:void_collapse player @a ~ ~ ~ 1 1.3
playsound minecraft:entity.ender_eye.death player @a ~ ~ ~ 1 0.5
particle minecraft:reverse_portal ~ ~ ~ 0.2 0.2 0.2 0.8 80
particle minecraft:dust{color:[0.827,0.549,1.0],scale:1.8} ~ ~ ~ 1.2 1.2 1.2 0 30
particle minecraft:sonic_boom ~ ~ ~ 0 0 0 0 1
function ch:api/fx/sprite {model:"star",color:15259903,s0:0.2,s1:3.0,t:2,life:5,spin:150,dy:0.0}
function ch:api/fx/orb {color:9059583,s:3.6,t:3,life:6}
execute rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:13864191,s0:0.4,s1:8.0,t:4,life:7,spin:170,dy:0.0}
function ch:api/fx/light {t:5}
function ch:api/fx/shake {s:2,t:6,r:10}
execute if score @s ch.v1 matches 1 run function ch:kit/void/orb/slam_fx
execute if score @s ch.v3 matches 3.. as @a[tag=ch.caster,limit=1] run function ch:api/feat {h:"void",n:1}
execute if score @s ch.v5 matches 1 run function ch:kit/void/sing/mini
kill @s
