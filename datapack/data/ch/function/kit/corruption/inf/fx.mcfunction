# The infection's tells: green rot on the host, a turning sigil over its head, a heartbeat that speeds up.
scoreboard players operation #ct ch.tmp = @s ch.t
scoreboard players operation #ct ch.tmp %= #4 ch.g
execute if score #ct ch.tmp matches 0 run particle minecraft:dust{color:[0.643,1.0,0.31],scale:1.0} ~ ~1 ~ 0.3 0.5 0.3 0 4
execute if score #ct ch.tmp matches 2 run particle minecraft:sneeze ~ ~1.2 ~ 0.2 0.3 0.2 0.01 1
scoreboard players operation #ct ch.tmp = @s ch.t
scoreboard players operation #ct ch.tmp %= #20 ch.g
execute if score #ct ch.tmp matches 1 positioned ~ ~2.6 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:8114490,s0:1.2,s1:0.8,t:18,life:20,spin:170,dy:0.0}
execute if score #ct ch.tmp matches 1 positioned ~ ~1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring_soft",color:4004434,s0:0.4,s1:2.6,t:10,life:12,spin:90,dy:0.0}
execute if score @s ch.v1 matches 21.. if score #ct ch.tmp matches 1 run playsound minecraft:block.note_block.basedrum player @a ~ ~ ~ 0.7 0.6
execute if score @s ch.v1 matches 1..20 run scoreboard players operation #ct ch.tmp = @s ch.v1
execute if score @s ch.v1 matches 1..20 run scoreboard players operation #ct ch.tmp %= #4 ch.g
execute if score @s ch.v1 matches 1..20 if score #ct ch.tmp matches 0 run playsound minecraft:block.note_block.basedrum player @a ~ ~ ~ 1 1.4
execute if score @s ch.v1 matches 1..20 if score #ct ch.tmp matches 0 run particle minecraft:item_slime ~ ~1 ~ 0.3 0.5 0.3 0.05 6
execute if score @s ch.v1 matches 10 positioned ~ ~1 ~ run function ch:api/fx/orb {color:10813263,s:1.4,t:10,life:11}
