# The dash itself, as the player at the end of it: light streaks from start to end, a sonic ring behind, a flash ahead.
execute store result storage ch:kspeed b.len float 0.5 run scoreboard players get #steps ch.speed.g
data modify storage ch:kspeed b.color set value 16113986
data modify storage ch:kspeed b.w set value 0.55
data modify storage ch:kspeed b.t set value 2
data modify storage ch:kspeed b.life set value 9
execute at @e[type=marker,tag=ch.speed.ds,limit=1] rotated as @e[type=marker,tag=ch.speed.ds,limit=1] positioned ~ ~1 ~ run function ch:api/fx/beam with storage ch:kspeed b
data modify storage ch:kspeed b.color set value 16777215
data modify storage ch:kspeed b.w set value 0.16
data modify storage ch:kspeed b.life set value 7
execute at @e[type=marker,tag=ch.speed.ds,limit=1] rotated as @e[type=marker,tag=ch.speed.ds,limit=1] positioned ~ ~1 ~ run function ch:api/fx/beam with storage ch:kspeed b
execute if score @s ch.awake matches 1 run data modify storage ch:kspeed b.color set value 2741234
execute if score @s ch.awake matches 1 run data modify storage ch:kspeed b.w set value 0.9
execute if score @s ch.awake matches 1 at @e[type=marker,tag=ch.speed.ds,limit=1] rotated as @e[type=marker,tag=ch.speed.ds,limit=1] positioned ~ ~1 ~ run function ch:api/fx/beam with storage ch:kspeed b
execute at @e[type=marker,tag=ch.speed.ds,limit=1] rotated as @e[type=marker,tag=ch.speed.ds,limit=1] positioned ~ ~1 ~ rotated ~ ~90 run function ch:api/fx/sprite {model:"ring",color:16777215,s0:0.3,s1:3.4,t:4,life:7,spin:0,dy:0.0}
execute at @e[type=marker,tag=ch.speed.ds,limit=1] rotated as @e[type=marker,tag=ch.speed.ds,limit=1] positioned ~ ~1 ~ rotated ~ ~90 run function ch:api/fx/sprite {model:"ring_soft",color:16113986,s0:0.6,s1:4.6,t:6,life:9,spin:0,dy:0.0}
execute at @e[type=marker,tag=ch.speed.ds,limit=1] run particle minecraft:cloud ~ ~1 ~ 0.3 0.6 0.3 0.03 14
execute at @e[type=marker,tag=ch.speed.ds,limit=1] run particle minecraft:dust{color:[0.96,0.88,0.26],scale:1.2} ~ ~1 ~ 0.25 0.7 0.25 0 20
execute at @e[type=marker,tag=ch.speed.ds,limit=1] run playsound minecraft:entity.breeze.wind_burst player @a ~ ~ ~ 0.8 1.6
function ch:api/fx/orb {color:16771466,s:1.6,t:2,life:5}
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:4}
function ch:api/fx/wave {color:2741234,r:2.5,t:5}
particle minecraft:end_rod ~ ~1 ~ 0.3 0.5 0.3 0.15 14
playsound chaoshearts:speed_dash player @a ~ ~ ~ 1 1
playsound minecraft:entity.enderman.teleport player @a ~ ~ ~ 0.4 2
execute if score #hits ch.tmp matches 1.. run playsound minecraft:entity.player.attack.sweep player @a ~ ~ ~ 1 1.5
function ch:api/fx/screen {o:"speed",color:"#F5E142",in:0,stay:2,out:6}
