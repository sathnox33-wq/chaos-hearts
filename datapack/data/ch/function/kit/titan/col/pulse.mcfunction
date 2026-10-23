# A Bastion quake: slabs heave in two rings, 3.5 damage and slowness to everything within 6 blocks.
scoreboard players set #ti_big ch.tmp 1
function ch:kit/titan/fx/ring8
function ch:kit/titan/fx/ring12
function ch:api/fx/wave {color:13214812,r:6.5,t:6}
particle minecraft:campfire_cosy_smoke ~ ~0.3 ~ 2 0.1 2 0.02 10
playsound chaoshearts:titan_quake player @a ~ ~ ~ 1.4 1
playsound minecraft:item.mace.smash_ground_heavy player @a ~ ~ ~ 1.2 0.5
function ch:api/fx/shake {s:2,t:8,r:12}
scoreboard players set #ti_d ch.tmp 35
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..6] run function ch:kit/titan/col/pulse_hit
