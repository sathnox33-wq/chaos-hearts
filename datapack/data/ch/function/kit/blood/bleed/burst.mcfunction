# Hemorrhagic Burst (Hemomancer capstone), at a bleeding enemy that died: it bursts, and everyone near it bleeds.
scoreboard players set #bt ch.tmp 80
scoreboard players set #bm ch.tmp 0
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=0.5..4] run function ch:kit/blood/bleed/burst_hit
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:16723263,s:3.5,t:3,life:7}
execute positioned ~ ~1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:10357535,s0:0.5,s1:8.0,t:4,life:8,spin:120,dy:0.0}
execute positioned ~ ~1 ~ rotated 0 90 run function ch:api/fx/sprite {model:"ring_soft",color:2818054,s0:0.5,s1:6.0,t:5,life:9,spin:0,dy:0.0}
function ch:api/fx/wave {color:10357535,r:4.0,t:6}
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~1 ~ 1 1 1 0.4 70
particle minecraft:dust{color:[0.17,0.0,0.02],scale:2.0} ~ ~1 ~ 1.2 1 1.2 0 30
function ch:api/fx/shake {s:1,t:5,r:8}
playsound minecraft:entity.slime.squish player @a ~ ~ ~ 1.2 0.5
playsound minecraft:entity.warden.heartbeat player @a ~ ~ ~ 1 1.5
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 0.5 1.4
