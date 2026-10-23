# Rampage helix of blood and shadow: two strands climbing around the body, one step per call (every 2 ticks).
scoreboard players operation #h ch.tmp = #now ch.g
scoreboard players operation #h ch.tmp /= #2 ch.g
scoreboard players operation #h ch.tmp %= #8 ch.g
execute if score #h ch.tmp matches 0 rotated 0 0 run particle minecraft:dust{color:[0.88,0.15,0.17],scale:1.3} ^ ^0.20 ^0.75 0 0 0 0 1
execute if score #h ch.tmp matches 0 rotated 0 0 run particle minecraft:dust{color:[0.23,0.0,0.0],scale:1.6} ^ ^0.20 ^-0.75 0 0 0 0 1
execute if score #h ch.tmp matches 1 rotated 45 0 run particle minecraft:dust{color:[0.88,0.15,0.17],scale:1.3} ^ ^0.45 ^0.75 0 0 0 0 1
execute if score #h ch.tmp matches 1 rotated 45 0 run particle minecraft:dust{color:[0.23,0.0,0.0],scale:1.6} ^ ^0.45 ^-0.75 0 0 0 0 1
execute if score #h ch.tmp matches 2 rotated 90 0 run particle minecraft:dust{color:[0.88,0.15,0.17],scale:1.3} ^ ^0.70 ^0.75 0 0 0 0 1
execute if score #h ch.tmp matches 2 rotated 90 0 run particle minecraft:dust{color:[0.23,0.0,0.0],scale:1.6} ^ ^0.70 ^-0.75 0 0 0 0 1
execute if score #h ch.tmp matches 3 rotated 135 0 run particle minecraft:dust{color:[0.88,0.15,0.17],scale:1.3} ^ ^0.95 ^0.75 0 0 0 0 1
execute if score #h ch.tmp matches 3 rotated 135 0 run particle minecraft:dust{color:[0.23,0.0,0.0],scale:1.6} ^ ^0.95 ^-0.75 0 0 0 0 1
execute if score #h ch.tmp matches 4 rotated 180 0 run particle minecraft:dust{color:[0.88,0.15,0.17],scale:1.3} ^ ^1.20 ^0.75 0 0 0 0 1
execute if score #h ch.tmp matches 4 rotated 180 0 run particle minecraft:dust{color:[0.23,0.0,0.0],scale:1.6} ^ ^1.20 ^-0.75 0 0 0 0 1
execute if score #h ch.tmp matches 5 rotated 225 0 run particle minecraft:dust{color:[0.88,0.15,0.17],scale:1.3} ^ ^1.45 ^0.75 0 0 0 0 1
execute if score #h ch.tmp matches 5 rotated 225 0 run particle minecraft:dust{color:[0.23,0.0,0.0],scale:1.6} ^ ^1.45 ^-0.75 0 0 0 0 1
execute if score #h ch.tmp matches 6 rotated 270 0 run particle minecraft:dust{color:[0.88,0.15,0.17],scale:1.3} ^ ^1.70 ^0.75 0 0 0 0 1
execute if score #h ch.tmp matches 6 rotated 270 0 run particle minecraft:dust{color:[0.23,0.0,0.0],scale:1.6} ^ ^1.70 ^-0.75 0 0 0 0 1
execute if score #h ch.tmp matches 7 rotated 315 0 run particle minecraft:dust{color:[0.88,0.15,0.17],scale:1.3} ^ ^1.95 ^0.75 0 0 0 0 1
execute if score #h ch.tmp matches 7 rotated 315 0 run particle minecraft:dust{color:[0.23,0.0,0.0],scale:1.6} ^ ^1.95 ^-0.75 0 0 0 0 1
