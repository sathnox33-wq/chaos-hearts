# Time resumes inside the field: hanging projectiles fall, players see the glass break.
$execute as @e[type=#minecraft:impact_projectiles,tag=ch.speed.pz,distance=..$(r).5] run data modify entity @s NoGravity set value 0b
$tag @e[tag=ch.speed.pz,distance=..$(r).5] remove ch.speed.pz
$execute as @a[distance=..$(r)] run function ch:api/fx/screen {o:"shatter",color:"#C7F4FF",in:0,stay:3,out:12}
tag @e[tag=ch.speed.fz,distance=..32] remove ch.speed.fz
$function ch:api/fx/shake {s:2,t:8,r:$(r)}
