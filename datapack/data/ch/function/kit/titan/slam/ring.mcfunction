# Epicenter ring #ti_x (1 at 2 blocks, 2 at 4, 3 at 6): slabs, shockwave, and a hit that weakens outward.
execute if score #ti_x ch.tmp matches 1 run function ch:kit/titan/fx/ring8
execute if score #ti_x ch.tmp matches 2 run function ch:kit/titan/fx/ring12
execute if score #ti_x ch.tmp matches 3 run function ch:kit/titan/fx/ring16
execute if score #ti_x ch.tmp matches 1 run function ch:api/fx/wave {color:13214812,r:2.6,t:3}
execute if score #ti_x ch.tmp matches 2 run function ch:api/fx/wave {color:8025194,r:4.6,t:4}
execute if score #ti_x ch.tmp matches 3 run function ch:api/fx/wave {color:3880238,r:6.6,t:5}
execute if score #ti_x ch.tmp matches 1 run playsound minecraft:item.mace.smash_ground player @a ~ ~ ~ 1.2 0.7
execute if score #ti_x ch.tmp matches 2 run playsound minecraft:item.mace.smash_ground player @a ~ ~ ~ 1.2 0.6
execute if score #ti_x ch.tmp matches 3 run playsound minecraft:item.mace.smash_ground_heavy player @a ~ ~ ~ 1.2 0.5
function ch:api/fx/shake {s:2,t:5,r:9}
execute if score #ti_x ch.tmp matches 2 run scoreboard players operation #ti_d ch.tmp *= #3 ch.titan.k
execute if score #ti_x ch.tmp matches 2 run scoreboard players operation #ti_d ch.tmp /= #4 ch.g
execute if score #ti_x ch.tmp matches 3 run scoreboard players operation #ti_d ch.tmp /= #2 ch.g
execute if score #ti_x ch.tmp matches 1 positioned ~ ~0.8 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..2.8] unless score @s ch.titan.hid = #ti_cid ch.tmp run function ch:kit/titan/slam/hurt_ring
execute if score #ti_x ch.tmp matches 2 positioned ~ ~0.8 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..4.8] unless score @s ch.titan.hid = #ti_cid ch.tmp run function ch:kit/titan/slam/hurt_ring
execute if score #ti_x ch.tmp matches 3 positioned ~ ~0.8 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..6.8] unless score @s ch.titan.hid = #ti_cid ch.tmp run function ch:kit/titan/slam/hurt_ring
