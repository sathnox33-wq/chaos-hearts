# A Communion mob rises out of a gout of blood.
function ch:api/fx/pillar {model:"flame",color:10357535,w:1.4,h:3.0,t:3,life:12}
function ch:api/fx/wave {color:10357535,r:2.5,t:5}
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~0.5 ~ 0.5 0.5 0.5 0.3 30
playsound minecraft:entity.slime.squish master @a[distance=..90] ~ ~ ~ 1.2 0.5
