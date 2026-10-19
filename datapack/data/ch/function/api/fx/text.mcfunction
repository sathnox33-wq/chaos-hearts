# Floating combat text that pops and rises.
$summon text_display ~ ~1.6 ~ {Tags:["ch.fx","ch.fxwait","ch.noability"],billboard:"center",see_through:true,shadow:true,background:0,brightness:{sky:15,block:15},text:{text:"$(text)",color:"$(color)",bold:true},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.6f,0.6f,0.6f]}}
scoreboard players set @e[type=text_display,tag=ch.fxwait,limit=1,sort=nearest] ch.life 22
scoreboard players operation @e[type=text_display,tag=ch.fxwait,limit=1,sort=nearest] ch.t = #now ch.g
scoreboard players set #fx ch.g 1
