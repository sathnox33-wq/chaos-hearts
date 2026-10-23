# The seeking fireball bursts.
particle minecraft:flame ~ ~ ~ 0.4 0.4 0.4 0.08 25
particle minecraft:explosion ~ ~ ~ 0 0 0 0 1
function ch:api/fx/orb {color:16765503,s:2.0,t:3,life:6}
playsound minecraft:item.firecharge.use master @a[distance=..40] ~ ~ ~ 1 1.2
