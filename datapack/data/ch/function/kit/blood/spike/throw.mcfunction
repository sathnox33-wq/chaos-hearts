# One Blood Spike projectile straight along the look.
function ch:api/proj {item:"minecraft:pointed_dripstone",scale:0.9,speed:7,life:30,hit:"ch:kit/blood/spike/hit",step:"ch:kit/blood/spike/step",end:"ch:kit/blood/spike/end",pierce:0,ignore:"ch.powner"}
execute as @e[type=item_display,tag=ch.lnew,tag=ch.proj,tag=!ch.blood.sp,limit=1] run function ch:kit/blood/spike/style
