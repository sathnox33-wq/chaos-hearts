# Summons the floating heart and its label where the player is.
summon item_display ~ ~1.2 ~ {Tags:["ch.token","ch.new"],billboard:"fixed",Glowing:1b,view_range:1.5f,teleport_duration:3,brightness:{sky:15,block:15},item:{id:"minecraft:heart_of_the_sea",count:1},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.9f,0.9f,0.9f]}}
$data modify entity @e[type=item_display,tag=ch.new,limit=1] item.components."minecraft:item_model" set value "chaoshearts:heart_$(h)"
data modify entity @e[type=item_display,tag=ch.new,limit=1] glow_color_override set from storage ch:tmp h.rgb
$scoreboard players set @e[type=item_display,tag=ch.new,limit=1] ch.hid $(id)
$scoreboard players set @e[type=item_display,tag=ch.new,limit=1] ch.owner $(col)
$scoreboard players set @e[type=item_display,tag=ch.new,limit=1] ch.t $(exp)
$scoreboard players set @e[type=item_display,tag=ch.new,limit=1] ch.slot $(i)
$summon text_display ~ ~2.0 ~ {Tags:["ch.tokenlabel","ch.newl"],billboard:"center",view_range:0.6f,background:0,text:[{text:"❤ ",color:"$(color)"},{text:"$(title) Heart",color:"$(color)",bold:true}]}
$scoreboard players set @e[type=text_display,tag=ch.newl,limit=1] ch.hid $(id)
tag @e[tag=ch.new] remove ch.new
tag @e[tag=ch.newl] remove ch.newl
particle minecraft:explosion ~ ~1 ~ 0 0 0 0 1
playsound chaoshearts:heart_drop player @a ~ ~ ~ 1.5 1
playsound minecraft:entity.warden.heartbeat player @a ~ ~ ~ 1.5 0.8
