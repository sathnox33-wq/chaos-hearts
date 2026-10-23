# Hellgates: three burning rifts open in the floor around the arena and stay for 15 s.
function ch:trials/infernal/callout {t:"Hellgates open in the floor!"}
execute at @e[type=marker,tag=ch.session,distance=..90,limit=1,sort=nearest] run function ch:trials/infernal/gates_at
playsound chaoshearts:infernal_rumble master @a[distance=..90] ~ ~ ~ 2 0.6
