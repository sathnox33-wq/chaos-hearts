# As the bolt every tick: a dripping trail; the mortar's nose bends down a little more each tick.
execute if entity @s[tag=ch.corruption.mortar] run tp @s ~ ~ ~ ~ ~4.5
particle minecraft:dust{color:[0.482,0.82,0.227],scale:1.3} ~ ~ ~ 0.08 0.08 0.08 0 3
particle minecraft:dust{color:[0.239,0.102,0.322],scale:1.0} ~ ~ ~ 0.1 0.1 0.1 0 1
particle minecraft:falling_spore_blossom ~ ~ ~ 0.1 0.1 0.1 0 1
scoreboard players operation #ct ch.tmp = @s ch.life
scoreboard players operation #ct ch.tmp %= #2 ch.g
execute if score #ct ch.tmp matches 0 run particle minecraft:sneeze ~ ~ ~ 0.05 0.05 0.05 0.01 1
execute if score #ct ch.tmp matches 0 rotated ~ ~90 run function ch:api/fx/sprite {model:"swirl",color:10813263,s0:0.9,s1:0.1,t:5,life:6,spin:170,dy:0.0}
execute if score @s ch.v2 matches 1 run particle minecraft:squid_ink ~ ~ ~ 0.1 0.1 0.1 0.01 2
