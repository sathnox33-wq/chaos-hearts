# Ball Lightning: a slow, crackling orb.
function ch:api/proj {item:"minecraft:heart_of_the_sea",scale:1.1,speed:2,life:60,hit:"ch:api/noop",step:"ch:kit/storm/chain/ball_step",end:"ch:kit/storm/chain/ball_end",pierce:1,ignore:"ch.powner"}
data modify entity @e[type=item_display,tag=ch.lnew,limit=1,sort=nearest] item.components."minecraft:item_model" set value "chaoshearts:fx/orb"
data modify entity @e[type=item_display,tag=ch.lnew,limit=1,sort=nearest] item.components."minecraft:custom_model_data" set value {colors:[5220607]}
playsound minecraft:block.conduit.activate player @a ~ ~ ~ 1 1.6
playsound chaoshearts:storm_chain player @a ~ ~ ~ 1 0.6
title @s subtitle {text:"Ball Lightning",color:"#4FA8FF",italic:true}
return 1
