# Phase 2+: the brood hatches - three Broodlings burst out of the boss's egg sacs.
execute as @a[tag=ch.challenger,limit=1] run function ch:core/msg/say {m:"The brood hatches!",c:"#7BD13A"}
playsound minecraft:entity.turtle.egg_hatch hostile @a ~ ~ ~ 2 0.5
summon cave_spider ~1 ~1 ~ {Tags:["ch.corruption.tn"],CustomName:{text:"Broodling",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:10.0},{id:"minecraft:attack_damage",base:3.0}],Health:10f}
summon cave_spider ~-1 ~1 ~ {Tags:["ch.corruption.tn"],CustomName:{text:"Broodling",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:10.0},{id:"minecraft:attack_damage",base:3.0}],Health:10f}
summon cave_spider ~ ~1 ~1 {Tags:["ch.corruption.tn"],CustomName:{text:"Broodling",color:"#7BD13A"},attributes:[{id:"minecraft:max_health",base:10.0},{id:"minecraft:attack_damage",base:3.0}],Health:10f}
particle minecraft:item_slime ~ ~2 ~ 0.8 0.6 0.8 0.2 40
function ch:trials/corruption/spawn_fx
execute as @e[tag=ch.corruption.tn,distance=..6] run function ch:trials/corruption/adopt
