# The stomp lands: 7 damage, launch and slowness within 6 blocks.
scoreboard players set #ti_big ch.tmp 1
function ch:kit/titan/fx/ring8
function ch:kit/titan/fx/ring12
function ch:api/fx/wave {color:13214812,r:6.5,t:6}
particle minecraft:explosion_emitter ~ ~0.5 ~ 0 0 0 0 1
playsound chaoshearts:titan_quake master @a ~ ~ ~ 2 0.8
playsound minecraft:item.mace.smash_ground_heavy master @a ~ ~ ~ 2 0.5
function ch:api/fx/shake {s:3,t:10,r:14}
execute as @a[tag=ch.challenger,distance=..6] run function ch:trials/titan/stomp_hurt
