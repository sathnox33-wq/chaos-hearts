# A meteor's landing mark and the burning rock falling toward it.
scoreboard players set @s ch.life 30
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:16738847,s0:5.6,s1:5.6,t:2,life:31,spin:90,dy:0.0}
execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"disc",color:14689835,s0:0.5,s1:5.6,t:30,life:31,spin:0,dy:0.0}
execute positioned ~ ~16 ~ rotated 0 0 run function ch:api/fx/sprite {model:"orb",color:16738847,s0:1.6,s1:1.6,t:29,life:30,spin:170,dy:-16.0}
playsound chaoshearts:trial_telegraph master @a[distance=..90] ~ ~ ~ 1 1.4
