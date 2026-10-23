# Spawns wave $(n) of the Celestial trial.
$function ch:trials/celestial/wave$(n)
playsound chaoshearts:celestial_chime master @a[tag=ch.challenger] ~ ~ ~ 1.2 1.2
function ch:api/fx/wave {color:16773808,r:18,t:16}
