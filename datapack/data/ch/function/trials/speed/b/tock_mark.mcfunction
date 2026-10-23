# The clock face appears under the challenger.
kill @e[type=marker,tag=ch.speed.tock,distance=..80]
summon minecraft:marker ~ ~ ~ {Tags:["ch.speed.tock","ch.tmob","ch.noability"]}
execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:16113986,s0:0.5,s1:6.6,t:6,life:29,spin:170,dy:0.0}
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:16777215,s0:6.6,s1:0.4,t:28,life:29,spin:-170,dy:0.0}
title @a[tag=ch.challenger] subtitle {text:"Tick... tock...",color:"#F5E142",italic:true}
title @a[tag=ch.challenger] title ""
playsound chaoshearts:trial_telegraph master @a[distance=..40] ~ ~ ~ 1.2 1.2
