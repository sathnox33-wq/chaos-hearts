# Rammed.
tag @s add ch.frozen.rh
execute store result score #f_ok ch.tmp run function ch:kit/frozen/hurt
execute if score #f_ok ch.tmp matches 0 run return 0
function ch:api/cc {effect:"minecraft:slowness",sec:3,amp:2}
particle minecraft:block{block_state:"minecraft:packed_ice"} ~ ~1 ~ 0.3 0.5 0.3 0.15 20
playsound minecraft:block.glass.break player @a ~ ~ ~ 1 0.6
function ch:api/fx/shake {s:2,t:5,r:4}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"frozen",color:"#9BE7FF",in:1,stay:6,out:12}
