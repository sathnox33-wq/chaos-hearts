# The world darkens as the Eye opens.
playsound chaoshearts:eye_open master @a ~ ~ ~ 3 0.8
effect give @a[distance=0.1..48] minecraft:darkness 6 0 true
execute as @a[distance=0.1..48] run function ch:api/fx/screen {o:"eye",color:"#FFFFFF",in:10,stay:30,out:30}
function ch:api/fx/shake {s:3,t:30,r:40}
particle minecraft:squid_ink ~ ~2 ~ 2 2 2 0.2 300 force
particle minecraft:sculk_soul ~ ~2 ~ 3 3 3 0.05 80 force
function ch:api/fx/wave {color:2752553,r:20.0,t:20}
title @a[distance=0.1..48] times 10 50 20
title @a[distance=0.1..48] subtitle {text:"Something vast has opened its eye.",color:"dark_purple",italic:true}
title @a[distance=0.1..48] title ""
