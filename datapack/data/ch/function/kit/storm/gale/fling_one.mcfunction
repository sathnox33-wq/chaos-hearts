# As an enemy flung out of the cyclone.
function ch:kit/storm/fn/zap
effect clear @s minecraft:levitation
execute positioned as @e[type=marker,tag=ch.storm.cyc,limit=1,sort=nearest] run function ch:api/push {s:2.1,y:0.7}
