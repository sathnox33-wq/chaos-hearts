# A star's sigil (radius 2.3), the star appearing above at 20 ticks, the impact at 28.
execute positioned ~ ~0.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:16765803,s0:0.6,s1:4.6,t:26,life:29,spin:150,dy:0.0}
execute positioned ~ ~0.15 ~ run function ch:api/fx/ring {p:"minecraft:dust{color:[1.0,0.827,0.42],scale:1.4}",r:2.3}
playsound chaoshearts:trial_telegraph master @a ~ ~ ~ 0.8 1.4
function ch:api/later {t:20,then:"ch:trials/celestial/sf_star"}
function ch:api/later {t:28,then:"ch:trials/celestial/sf_hit"}
