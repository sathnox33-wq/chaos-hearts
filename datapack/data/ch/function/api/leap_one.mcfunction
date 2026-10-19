execute positioned ^ ^0.3 ^-0.6 summon minecraft:wind_charge run function ch:api/motion
scoreboard players remove #leapn ch.tmp 1
execute if score #leapn ch.tmp matches 1.. run function ch:api/leap_one
