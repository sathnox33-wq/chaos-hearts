# A ring of fire rolls out from Ignaroth across the floor: jump over it.
function ch:trials/infernal/callout {t:"A wave of fire! Jump over it!"}
execute positioned ~ 100 ~ run summon minecraft:marker ~ ~ ~ {Tags:["ch.tmob","ch.noability","ch.infernal.twave","ch.infernal.wnew"]}
scoreboard players set @e[type=marker,tag=ch.infernal.wnew,limit=1] ch.v1 10
scoreboard players set @e[type=marker,tag=ch.infernal.wnew,limit=1] ch.life 50
tag @e[type=marker,tag=ch.infernal.wnew] remove ch.infernal.wnew
playsound minecraft:entity.blaze.shoot master @a[distance=..90] ~ ~ ~ 2 0.5
execute positioned ~ 100 ~ rotated 0 0 run function ch:api/fx/wave {color:16742938,r:3.0,t:5}
