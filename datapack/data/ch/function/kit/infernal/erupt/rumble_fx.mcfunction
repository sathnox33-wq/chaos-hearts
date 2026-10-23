# One rumble.
$function ch:api/fx/ring {p:"minecraft:dust{color:$(dc),scale:1.6}",r:$(r)}
$particle minecraft:dust{color:$(dc2),scale:1.2} ~ ~0.15 ~ $(rh) 0.05 $(rh) 0 14
$particle $(fl) ~ ~0.2 ~ $(rh) 0 $(rh) 0.02 6
particle minecraft:smoke ~ ~0.3 ~ 1 0.1 1 0.02 6
particle minecraft:dripping_lava ~ ~0.6 ~ 1 0.1 1 0 4
$execute rotated 0 0 positioned ~ ~0.1 ~ run function ch:api/fx/sprite {model:"ring_soft",color:$(c),s0:0.4,s1:$(dia),t:4,life:5,spin:60,dy:0.0}
function ch:api/fx/shake {s:1,t:3,r:7}
playsound minecraft:block.basalt.break block @a ~ ~ ~ 1 0.5
