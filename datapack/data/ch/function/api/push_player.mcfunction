# Rotation points from the origin to the player and the position is the player's: a wind charge flies into their
# back and bursts, throwing them away from the origin.
execute in ch:trials positioned 0.0 0.0 0.0 run tp @e[type=marker,tag=ch.vec,limit=1] ^ ^ ^0.8
execute positioned ^ ^0.4 ^-0.9 run summon minecraft:wind_charge ~ ~ ~ {Tags:["ch.wind"]}
execute store result entity @e[type=wind_charge,tag=ch.wind,limit=1] Motion[0] double 0.001 run data get entity @e[type=marker,tag=ch.vec,limit=1] Pos[0] 1000
execute store result entity @e[type=wind_charge,tag=ch.wind,limit=1] Motion[2] double 0.001 run data get entity @e[type=marker,tag=ch.vec,limit=1] Pos[2] 1000
data modify entity @e[type=wind_charge,tag=ch.wind,limit=1] Motion[1] set value 0.1d
tag @e[type=wind_charge,tag=ch.wind] remove ch.wind
execute in ch:trials run tp @e[type=marker,tag=ch.vec,limit=1] 0.5 64 0.5
return 1
