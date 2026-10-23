# An ice spike flares with cold light.
function ch:api/fx/pillar {model:"beam",color:15924223,w:0.8,h:18.0,t:4,life:18}
function ch:api/fx/sprite3 {model:"spike",color:10217471,a:"[1.5,0.2,1.5]",b:"[2.2,6.0,2.2]",t:4,life:20,spin:60}
particle minecraft:snowflake ~ ~4 ~ 1 4 1 0.05 60
particle minecraft:end_rod ~ ~6 ~ 0.5 4 0.5 0.02 20
function ch:api/fx/light {t:20}
playsound minecraft:block.amethyst_block.resonate master @a[distance=..90] ~ ~ ~ 2 0.6
