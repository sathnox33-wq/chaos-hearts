# A projectile flashes to ash; Firewall feat progress.
particle minecraft:lava ~ ~ ~ 0.1 0.1 0.1 0 4
particle minecraft:flame ~ ~ ~ 0.15 0.15 0.15 0.08 12
particle minecraft:large_smoke ~ ~ ~ 0.1 0.1 0.1 0.03 4
function ch:api/fx/sprite {model:"star",color:16765503,s0:0.3,s1:1.6,t:3,life:5,spin:170,dy:0.0}
playsound minecraft:block.fire.extinguish player @a ~ ~ ~ 0.7 1.4
scoreboard players add @a[tag=ch.caster,limit=1] ch.infernal.proj 1
execute as @a[tag=ch.caster,scores={ch.infernal.proj=10..},limit=1] run function ch:api/feat {h:"infernal",n:2}
