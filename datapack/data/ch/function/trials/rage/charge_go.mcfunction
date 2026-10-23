# The charge begins.
scoreboard players set @s ch.v2 2
scoreboard players set @s ch.v3 16
tag @a remove ch.rage.hitc
playsound minecraft:entity.ravager.roar master @a[distance=..90] ~ ~ ~ 2 1.2
playsound minecraft:entity.wind_charge.wind_burst master @a[distance=..90] ~ ~ ~ 1.5 0.5
function ch:api/fx/wave {color:14689835,r:3.0,t:4}
