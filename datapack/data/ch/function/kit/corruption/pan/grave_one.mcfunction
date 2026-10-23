# As an enemy over the grave (while rotlings remain): eruption, damage, root, and a Rotling claws up beside it.
execute if score #ci ch.tmp >= #cln ch.tmp run return 0
function ch:kit/corruption/hurt
function ch:api/stun {t:20}
function ch:kit/corruption/poison {sec:3,amp:0}
particle minecraft:block{block_state:"minecraft:rooted_dirt"} ~ ~0.3 ~ 0.6 0.3 0.6 0 40
execute rotated 0 0 run function ch:api/fx/sprite3 {model:"spike",color:2046478,a:"[0.6,0.1,0.6]",b:"[0.9,3.0,0.9]",t:3,life:20,spin:60}
execute positioned ~ ~0.1 ~ run function ch:api/fx/wave {color:4004434,r:2.5,t:4}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"corruption",color:"#3D1A52",in:0,stay:6,out:12}
scoreboard players add #ci ch.tmp 1
execute positioned ~0.8 ~ ~0.8 run function ch:kit/corruption/ling/raise
