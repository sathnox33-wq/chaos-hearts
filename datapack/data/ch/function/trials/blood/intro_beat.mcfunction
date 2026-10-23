# The altar heart beats.
function ch:api/fx/wave {color:16723263,r:6.0,t:8}
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:16723263,s:3.0,t:3,life:8}
playsound minecraft:entity.warden.heartbeat master @a[distance=..90] ~ ~ ~ 2.5 0.6
function ch:api/fx/shake {s:1,t:6,r:60}
