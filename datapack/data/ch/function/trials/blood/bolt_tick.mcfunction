# A blood bolt counting down; impact deals 7 within 2.2 and opens a bleed.
scoreboard players remove @s ch.life 1
execute if score @s ch.life matches 1.. run return 0
function ch:api/fx/pillar {model:"beam",color:16723263,w:1.0,h:18.0,t:2,life:8}
function ch:api/fx/wave {color:10357535,r:2.5,t:4}
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~0.5 ~ 0.8 0.3 0.8 0.3 40
playsound minecraft:entity.lightning_bolt.impact master @a[distance=..90] ~ ~ ~ 1.2 0.6
tag @e[type=evoker,tag=ch.blood.boss,distance=..80,limit=1] add ch.caster
execute as @a[tag=ch.challenger,distance=..2.2] run function ch:trials/blood/bolt_hit
tag @e[tag=ch.caster] remove ch.caster
kill @s
