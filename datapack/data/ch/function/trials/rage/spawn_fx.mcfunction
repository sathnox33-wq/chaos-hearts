# A Crucible mob bursts out of the ground.
function ch:api/fx/pillar {model:"flame",color:16738847,w:1.4,h:3.5,t:3,life:12}
function ch:api/fx/wave {color:14689835,r:2.5,t:5}
particle minecraft:block{block_state:"minecraft:blackstone"} ~ ~0.3 ~ 0.6 0.2 0.6 0.2 30
particle minecraft:lava ~ ~0.3 ~ 0.4 0.1 0.4 0 5
playsound minecraft:block.basalt.break master @a[distance=..90] ~ ~ ~ 1.2 0.5
