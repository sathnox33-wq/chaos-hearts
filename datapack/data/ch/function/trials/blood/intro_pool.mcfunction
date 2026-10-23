# A blood pool boils over.
function ch:api/fx/pillar {model:"flame",color:10357535,w:3.0,h:5.0,t:5,life:30}
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~0.5 ~ 1.5 0.5 1.5 0.3 60
particle minecraft:dust{color:[0.62,0.04,0.12],scale:2.5} ~ ~1 ~ 1.5 1 1.5 0 30
playsound minecraft:block.bubble_column.upwards_inside master @a[distance=..90] ~ ~ ~ 2 0.5
playsound minecraft:entity.slime.squish master @a[distance=..90] ~ ~ ~ 1.5 0.5
