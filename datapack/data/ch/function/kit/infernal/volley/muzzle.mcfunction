# Muzzle flash of a thrown fireball.
$execute anchored eyes positioned ^ ^-0.2 ^1 run particle $(fl) ~ ~ ~ 0.1 0.1 0.1 0.06 8
$execute anchored eyes positioned ^ ^-0.2 ^1 rotated ~ 90 run function ch:api/fx/sprite {model:"ring",color:$(c3),s0:0.3,s1:1.4,t:2,life:5,spin:120,dy:0.0}
playsound minecraft:entity.ghast.shoot player @a ~ ~ ~ 0.4 1.6
playsound minecraft:item.firecharge.use player @a ~ ~ ~ 0.5 1.3
