# Crimson Step: blood pools where she will reappear (15 ticks), then she dissolves and steps through it.
summon marker ~ ~ ~ {Tags:["ch.blood.step","ch.blood.snew","ch.tmob","ch.noability"]}
execute as @e[type=marker,tag=ch.session,distance=..80,limit=1] at @s run spreadplayers ~ ~ 4 18 under 104 false @e[type=marker,tag=ch.blood.snew]
scoreboard players set @e[type=marker,tag=ch.blood.snew] ch.life 15
execute as @e[type=marker,tag=ch.blood.snew] at @s positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"disc",color:10357535,s0:0.5,s1:4.0,t:14,life:16,spin:0,dy:0.0}
tag @e[type=marker,tag=ch.blood.snew] remove ch.blood.snew
particle minecraft:dust{color:[0.62,0.04,0.12],scale:2.0} ~ ~1.5 ~ 0.6 1 0.6 0 30
playsound minecraft:entity.illusioner.prepare_mirror master @a[distance=..90] ~ ~ ~ 2 0.7
