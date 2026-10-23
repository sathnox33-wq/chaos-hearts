# Supernova windup: light collapses inward on the Celestial for 12 ticks (get away!).
execute positioned ~ ~1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"orb",color:16777215,s0:9.0,s1:0.5,t:12,life:13,spin:170,dy:0.0}
execute positioned ~ ~1 ~ rotated 0 90 run function ch:api/fx/sprite {model:"ring",color:16765803,s0:12.0,s1:0.5,t:12,life:13,spin:170,dy:0.0}
particle minecraft:reverse_portal ~ ~1 ~ 3 3 3 0.2 80
particle minecraft:end_rod ~ ~1 ~ 4 4 4 0.04 60
playsound chaoshearts:celestial_supernova player @a ~ ~ ~ 2 0.9
playsound minecraft:block.beacon.power_select player @a ~ ~ ~ 2 0.5
playsound chaoshearts:trial_telegraph player @a ~ ~ ~ 1.2 1
function ch:kit/celestial/fx/later {t:12,then:"ch:kit/celestial/asc/supernova"}
