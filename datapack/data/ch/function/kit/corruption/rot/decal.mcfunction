# The ground decals: a spreading sigil of rot, a black crack and a ring that creeps outward.
execute if score @s ch.v2 matches ..55 positioned ~ ~0.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:4004434,s0:0.5,s1:10.0,t:20,life:120,spin:60,dy:0.0}
execute if score @s ch.v2 matches 56.. positioned ~ ~0.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:4004434,s0:0.5,s1:13.0,t:20,life:120,spin:60,dy:0.0}
execute positioned ~ ~0.08 ~ rotated 45 0 run function ch:api/fx/sprite {model:"crack",color:2046478,s0:0.5,s1:7.0,t:16,life:120,spin:0,dy:0.0}
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:8114490,s0:0.2,s1:3.0,t:20,life:120,spin:-170,dy:0.0}
execute positioned ~ ~0.12 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring_soft",color:8114490,s0:0.3,s1:10.0,t:20,life:24,spin:120,dy:0.0}
particle minecraft:sculk_soul ~ ~0.3 ~ 1 0.1 1 0.03 10
