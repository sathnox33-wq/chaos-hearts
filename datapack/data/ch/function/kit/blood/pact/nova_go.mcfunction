# Sanguine Nova: 5 damage (+10% on bleeding with Open Veins) and a 3 s bleed within 5; drink 1.5 per enemy hit.
tag @s add ch.caster
scoreboard players set #sd ch.tmp 50
scoreboard players set #bt ch.tmp 60
scoreboard players set #bm ch.tmp 0
scoreboard players set #hits ch.tmp 0
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..5] run function ch:kit/blood/pact/nova_hit
tag @s remove ch.caster
scoreboard players operation #dk ch.tmp = #hits ch.tmp
scoreboard players operation #dk ch.tmp *= #15 ch.blood.g
scoreboard players set #bk ch.tmp 0
function ch:kit/blood/drink
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:16723263,s:5.0,t:3,life:6}
function ch:api/fx/wave {color:10357535,r:5.0,t:5}
execute positioned ~ ~1 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"ring_soft",color:16723263,s0:1.0,s1:9.0,t:4,life:7,spin:0,dy:0.0}
execute positioned ~ ~1 ~ rotated ~90 90 run function ch:api/fx/sprite {model:"ring_soft",color:10357535,s0:1.0,s1:9.0,t:4,life:7,spin:0,dy:0.0}
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~1 ~ 1.8 0.8 1.8 0.4 90
particle minecraft:dust{color:[0.17,0.0,0.02],scale:2.2} ~ ~0.5 ~ 2.5 0.4 2.5 0 50
function ch:api/fx/shake {s:2,t:8,r:10}
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:6}
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 0.8 1.3
playsound minecraft:entity.slime.squish player @a ~ ~ ~ 1.4 0.4
playsound chaoshearts:blood_pact player @a ~ ~ ~ 1 0.7
