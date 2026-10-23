# Sanguine Nova windup: the heart swells; a ring marks the blast.
scoreboard players set @s ch.blood.pv 2
effect give @s minecraft:strength 4 0
effect give @s minecraft:slowness 1 1 true
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:16723263,s0:10.0,s1:10.0,t:2,life:11,spin:60,dy:0.0}
execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"disc",color:2818054,s0:1.0,s1:10.0,t:10,life:11,spin:0,dy:0.0}
execute positioned ~ ~1.1 ~ run function ch:api/fx/orb {color:10357535,s:1.6,t:10,life:11}
playsound minecraft:entity.warden.heartbeat player @a ~ ~ ~ 1.6 1.2
playsound minecraft:entity.warden.sonic_charge player @a ~ ~ ~ 1 1.4
function ch:api/later {t:10,then:"ch:kit/blood/pact/nova_l"}
return 1
