# Gored by the charge.
tag @s add ch.rage.hitc
function ch:api/hit {d:110}
function ch:api/push {s:1.0,y:0.6}
function ch:api/fx/screen {o:"shatter",color:"#E0262B",in:0,stay:4,out:12}
function ch:api/fx/shake {s:3,t:10,r:3}
playsound minecraft:entity.ravager.attack master @a[distance=..90] ~ ~ ~ 2 0.8
