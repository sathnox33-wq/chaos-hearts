# Frozen Bastion: 8 ice pillars ring you at 3 blocks; enemies inside are thrown out and you gain Resistance II and Absorption.
scoreboard players set #f_cd ch.tmp 0
execute rotated 0 0 positioned ^ ^ ^3 run function ch:kit/frozen/wall/col_at
scoreboard players set #f_cd ch.tmp 1
execute rotated 45 0 positioned ^ ^ ^3 run function ch:kit/frozen/wall/col_at
scoreboard players set #f_cd ch.tmp 0
execute rotated 90 0 positioned ^ ^ ^3 run function ch:kit/frozen/wall/col_at
scoreboard players set #f_cd ch.tmp 1
execute rotated 135 0 positioned ^ ^ ^3 run function ch:kit/frozen/wall/col_at
scoreboard players set #f_cd ch.tmp 0
execute rotated 180 0 positioned ^ ^ ^3 run function ch:kit/frozen/wall/col_at
scoreboard players set #f_cd ch.tmp 1
execute rotated 225 0 positioned ^ ^ ^3 run function ch:kit/frozen/wall/col_at
scoreboard players set #f_cd ch.tmp 0
execute rotated 270 0 positioned ^ ^ ^3 run function ch:kit/frozen/wall/col_at
scoreboard players set #f_cd ch.tmp 1
execute rotated 315 0 positioned ^ ^ ^3 run function ch:kit/frozen/wall/col_at
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..3.5] run function ch:api/push {s:0.9,y:0.3}
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..3.5] run function ch:api/cc {effect:"minecraft:slowness",sec:2,amp:1}
effect give @s minecraft:resistance 4 1 true
effect give @s minecraft:absorption 6 0 true
execute rotated 0 0 positioned ~ ~0.1 ~ run function ch:api/fx/sprite {model:"dome",color:10217471,s0:7.0,s1:6.0,t:6,life:12,spin:90,dy:0.0}
execute rotated 0 0 positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"hex",color:6273256,s0:1.0,s1:7.0,t:6,life:30,spin:170,dy:0.0}
particle minecraft:snowflake ~ ~1 ~ 2 1 2 0.05 50
function ch:api/fx/screen {o:"frozen",color:"#9BE7FF",in:1,stay:4,out:10}
return 1
