# The Eye turns its full attention on a player: the pupil locks onto them, they glow, and the dark closes in.
tag @a remove ch.gazed
$tag $(player) add ch.gazed
$effect give $(player) minecraft:glowing 6 0 true
$effect give $(player) minecraft:darkness 6 0 true
$execute as $(player) at @s run playsound chaoshearts:eye_gaze master @s ~ ~ ~ 1.2 0.9
$execute as $(player) run function ch:api/fx/screen {o:"eye",color:"#FFFFFF",in:2,stay:40,out:30}
$execute as $(player) at @s run function ch:api/fx/shake {s:2,t:30,r:1}
$title $(player) times 5 50 20
$title $(player) subtitle {text:"It sees you.",color:"dark_purple",italic:true}
$title $(player) title ""
schedule function ch:eye/gaze_end 120t replace
