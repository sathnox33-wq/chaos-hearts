# $(n) lines of ice spikes race toward the challenger; each spike erupts 14 ticks after its mark.
function ch:trials/frozen/callout {t:"The ice splits toward you... sidestep!"}
playsound minecraft:block.glass.place master @a[distance=..90] ~ ~ ~ 2 0.5
$scoreboard players set #fn ch.tmp $(n)
execute facing entity @a[tag=ch.challenger,distance=..90,limit=1,sort=nearest] feet positioned ~ 100 ~ rotated ~ 0 summon minecraft:marker run function ch:trials/frozen/line_init
execute if score #fn ch.tmp matches 3.. facing entity @a[tag=ch.challenger,distance=..90,limit=1,sort=nearest] feet positioned ~ 100 ~ rotated ~-28 0 summon minecraft:marker run function ch:trials/frozen/line_init
execute if score #fn ch.tmp matches 3.. facing entity @a[tag=ch.challenger,distance=..90,limit=1,sort=nearest] feet positioned ~ 100 ~ rotated ~28 0 summon minecraft:marker run function ch:trials/frozen/line_init
