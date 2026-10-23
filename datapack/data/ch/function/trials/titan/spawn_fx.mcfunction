# A trial mob claws its way out of the ground.
particle minecraft:block{block_state:"minecraft:stone_bricks"} ~ ~0.5 ~ 0.5 0.4 0.5 0.15 30
particle minecraft:campfire_cosy_smoke ~ ~0.3 ~ 0.4 0.1 0.4 0.02 4
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:8025194,w:1.0,h:4.0,t:4,life:12}
playsound minecraft:block.stone.break master @a ~ ~ ~ 1 0.6
