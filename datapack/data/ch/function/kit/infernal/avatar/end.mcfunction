# The Avatar burns out.
$particle $(fl) ~ ~1 ~ 0.5 0.8 0.5 0.1 40
particle minecraft:large_smoke ~ ~1 ~ 0.4 0.8 0.4 0.03 20
$execute rotated 0 0 run function ch:api/fx/sprite {model:"ring_soft",color:$(c2),s0:1.0,s1:5.0,t:8,life:12,spin:120,dy:0.0}
playsound minecraft:block.fire.extinguish player @a ~ ~ ~ 1 0.6
tag @s remove ch.caster
