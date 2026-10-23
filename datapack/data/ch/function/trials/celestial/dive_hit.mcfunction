# Astrael crashes down: 8 damage and knockback within 3.5 blocks.
tp @e[tag=ch.celestial.boss,distance=..80,limit=1] ~ ~0.2 ~
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16777215,w:2.0,h:14.0,t:2,life:8}
function ch:kit/celestial/star/boom {r:3.5,d:5.0}
particle minecraft:explosion_emitter ~ ~0.5 ~ 0 0 0 0 1
function ch:api/fx/shake {s:3,t:8,r:12}
tag @e[tag=ch.celestial.boss,distance=..80,limit=1] add ch.caster
execute positioned ~ ~0.8 ~ as @a[tag=ch.challenger,distance=..3.5] run function ch:trials/celestial/dive_hurt
tag @e[tag=ch.celestial.boss,distance=..80] remove ch.caster
