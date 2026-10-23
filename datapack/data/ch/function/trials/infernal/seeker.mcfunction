# A seeking fireball hunts the challenger.
rotate @s facing entity @a[tag=ch.challenger,distance=..90,limit=1,sort=nearest] eyes
function ch:api/proj {item:"minecraft:fire_charge",scale:1.3,speed:3,life:100,hit:"ch:trials/infernal/sk_hit",step:"ch:trials/infernal/sk_step",end:"ch:trials/infernal/sk_end",pierce:0,ignore:"ch.tmob"}
tag @e[type=item_display,tag=ch.lnew] add ch.tmob
tag @e[type=item_display,tag=ch.lnew] remove ch.lnew
playsound minecraft:entity.blaze.shoot master @a[distance=..90] ~ ~ ~ 1.5 0.8
