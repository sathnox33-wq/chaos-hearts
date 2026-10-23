# The Supernova bursts: 18 damage and blindness to the challenger if it can see Astrael.
function ch:api/fx/orb {color:16777215,s:22.0,t:3,life:8}
execute rotated 0 0 run function ch:api/fx/sprite {model:"star",color:16763210,s0:2.0,s1:30.0,t:5,life:10,spin:170,dy:0.0}
particle minecraft:explosion_emitter ~ ~ ~ 0 0 0 0 1
particle minecraft:end_rod ~ ~ ~ 1 1 1 0.9 300
playsound minecraft:entity.generic.explode master @a ~ ~ ~ 3 0.5
playsound chaoshearts:celestial_nova master @a ~ ~ ~ 3 1
function ch:api/fx/shake {s:3,t:16,r:60}
scoreboard players set #ce_los ch.tmp 0
scoreboard players set #ce_n ch.tmp 0
execute facing entity @a[tag=ch.challenger,limit=1] eyes run function ch:trials/celestial/los
execute if score #ce_los ch.tmp matches 1 as @a[tag=ch.challenger,limit=1] run function ch:trials/celestial/nova_hurt
execute if score #ce_los ch.tmp matches 0 as @a[tag=ch.challenger,limit=1] run function ch:trials/celestial/callout {m:"The pillar shields you."}
