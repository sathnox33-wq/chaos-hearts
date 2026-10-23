# At the centre: snow between 7 and 13 blocks turns to blue ice.
fill ~0 ~-1 ~-13 ~0 ~-1 ~-13 minecraft:blue_ice replace minecraft:snow_block
fill ~-5 ~-1 ~-12 ~5 ~-1 ~-12 minecraft:blue_ice replace minecraft:snow_block
fill ~-6 ~-1 ~-11 ~6 ~-1 ~-11 minecraft:blue_ice replace minecraft:snow_block
fill ~-8 ~-1 ~-10 ~8 ~-1 ~-10 minecraft:blue_ice replace minecraft:snow_block
fill ~-9 ~-1 ~-9 ~9 ~-1 ~-9 minecraft:blue_ice replace minecraft:snow_block
fill ~-10 ~-1 ~-8 ~10 ~-1 ~-8 minecraft:blue_ice replace minecraft:snow_block
fill ~-10 ~-1 ~-7 ~10 ~-1 ~-7 minecraft:blue_ice replace minecraft:snow_block
fill ~-11 ~-1 ~-6 ~-4 ~-1 ~-6 minecraft:blue_ice replace minecraft:snow_block
fill ~4 ~-1 ~-6 ~11 ~-1 ~-6 minecraft:blue_ice replace minecraft:snow_block
fill ~-12 ~-1 ~-5 ~-5 ~-1 ~-5 minecraft:blue_ice replace minecraft:snow_block
fill ~5 ~-1 ~-5 ~12 ~-1 ~-5 minecraft:blue_ice replace minecraft:snow_block
fill ~-12 ~-1 ~-4 ~-6 ~-1 ~-4 minecraft:blue_ice replace minecraft:snow_block
fill ~6 ~-1 ~-4 ~12 ~-1 ~-4 minecraft:blue_ice replace minecraft:snow_block
fill ~-12 ~-1 ~-3 ~-7 ~-1 ~-3 minecraft:blue_ice replace minecraft:snow_block
fill ~7 ~-1 ~-3 ~12 ~-1 ~-3 minecraft:blue_ice replace minecraft:snow_block
fill ~-12 ~-1 ~-2 ~-7 ~-1 ~-2 minecraft:blue_ice replace minecraft:snow_block
fill ~7 ~-1 ~-2 ~12 ~-1 ~-2 minecraft:blue_ice replace minecraft:snow_block
fill ~-12 ~-1 ~-1 ~-7 ~-1 ~-1 minecraft:blue_ice replace minecraft:snow_block
fill ~7 ~-1 ~-1 ~12 ~-1 ~-1 minecraft:blue_ice replace minecraft:snow_block
fill ~-13 ~-1 ~0 ~-8 ~-1 ~0 minecraft:blue_ice replace minecraft:snow_block
fill ~8 ~-1 ~0 ~13 ~-1 ~0 minecraft:blue_ice replace minecraft:snow_block
fill ~-12 ~-1 ~1 ~-7 ~-1 ~1 minecraft:blue_ice replace minecraft:snow_block
fill ~7 ~-1 ~1 ~12 ~-1 ~1 minecraft:blue_ice replace minecraft:snow_block
fill ~-12 ~-1 ~2 ~-7 ~-1 ~2 minecraft:blue_ice replace minecraft:snow_block
fill ~7 ~-1 ~2 ~12 ~-1 ~2 minecraft:blue_ice replace minecraft:snow_block
fill ~-12 ~-1 ~3 ~-7 ~-1 ~3 minecraft:blue_ice replace minecraft:snow_block
fill ~7 ~-1 ~3 ~12 ~-1 ~3 minecraft:blue_ice replace minecraft:snow_block
fill ~-12 ~-1 ~4 ~-6 ~-1 ~4 minecraft:blue_ice replace minecraft:snow_block
fill ~6 ~-1 ~4 ~12 ~-1 ~4 minecraft:blue_ice replace minecraft:snow_block
fill ~-12 ~-1 ~5 ~-5 ~-1 ~5 minecraft:blue_ice replace minecraft:snow_block
fill ~5 ~-1 ~5 ~12 ~-1 ~5 minecraft:blue_ice replace minecraft:snow_block
fill ~-11 ~-1 ~6 ~-4 ~-1 ~6 minecraft:blue_ice replace minecraft:snow_block
fill ~4 ~-1 ~6 ~11 ~-1 ~6 minecraft:blue_ice replace minecraft:snow_block
fill ~-10 ~-1 ~7 ~10 ~-1 ~7 minecraft:blue_ice replace minecraft:snow_block
fill ~-10 ~-1 ~8 ~10 ~-1 ~8 minecraft:blue_ice replace minecraft:snow_block
fill ~-9 ~-1 ~9 ~9 ~-1 ~9 minecraft:blue_ice replace minecraft:snow_block
fill ~-8 ~-1 ~10 ~8 ~-1 ~10 minecraft:blue_ice replace minecraft:snow_block
fill ~-6 ~-1 ~11 ~6 ~-1 ~11 minecraft:blue_ice replace minecraft:snow_block
fill ~-5 ~-1 ~12 ~5 ~-1 ~12 minecraft:blue_ice replace minecraft:snow_block
fill ~0 ~-1 ~13 ~0 ~-1 ~13 minecraft:blue_ice replace minecraft:snow_block
execute positioned ~20 ~1 ~8 run function ch:api/fx/pillar {model:"beam",color:15924223,w:0.8,h:16.0,t:6,life:30}
execute positioned ~8 ~1 ~20 run function ch:api/fx/pillar {model:"beam",color:15924223,w:0.8,h:16.0,t:6,life:30}
execute positioned ~-8 ~1 ~20 run function ch:api/fx/pillar {model:"beam",color:15924223,w:0.8,h:16.0,t:6,life:30}
execute positioned ~-20 ~1 ~8 run function ch:api/fx/pillar {model:"beam",color:15924223,w:0.8,h:16.0,t:6,life:30}
execute positioned ~-20 ~1 ~-8 run function ch:api/fx/pillar {model:"beam",color:15924223,w:0.8,h:16.0,t:6,life:30}
execute positioned ~-8 ~1 ~-20 run function ch:api/fx/pillar {model:"beam",color:15924223,w:0.8,h:16.0,t:6,life:30}
execute positioned ~8 ~1 ~-20 run function ch:api/fx/pillar {model:"beam",color:15924223,w:0.8,h:16.0,t:6,life:30}
execute positioned ~20 ~1 ~-8 run function ch:api/fx/pillar {model:"beam",color:15924223,w:0.8,h:16.0,t:6,life:30}
playsound minecraft:block.glass.break master @a[distance=..90] ~ ~ ~ 3 0.5
