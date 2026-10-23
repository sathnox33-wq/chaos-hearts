# Bastion: a quake pulse every 1.5 s, warned 8 ticks ahead by a rumble and a dust ring at its reach.
scoreboard players operation #ti_m ch.tmp = @s ch.titan.col
scoreboard players operation #ti_m ch.tmp %= #30 ch.titan.k
execute if score #ti_m ch.tmp matches 8 run playsound minecraft:block.respawn_anchor.charge player @a ~ ~ ~ 1 0.5
execute if score #ti_m ch.tmp matches 8 positioned ~ ~0.15 ~ run function ch:api/fx/ring {p:"minecraft:dust{color:[1.0,0.478,0.165],scale:1.8}",r:6}
execute if score #ti_m ch.tmp matches 4 positioned ~ ~0.15 ~ run function ch:api/fx/ring {p:"minecraft:dust{color:[1.0,0.478,0.165],scale:1.8}",r:6}
execute if score #ti_m ch.tmp matches 0 run function ch:kit/titan/col/pulse
