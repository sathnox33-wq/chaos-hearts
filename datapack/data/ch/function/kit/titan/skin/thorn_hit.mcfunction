# The attacker is pierced by stone spikes.
function ch:kit/titan/hit
particle minecraft:block{block_state:"minecraft:pointed_dripstone"} ~ ~1 ~ 0.3 0.4 0.3 0.1 12
execute rotated 0 0 run function ch:api/fx/pillar {model:"spike",color:8025194,w:0.4,h:1.4,t:2,life:8}
playsound minecraft:block.pointed_dripstone.break player @a ~ ~ ~ 1 0.8
