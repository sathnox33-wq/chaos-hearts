# As the Momentum victim: blown away, a ring of compressed air, and a delayed boom primed on it.
execute at @a[tag=ch.caster,limit=1] run function ch:api/push {s:1.2,y:0.45}
scoreboard players set @s ch.speed.boom 11
scoreboard players operation @s ch.speed.bd = #d ch.speed.g
scoreboard players operation @s ch.speed.bo = #pid ch.speed.g
scoreboard players set #boom ch.speed.g 1
execute rotated as @a[tag=ch.caster,limit=1] positioned ~ ~1 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"ring",color:16777215,s0:0.3,s1:2.6,t:3,life:6,spin:0,dy:0.0}
execute rotated as @a[tag=ch.caster,limit=1] positioned ~ ~1 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"ring_soft",color:16113986,s0:0.5,s1:3.6,t:5,life:8,spin:0,dy:0.0}
particle minecraft:electric_spark ~ ~1 ~ 0.3 0.6 0.3 0.6 25
particle minecraft:sweep_attack ~ ~1 ~ 0.3 0.3 0.3 0 2
execute if entity @s[type=player] run function ch:api/fx/screen {o:"speed",color:"#FFFFFF",in:0,stay:2,out:6}
function ch:api/fx/shake {s:2,t:6,r:1.5}
