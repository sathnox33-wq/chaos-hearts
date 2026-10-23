# A blood spike stabs up (6 damage within 1.3 and a 4 s bleed).
execute unless block ~ ~ ~ #ch:passable run return 0
function ch:api/fx/sprite3 {model:"spike",color:10357535,a:"[0.4,0.05,0.4]",b:"[0.9,2.4,0.9]",t:2,life:14,spin:45}
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~0.5 ~ 0.3 0.3 0.3 0.2 12
playsound minecraft:block.pointed_dripstone.land master @a[distance=..90] ~ ~ ~ 1.2 0.7
tag @e[type=evoker,tag=ch.blood.boss,distance=..80,limit=1] add ch.caster
execute as @a[tag=ch.challenger,distance=..1.3] run function ch:trials/blood/spike_hit
tag @e[tag=ch.caster] remove ch.caster
