# A mob steps out of a burst of snow.
function ch:api/fx/sprite3 {model:"spike",color:10217471,a:"[1.2,0.2,1.2]",b:"[0.3,3.0,0.3]",t:6,life:10,spin:90}
particle minecraft:snowflake ~ ~1 ~ 0.5 1 0.5 0.08 40
particle minecraft:block{block_state:"minecraft:snow_block"} ~ ~0.5 ~ 0.5 0.3 0.5 0.1 20
playsound minecraft:block.powder_snow.break master @a[distance=..60] ~ ~ ~ 1 0.7
