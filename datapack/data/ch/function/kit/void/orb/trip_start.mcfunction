# The mine trips: it swells and starts devouring everything within 6 blocks for 14 ticks.
scoreboard players set @s ch.v1 3
scoreboard players set @s ch.life 14
scoreboard players operation @s ch.v2 *= #25 ch.void.k
scoreboard players operation @s ch.v2 /= #10 ch.g
data merge entity @s {start_interpolation:0,interpolation_duration:10,transformation:{scale:[1.8f,1.8f,1.8f]}}
playsound chaoshearts:void_singularity player @a ~ ~ ~ 1 1.8
playsound minecraft:entity.warden.sonic_charge player @a ~ ~ ~ 1 1.2
execute rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:9059583,s0:12.0,s1:0.5,t:14,life:15,spin:170,dy:0.0}
execute rotated ~ 90 run function ch:api/fx/sprite {model:"swirl",color:655380,s0:0.5,s1:5.0,t:14,life:15,spin:-170,dy:0.0}
function ch:api/fx/shake {s:1,t:14,r:8}
