# As the snared challenger: bound, poisoned - and the queen leaps on them.
function ch:trials/corruption/strike {d:50}
effect give @s minecraft:slowness 3 3
effect give @s minecraft:poison 3 0
title @s subtitle {text:"Bound in silk!",color:"#E0E0E0",bold:true}
execute as @e[tag=ch.corruption.boss,distance=..60,limit=1,sort=nearest] at @s facing entity @a[tag=ch.challenger,limit=1] feet run function ch:trials/corruption/lunge
