# The Eye speaks to everyone. Its voice is heard and felt.
$tellraw @a [{text:"◉ ",color:"dark_purple"},{text:"The Eye",color:"dark_purple",bold:true},{text:": ",color:"dark_gray"},{text:"$(msg)",color:"light_purple",italic:true}]
execute as @a at @s run playsound chaoshearts:eye_speak master @s ~ ~ ~ 1 0.8
execute as @a[scores={ch.eye=1..}] at @s run function ch:eye/speak_fx
title @a[scores={ch.eye=0}] times 5 60 20
$title @a[scores={ch.eye=0}] subtitle {text:"$(msg)",color:"light_purple",italic:true}
title @a[scores={ch.eye=0}] title ""
