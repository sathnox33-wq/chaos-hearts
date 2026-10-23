# A frost front sweeps up the wall line.
function ch:api/fx/sprite3 {model:"slash",color:15924223,a:"[1.0,1.0,1.0]",b:"[6.0,3.0,1.5]",t:4,life:8,spin:0}
particle minecraft:snowflake ~ ~ ~ 2.5 1 0.3 0.05 40
particle minecraft:block{block_state:"minecraft:packed_ice"} ~ ~ ~ 2.5 0.8 0.3 0.1 30
function ch:api/fx/shake {s:1,t:4,r:8}
