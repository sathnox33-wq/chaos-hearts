# Phase 2: hellgates open and two Cinderlings join the fight.
function ch:trials/infernal/callout {t:"Ignaroth calls the fires of the deep!"}
function ch:trials/infernal/gates
summon minecraft:blaze ~3 ~4 ~0 {Tags:["ch.tmob","ch.infernal.tm","ch.infernal.tnew"],CustomName:{text:"Cinderling",color:"#FF7A1A"},CustomNameVisible:1b,PersistenceRequired:1b,attributes:[{id:"minecraft:max_health",base:26},{id:"minecraft:follow_range",base:48}],Health:26f}
summon minecraft:blaze ~-3 ~4 ~0 {Tags:["ch.tmob","ch.infernal.tm","ch.infernal.tnew"],CustomName:{text:"Cinderling",color:"#FF7A1A"},CustomNameVisible:1b,PersistenceRequired:1b,attributes:[{id:"minecraft:max_health",base:26},{id:"minecraft:follow_range",base:48}],Health:26f}
execute as @e[tag=ch.infernal.tnew,distance=..60] at @s run function ch:trials/infernal/spawn_fx
execute as @e[tag=ch.infernal.tnew,distance=..60] run function ch:api/trial/adopt
tag @e[tag=ch.infernal.tnew] remove ch.infernal.tnew
