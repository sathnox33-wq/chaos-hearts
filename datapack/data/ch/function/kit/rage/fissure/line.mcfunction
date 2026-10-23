# The Earthsplitter warning line along the ground.
scoreboard players remove #ln ch.tmp 1
particle minecraft:dust{color:[0.6,0.05,0.05],scale:1.3} ^ ^ ^1 0.1 0 0.1 0 2
execute if score #ln ch.tmp matches 1.. positioned ^ ^ ^1 run function ch:kit/rage/fissure/line
