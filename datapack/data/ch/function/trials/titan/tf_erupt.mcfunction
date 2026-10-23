# The fault erupts here: a big slab, rock spray, and 9 damage with a launch to the challenger within 2 blocks.
scoreboard players set #ti_big ch.tmp 1
function ch:kit/titan/fx/slab_here
particle minecraft:explosion ~ ~0.4 ~ 0.3 0.1 0.3 0 1
particle minecraft:lava ~ ~0.3 ~ 0.3 0.1 0.3 0 2
playsound minecraft:item.mace.smash_ground master @a ~ ~ ~ 1.2 0.6
function ch:api/fx/shake {s:2,t:4,r:6}
scoreboard players operation #ti_cid ch.tmp = @s ch.v3
execute positioned ~ ~0.8 ~ as @a[tag=ch.challenger,distance=..2.2] unless score @s ch.titan.hid = #ti_cid ch.tmp run function ch:trials/titan/tf_hurt
