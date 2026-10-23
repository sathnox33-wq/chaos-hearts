# Down: the warning - a ring as wide as the pull radius closes in over 30 ticks.
execute positioned ~ ~-0.9 ~ rotated 0 0 if score @s ch.v2 matches ..130 run function ch:api/fx/sprite {model:"ring",color:13864191,s0:24.0,s1:1.0,t:30,life:32,spin:170,dy:0.0}
execute positioned ~ ~-0.9 ~ rotated 0 0 if score @s ch.v2 matches 131.. run function ch:api/fx/sprite {model:"ring",color:13864191,s0:30.0,s1:1.0,t:30,life:32,spin:170,dy:0.0}
execute positioned ~ ~-0.95 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:1310763,s0:20.0,s1:2.0,t:30,life:32,spin:-170,dy:0.0}
playsound minecraft:entity.warden.sonic_charge player @a ~ ~ ~ 2 0.5
