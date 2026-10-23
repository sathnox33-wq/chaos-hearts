# Phase 2+, Crimson Rain: three pools of rain (one on the challenger). Standing in one hurts you and heals her.
function ch:trials/blood/say {m:"Crimson rain! It heals her while you stand in it!"}
execute at @a[tag=ch.challenger,distance=..80,limit=1] run summon marker ~ ~ ~ {Tags:["ch.blood.zone","ch.blood.znew","ch.tmob","ch.noability"]}
execute as @e[type=marker,tag=ch.session,distance=..80,limit=1] at @s run summon marker ~ ~ ~ {Tags:["ch.blood.zone","ch.blood.znew","ch.blood.zsp","ch.tmob","ch.noability"]}
execute as @e[type=marker,tag=ch.session,distance=..80,limit=1] at @s run summon marker ~ ~ ~ {Tags:["ch.blood.zone","ch.blood.znew","ch.blood.zsp","ch.tmob","ch.noability"]}
execute as @e[type=marker,tag=ch.session,distance=..80,limit=1] at @s run spreadplayers ~ ~ 6 18 under 104 false @e[type=marker,tag=ch.blood.zsp,tag=ch.blood.znew]
scoreboard players set @e[type=marker,tag=ch.blood.znew] ch.life 220
execute as @e[type=marker,tag=ch.blood.znew] at @s run function ch:trials/blood/zone_mark
tag @e[type=marker,tag=ch.blood.znew] remove ch.blood.znew
playsound minecraft:weather.rain.above master @a[distance=..90] ~ ~ ~ 2 0.6
