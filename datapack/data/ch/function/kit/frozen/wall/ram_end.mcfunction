# A ram block bursts apart.
particle minecraft:block{block_state:"minecraft:packed_ice"} ~ ~0.5 ~ 0.4 0.4 0.4 0.15 20
function ch:api/fx/sprite {model:"shard",color:10217471,s0:0.6,s1:0.1,t:8,life:10,spin:170,dy:1.5}
playsound minecraft:block.glass.break block @a ~ ~ ~ 0.6 0.9
tag @e[tag=ch.frozen.rh,distance=..16] remove ch.frozen.rh
tag @a remove ch.caster
kill @s
