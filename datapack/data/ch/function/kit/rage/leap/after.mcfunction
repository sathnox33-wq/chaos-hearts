# Slam aftershock (3 ticks later): a dark second wave, smoke and settling dust.
function ch:api/fx/wave {color:3801088,r:5.5,t:9}
particle minecraft:campfire_cosy_smoke ~ ~0.3 ~ 1.2 0.1 1.2 0.02 12
particle minecraft:dust{color:[0.23,0.0,0.0],scale:2.5} ~ ~0.4 ~ 2 0.1 2 0 40
playsound minecraft:block.basalt.break player @a ~ ~ ~ 1 0.5
