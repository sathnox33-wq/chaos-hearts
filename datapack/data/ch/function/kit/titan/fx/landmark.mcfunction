# The marked landing spot: a pulsing ember ring and dust where the Titan will hit.
execute if score #ti_r ch.tmp matches 0 positioned ~ ~0.15 ~ run function ch:api/fx/ring {p:"minecraft:dust{color:[1.0,0.478,0.165],scale:1.5}",r:4.5}
execute if score #ti_r ch.tmp matches 1 positioned ~ ~0.15 ~ run function ch:api/fx/ring {p:"minecraft:dust{color:[1.0,0.478,0.165],scale:1.8}",r:6}
particle minecraft:dust{color:[0.788,0.643,0.361],scale:1.2} ~ ~0.2 ~ 1.2 0 1.2 0 6
particle minecraft:falling_dust{block_state:"minecraft:gravel"} ~ ~3 ~ 1.5 1 1.5 0 3
