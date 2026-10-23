# Spawns wave $(n) of the Titan trial.
$function ch:trials/titan/wave$(n)
playsound chaoshearts:titan_quake master @a[tag=ch.challenger] ~ ~ ~ 1 1
function ch:api/fx/wave {color:13214812,r:18,t:16}
