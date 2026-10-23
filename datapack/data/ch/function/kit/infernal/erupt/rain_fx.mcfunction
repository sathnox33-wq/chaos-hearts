# Calling the bombs: a beam of fire into the sky.
$function ch:api/fx/pillar {model:"beam",color:$(c),w:0.6,h:24.0,t:4,life:12}
$execute rotated 0 0 positioned ~ ~3 ~ run function ch:api/fx/sprite {model:"rune",color:$(c3),s0:0.5,s1:4.0,t:6,life:14,spin:170,dy:2.0}
$particle $(fl) ~ ~1 ~ 0.3 1 0.3 0.15 30
playsound minecraft:entity.ghast.warn player @a ~ ~ ~ 0.8 0.6
playsound chaoshearts:infernal_rumble player @a ~ ~ ~ 1 0.7
