# As an enemy on the erupting mire.
execute store result score #cey ch.tmp run data get entity @s Pos[1] 10
scoreboard players operation #cey ch.tmp -= #cry ch.tmp
execute unless score #cey ch.tmp matches -10..25 run return 0
function ch:api/stun {t:30}
function ch:kit/corruption/hurt
execute if entity @s[type=player] run function ch:api/fx/screen {o:"corruption",color:"#3D1A52",in:0,stay:8,out:14}
particle minecraft:block{block_state:"minecraft:rooted_dirt"} ~ ~0.5 ~ 0.3 0.5 0.3 0 20
