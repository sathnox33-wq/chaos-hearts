# A vertical rift at a swap point: rune, swirl and imploding portal light.
execute positioned ~ ~1 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"rune",color:9059583,s0:2.6,s1:0.4,t:6,life:9,spin:170,dy:0.0}
execute positioned ~ ~1 ~ rotated ~90 90 run function ch:api/fx/sprite {model:"swirl",color:655380,s0:0.3,s1:2.6,t:4,life:8,spin:-170,dy:0.0}
execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:13864191,s0:0.4,s1:4.0,t:5,life:8,spin:150,dy:0.0}
particle minecraft:portal ~ ~1 ~ 0.4 0.8 0.4 1 50
particle minecraft:reverse_portal ~ ~1 ~ 0.2 0.6 0.2 0.1 30
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:4}
