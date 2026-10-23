# Struck by the icicles.
execute store result score #f_ok ch.tmp run function ch:kit/frozen/hurt
execute if score #f_ok ch.tmp matches 0 run return 0
function ch:api/cc {effect:"minecraft:slowness",sec:3,amp:2}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"frozen",color:"#9BE7FF",in:1,stay:8,out:14}
