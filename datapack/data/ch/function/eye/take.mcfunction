# The Eye tears a heart away.
$execute as $(player) at @s run function ch:eye/beam_fx
$execute as $(player) at @s run function ch:api/fx/screen {o:"shatter",color:"#B070FF",in:1,stay:15,out:20}
$execute as $(player) at @s run playsound chaoshearts:heart_drop master @a ~ ~ ~ 1.2 0.7
$function ch:admin/take {player:"$(player)",heart:"$(heart)"}
