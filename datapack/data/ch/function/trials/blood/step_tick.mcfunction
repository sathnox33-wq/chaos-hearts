# The step destination bubbling; at zero Vesperine bursts out of it (4 damage within 3).
scoreboard players remove @s ch.life 1
particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~3 ~ 0.6 0.5 0.6 0 3
execute if score @s ch.life matches 1.. run return 0
execute as @e[type=evoker,tag=ch.blood.boss,distance=..80,limit=1] at @s run function ch:trials/blood/step_out
tp @e[type=evoker,tag=ch.blood.boss,distance=..80,limit=1] @s
function ch:api/fx/pillar {model:"beam",color:10357535,w:1.6,h:6.0,t:3,life:10}
function ch:api/fx/wave {color:16723263,r:3.0,t:5}
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~1 ~ 1 1 1 0.4 60
playsound minecraft:entity.illusioner.mirror_move master @a[distance=..90] ~ ~ ~ 2 0.6
tag @e[type=evoker,tag=ch.blood.boss,distance=..80,limit=1] add ch.caster
execute as @a[tag=ch.challenger,distance=..3] run function ch:api/hit {d:40}
tag @e[tag=ch.caster] remove ch.caster
kill @s
