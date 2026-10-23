# Flame Wall cast: you sweep your arm and the ground ignites.
$execute rotated 0 0 run function ch:api/fx/wave {color:$(c),r:3.0,t:5}
$function ch:api/fx/slash {color:$(c),s:3.5,roll:0,t:4}
$particle $(fl) ~ ~0.3 ~ 1.5 0.1 1.5 0.05 40
function ch:api/fx/shake {s:1,t:4,r:8}
function ch:api/fx/light {t:6}
playsound chaoshearts:infernal_flamewall player @a ~ ~ ~ 1.4 1
playsound minecraft:entity.blaze.shoot player @a ~ ~ ~ 1 0.5
playsound minecraft:item.firecharge.use player @a ~ ~ ~ 1 0.6
