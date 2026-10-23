# The charge lane in dust.
scoreboard players remove #ln ch.tmp 1
particle minecraft:dust{color:[0.88,0.15,0.17],scale:1.6} ^1.2 ^ ^ 0.05 0 0.05 0 1
particle minecraft:dust{color:[0.88,0.15,0.17],scale:1.6} ^-1.2 ^ ^ 0.05 0 0.05 0 1
particle minecraft:dust{color:[1.0,0.42,0.12],scale:1.0} ^ ^ ^ 0.3 0 0.3 0 1
execute if score #ln ch.tmp matches 1.. positioned ^ ^ ^1 run function ch:trials/rage/lane
