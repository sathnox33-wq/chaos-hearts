# Recoil trap detonates: three crossing cuts and a shock ring.
execute unless entity @a[tag=ch.caster,limit=1] run return 0
scoreboard players operation #d ch.speed.g = @s ch.v1
execute positioned ~ ~1 ~ rotated 0 90 run function ch:api/fx/sprite {model:"slash",color:16777215,s0:0.5,s1:4.0,t:2,life:6,spin:150,dy:0.0}
execute positioned ~ ~1 ~ rotated 60 90 run function ch:api/fx/sprite {model:"slash",color:16113986,s0:0.5,s1:4.0,t:2,life:6,spin:150,dy:0.0}
execute positioned ~ ~1 ~ rotated 120 90 run function ch:api/fx/sprite {model:"slash",color:2741234,s0:0.5,s1:4.0,t:2,life:6,spin:150,dy:0.0}
function ch:api/fx/wave {color:16113986,r:3.5,t:5}
particle minecraft:sweep_attack ~ ~1 ~ 1 0.4 1 0 8
particle minecraft:electric_spark ~ ~1 ~ 1 0.6 1 0.4 30
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:4}
playsound minecraft:entity.player.attack.sweep player @a ~ ~ ~ 1.2 0.8
playsound chaoshearts:speed_dash player @a ~ ~ ~ 1 0.7
function ch:api/fx/shake {s:2,t:6,r:6}
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..3.4] run function ch:kit/speed/dash/trap_hit
