# The star appears 16 blocks up and drops onto the sigil over 8 ticks.
execute positioned ~ ~16 ~ summon item_display run function ch:trials/celestial/drop_init
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16773808,w:0.15,h:16.0,t:4,life:9}
execute positioned ~ ~0.15 ~ run function ch:api/fx/ring {p:"minecraft:end_rod",r:2.3}
playsound minecraft:entity.firework_rocket.launch master @a ~ ~ ~ 1 0.8
