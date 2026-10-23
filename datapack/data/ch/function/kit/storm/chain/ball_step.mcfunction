# Ball Lightning, every tick: sparks and a halo; every 5 ticks it lashes up to 3 enemies within 4.5 blocks.
particle minecraft:electric_spark ~ ~ ~ 0.4 0.4 0.4 0.15 6
particle minecraft:dust{color:[0.91,0.96,1.0],scale:1.0} ~ ~ ~ 0.3 0.3 0.3 0 3
scoreboard players operation #k ch.storm.g = @s ch.life
scoreboard players operation #k ch.storm.g %= #c5 ch.storm.g
execute if score #k ch.storm.g matches 0 rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:15267583,s0:0.5,s1:2.6,t:3,life:5,spin:170,dy:0.0}
execute if score #k ch.storm.g matches 0 run function ch:kit/storm/chain/ball_lash
