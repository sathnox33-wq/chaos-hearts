# Aims a charge: a direction marker facing the challenger and the lane telegraph.
kill @e[type=marker,tag=ch.rage.bdir,distance=..64]
summon marker ~ ~ ~ {Tags:["ch.rage.bdir","ch.tmob","ch.noability"]}
execute as @e[type=marker,tag=ch.rage.bdir,distance=..1,limit=1] at @s facing entity @a[tag=ch.challenger,distance=..80,limit=1] feet run tp @s ~ ~ ~ ~ 0
scoreboard players set @s ch.v2 1
scoreboard players set @s ch.v3 20
function ch:trials/rage/freeze
execute rotated as @e[type=marker,tag=ch.rage.bdir,distance=..1,limit=1] run tp @s ~ ~ ~ ~ 0
execute rotated as @e[type=marker,tag=ch.rage.bdir,distance=..1,limit=1] positioned ~ ~0.12 ~ rotated ~ 90 run function ch:api/fx/sprite3 {model:"beam",color:14689835,a:"[2.8,0.5,0.05]",b:"[2.8,20.0,0.05]",t:8,life:30,spin:0}
playsound minecraft:entity.ravager.step master @a[distance=..90] ~ ~ ~ 2 0.5
playsound chaoshearts:trial_telegraph master @a[distance=..90] ~ ~ ~ 1.2 1
particle minecraft:campfire_cosy_smoke ~ ~0.3 ~ 0.8 0.1 0.8 0.02 10
