# The lance bursts against what stopped it.
particle minecraft:block{block_state:"minecraft:blue_ice"} ~ ~ ~ 0.4 0.4 0.4 0.2 30
function ch:api/fx/sprite {model:"star",color:15924223,s0:0.5,s1:4.0,t:4,life:8,spin:170,dy:0.0}
function ch:api/fx/orb {color:10217471,s:2.5,t:3,life:6}
function ch:api/fx/light {t:4}
playsound minecraft:block.glass.break player @a ~ ~ ~ 1.2 0.6
