# The dive's landing circle (radius 3.5).
execute positioned ~ ~0.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:16763210,s0:7.0,s1:0.8,t:22,life:24,spin:150,dy:0.0}
execute positioned ~ ~0.15 ~ run function ch:api/fx/ring {p:"minecraft:dust{color:[1.0,0.79,0.29],scale:1.8}",r:3.5}
playsound chaoshearts:trial_telegraph master @a ~ ~ ~ 1 1
function ch:api/later {t:22,then:"ch:trials/celestial/dive_hit"}
