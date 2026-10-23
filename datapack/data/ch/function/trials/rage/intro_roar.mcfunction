# Something enormous roars beneath the pit.
function ch:api/fx/wave {color:3801088,r:25.0,t:24}
function ch:api/fx/shake {s:2,t:20,r:60}
particle minecraft:campfire_cosy_smoke ~ ~0.3 ~ 6 0.1 6 0.02 60
playsound minecraft:entity.ravager.roar master @a[distance=..90] ~ ~ ~ 3 0.4
playsound minecraft:entity.warden.heartbeat master @a[distance=..90] ~ ~ ~ 2 0.5
