# Volley wind-up: a burning sigil at the hands.
$execute anchored eyes positioned ^ ^-0.3 ^0.9 rotated ~ 90 run function ch:api/fx/sprite {model:"rune",color:$(c),s0:0.2,s1:1.6,t:3,life:8,spin:170,dy:0.0}
$execute anchored eyes positioned ^ ^-0.3 ^0.9 run particle $(fl) ~ ~ ~ 0.2 0.2 0.2 0.05 14
playsound chaoshearts:infernal_volley player @a ~ ~ ~ 1 1
playsound minecraft:entity.blaze.shoot player @a ~ ~ ~ 0.8 0.8
