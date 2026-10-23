# Searing hit flash.
$particle $(fl) ~ ~1 ~ 0.3 0.5 0.3 0.04 12
$function ch:api/fx/sprite {model:"flame",color:$(c),s0:0.5,s1:1.6,t:3,life:7,spin:150,dy:0.3}
playsound minecraft:item.firecharge.use player @a ~ ~ ~ 0.4 1.6
