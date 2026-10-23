# The fault erupts here: a slab heaves up, embers and dust spray, the ground cracks and enemies on it are launched.
scoreboard players operation #ti_big ch.tmp = @s ch.v3
function ch:kit/titan/fx/slab_here
execute positioned ~ ~0.04 ~ rotated ~ 0 run function ch:api/fx/sprite {model:"crack",color:16742954,s0:0.3,s1:1.8,t:3,life:36,spin:20,dy:0.0}
particle minecraft:dust_color_transition{from_color:[1.0,0.478,0.165],to_color:[0.231,0.208,0.18],scale:2.0} ~ ~0.3 ~ 0.45 0.2 0.45 0 10
particle minecraft:lava ~ ~0.2 ~ 0.3 0.1 0.3 0 2
particle minecraft:campfire_cosy_smoke ~ ~0.3 ~ 0.4 0.1 0.4 0.01 2
scoreboard players operation #ti_m ch.tmp = @s ch.v4
scoreboard players operation #ti_m ch.tmp %= #2 ch.g
execute if score #ti_m ch.tmp matches 0 run particle minecraft:explosion ~ ~0.4 ~ 0.2 0.1 0.2 0 1
execute if score #ti_m ch.tmp matches 0 run function ch:api/fx/shake {s:1,t:4,r:5}
execute if score #ti_m ch.tmp matches 1 run playsound minecraft:item.mace.smash_ground player @a ~ ~ ~ 0.9 0.6
execute if score #ti_m ch.tmp matches 1 positioned ~ ~0.6 ~ run function ch:api/fx/light {t:6}
execute if score @s ch.v5 matches 1 rotated ~ -12 run function ch:api/fx/pillar {model:"spike",color:16742954,w:0.5,h:1.6,t:3,life:12}
scoreboard players operation #ti_cid ch.tmp = @s ch.v2
scoreboard players operation #ti_d ch.tmp = @s ch.v1
scoreboard players operation #ti_cat ch.tmp = @s ch.v5
execute positioned ~ ~0.8 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..1.8] unless score @s ch.titan.hid = #ti_cid ch.tmp run function ch:kit/titan/slam/hurt
