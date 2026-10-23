# The Eye of the Storm opens: the rods drink lightning one after another.
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"swirl",color:5220607,s0:2.0,s1:56.0,t:40,life:80,spin:170,dy:0.0}
execute positioned ~ ~18 ~ rotated 0 0 run function ch:api/fx/sprite {model:"cloud",color:7241632,s0:4.0,s1:40.0,t:40,life:120,spin:120,dy:0.0}
execute positioned ~ ~0.2 ~ run function ch:kit/storm/fn/bolt
execute positioned ~28 ~4 ~ run summon minecraft:lightning_bolt
execute positioned ~-28 ~4 ~ run summon minecraft:lightning_bolt
particle minecraft:electric_spark ~ ~4 ~ 10 3 10 0.2 200
playsound chaoshearts:storm_thunder master @a[distance=..80] ~ ~ ~ 2 0.8
