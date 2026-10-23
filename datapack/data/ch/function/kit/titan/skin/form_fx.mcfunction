# The skin forms: shards fly in and lock on, a shell flashes over the Titan, three shards begin to orbit.
function ch:kit/titan/fx/converge
function ch:kit/titan/fx/orbit_spawn
execute positioned ~ ~1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"dome",color:8025194,s0:3.2,s1:2.2,t:4,life:9,spin:60,dy:0.0}
execute positioned ~ ~0.05 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:13214812,s0:0.6,s1:3.0,t:6,life:16,spin:120,dy:0.0}
particle minecraft:block{block_state:"minecraft:stone"} ~ ~1 ~ 0.6 0.8 0.6 0.1 60
particle minecraft:dust{color:[0.788,0.643,0.361],scale:1.2} ~ ~1 ~ 0.7 0.8 0.7 0 40
playsound chaoshearts:titan_stoneskin player @a ~ ~ ~ 1 1
playsound minecraft:block.stone.place player @a ~ ~ ~ 1.2 0.5
playsound minecraft:block.anvil.use player @a ~ ~ ~ 0.6 0.6
function ch:api/fx/screen {o:"titan",color:"#7A746A",in:2,stay:4,out:12}
function ch:api/fx/shake {s:1,t:4,r:3}
