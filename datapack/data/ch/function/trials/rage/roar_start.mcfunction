# Roar windup: he rears and draws breath for 30 ticks while a 7.5-block circle fills under him.
scoreboard players set @s ch.v2 3
scoreboard players set @s ch.v3 30
function ch:trials/rage/freeze
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:14689835,s0:15.0,s1:15.0,t:2,life:32,spin:0,dy:0.0}
execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"disc",color:3801088,s0:1.0,s1:15.0,t:30,life:32,spin:0,dy:0.0}
playsound minecraft:entity.warden.sonic_charge master @a[distance=..90] ~ ~ ~ 2 0.5
playsound chaoshearts:trial_telegraph master @a[distance=..90] ~ ~ ~ 1.2 0.8
function ch:trials/rage/say {m:"Gorrath draws breath... get clear!"}
