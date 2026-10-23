# Phase 2: she drinks from the pools and the sanctum begins to rain.
scoreboard players set @s ch.v4 30
function ch:api/heal {n:20}
function ch:api/fx/wave {color:10357535,r:14.0,t:12}
function ch:api/fx/pillar {model:"beam",color:16723263,w:2.0,h:20.0,t:4,life:20}
particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~8 ~ 12 1 12 0 150
playsound minecraft:entity.evoker.prepare_wololo master @a[distance=..90] ~ ~ ~ 2 0.5
playsound chaoshearts:blood_drink master @a[distance=..90] ~ ~ ~ 2 0.5
function ch:trials/blood/say {m:"Vesperine drinks from the pools. The sanctum begins to bleed."}
