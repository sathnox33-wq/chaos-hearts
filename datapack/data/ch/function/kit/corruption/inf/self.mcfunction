# Up: infest yourself. You swell with plague: Resistance and Speed until the burst.
scoreboard players set #cfs ch.tmp 1
scoreboard players set #cfuse ch.tmp 50
scoreboard players operation #crad ch.tmp *= #2 ch.g
effect give @s minecraft:resistance 3 0 true
effect give @s minecraft:speed 3 1 true
playsound chaoshearts:corruption_infest player @a ~ ~ ~ 1 0.7
playsound minecraft:entity.zombie.infect player @a ~ ~ ~ 1 0.6
function ch:api/fx/screen {o:"corruption",color:"#7BD13A",in:2,stay:20,out:20}
title @s subtitle {text:"You are the carrier",color:"#A4FF4F",bold:true}
function ch:kit/corruption/inf/plant
return 1
