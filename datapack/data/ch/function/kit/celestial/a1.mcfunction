# Starfall. Level: a star falls on what you aim at (12-tick fall: it can be dodged). Up: Starstorm, six stars
# rain around the closest enemy. Down: Nova Star, a star crashes onto you and blasts enemies away.
scoreboard players operation #ce_pid ch.tmp = @s ch.pid
function ch:kit/celestial/exalt
scoreboard players set #ce_d ch.tmp 70
execute if score @s ch.b1 matches 1.. run scoreboard players set #ce_d ch.tmp 87
scoreboard players set #ce_r ch.tmp 25
scoreboard players set #ce_sm ch.tmp 0
scoreboard players set #ce_co ch.tmp 0
scoreboard players set #ce_as ch.tmp 0
scoreboard players set #ce_nv ch.tmp 0
execute if score @s ch.b1 matches 5.. run scoreboard players set #ce_co ch.tmp 1
execute if score @s ch.b1 matches 5.. run scoreboard players set #ce_r ch.tmp 50
execute if score #ce_ex ch.tmp matches 1 run scoreboard players operation #ce_d ch.tmp *= #3 ch.celestial.k
execute if score #ce_ex ch.tmp matches 1 run scoreboard players operation #ce_d ch.tmp /= #2 ch.g
execute if score #ce_ex ch.tmp matches 1 run scoreboard players add #ce_r ch.tmp 15
execute if score @s ch.b1 matches 4.. run function ch:api/cooldown {slot:1,t:135}
particle minecraft:end_rod ~ ~2.3 ~ 0.2 0.1 0.2 0.08 12
execute anchored eyes positioned ^ ^ ^0.6 run function ch:api/fx/orb {color:16773808,s:0.8,t:3,life:6}
playsound minecraft:block.beacon.power_select player @a ~ ~ ~ 1 1.8
execute if score #var ch.tmp matches 1 run return run function ch:kit/celestial/star/storm
execute if score #var ch.tmp matches 2 run return run function ch:kit/celestial/star/nova
function ch:api/ray {range:32}
execute if score #rayhit ch.tmp matches 1 at @e[tag=ch.target,limit=1] run function ch:kit/celestial/star/call
execute if score #rayhit ch.tmp matches 0 at @e[type=marker,tag=ch.rayend,limit=1] run function ch:kit/celestial/star/drop
tag @e[tag=ch.target] remove ch.target
execute if score @s ch.b1 matches 2.. run function ch:kit/celestial/star/shower
return 1
