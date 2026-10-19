# A ground shockwave: an expanding ring of radius r over t ticks plus a dust ring, at the feet.
$data modify storage ch:tmp fxa set value {model:"ring",color:$(color),s0:0.4,t:$(t),spin:120,dy:0.0,roll:0}
$data modify storage ch:tmp fxa.r set value $(r)
execute store result storage ch:tmp fxa.s1 float 0.02 run data get storage ch:tmp fxa.r 100
execute store result score #l ch.tmp run data get storage ch:tmp fxa.t
scoreboard players add #l ch.tmp 4
execute store result storage ch:tmp fxa.life int 1 run scoreboard players get #l ch.tmp
execute positioned ~ ~0.15 ~ rotated 0 0 run function ch:api/fx/sprite_go with storage ch:tmp fxa
data modify storage ch:tmp fxa.model set value "ring_soft"
execute store result storage ch:tmp fxa.s1 float 0.017 run data get storage ch:tmp fxa.r 100
data modify storage ch:tmp fxa.spin set value -90
execute positioned ~ ~0.3 ~ rotated 0 0 run function ch:api/fx/sprite_go with storage ch:tmp fxa
particle minecraft:explosion ~ ~0.3 ~ 0 0 0 0 1
