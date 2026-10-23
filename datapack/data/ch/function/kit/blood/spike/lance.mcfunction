# Hemorrhage Lance: at 100 Vitae, Blood Spike becomes a huge piercing lance (10 damage, 6 s bleed) and Vitae empties.
scoreboard players set @s ch.blood.vit 0
scoreboard players set @s ch.meter 0
function ch:api/proj {item:"minecraft:pointed_dripstone",scale:1.4,speed:9,life:30,hit:"ch:kit/blood/spike/hit",step:"ch:kit/blood/spike/step",end:"ch:kit/blood/spike/end",pierce:1,ignore:"ch.powner"}
execute as @e[type=item_display,tag=ch.lnew,tag=ch.proj,tag=!ch.blood.sp,limit=1] run function ch:kit/blood/spike/style
execute as @e[type=item_display,tag=ch.lnew,tag=ch.proj,tag=ch.blood.sp,tag=!ch.blood.lance,limit=1] run function ch:kit/blood/spike/lance_style
execute anchored eyes positioned ^ ^ ^1 rotated ~ 90 run function ch:api/fx/sprite {model:"ring",color:16723263,s0:0.4,s1:2.5,t:3,life:6,spin:0,dy:2.0}
function ch:api/fx/screen {o:"blood",color:"#FF2D3F",in:0,stay:3,out:10}
function ch:api/fx/shake {s:1,t:4,r:4}
playsound chaoshearts:blood_spike player @a ~ ~ ~ 1.4 0.7
playsound minecraft:item.trident.riptide_3 player @a ~ ~ ~ 1 0.8
return 1
