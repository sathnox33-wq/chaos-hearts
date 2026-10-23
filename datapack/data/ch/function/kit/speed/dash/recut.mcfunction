# Thousand Cuts: the lingering slash strikes again.
execute unless entity @a[tag=ch.caster,limit=1] run return 0
scoreboard players operation #d ch.speed.g = @s ch.v1
execute rotated 45 0 run function ch:api/fx/sprite {model:"slash",color:16777215,s0:0.4,s1:2.6,t:2,life:6,spin:160,dy:0.0}
execute rotated -45 90 run function ch:api/fx/sprite {model:"slash",color:16113986,s0:0.4,s1:2.4,t:2,life:6,spin:160,dy:0.0}
particle minecraft:sweep_attack ~ ~ ~ 0.6 0.3 0.6 0 3
particle minecraft:electric_spark ~ ~ ~ 0.5 0.5 0.5 0.3 8
playsound minecraft:entity.player.attack.sweep player @a ~ ~ ~ 0.8 1.8
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..1.9] at @s run function ch:kit/speed/fn/hit
