# Cinder Charge: Ignaroth roots himself, a burning line marks his path to you, then he tears along it.
function ch:trials/infernal/callout {t:"Ignaroth lowers his blade... dodge sideways!"}
effect give @s minecraft:slowness 2 9 true
execute facing entity @a[tag=ch.challenger,distance=..90,limit=1,sort=nearest] feet positioned ~ 100 ~ summon minecraft:marker run function ch:trials/infernal/dash_init
playsound minecraft:entity.ravager.roar master @a[distance=..90] ~ ~ ~ 1.5 0.7
playsound minecraft:entity.blaze.ambient master @a[distance=..90] ~ ~ ~ 1.5 0.5
