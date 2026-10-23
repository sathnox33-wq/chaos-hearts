# The burst's spectacle: bile sphere, a bruise-purple blast, a rising skull, a crack in the ground, shake and light.
playsound chaoshearts:corruption_burst player @a ~ ~ ~ 1.4 1
playsound minecraft:entity.slime.death player @a ~ ~ ~ 1.2 0.5
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 0.6 1.4
particle minecraft:dust{color:[0.482,0.82,0.227],scale:2.0} ~ ~1 ~ 1.4 1.0 1.4 0 70
particle minecraft:dust{color:[0.239,0.102,0.322],scale:2.2} ~ ~1 ~ 1.0 0.8 1.0 0 40
particle minecraft:item_slime ~ ~1 ~ 0.5 0.5 0.5 0.25 30
particle minecraft:explosion ~ ~1 ~ 0 0 0 0 1
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:13161514,s:5.0,t:3,life:6}
execute positioned ~ ~1 ~ run function ch:api/fx/sprite {model:"star",color:10813263,s0:0.4,s1:4.0,t:2,life:5,spin:140,dy:0.0}
execute positioned ~ ~1.5 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"skull",color:8114490,s0:0.6,s1:2.6,t:10,life:14,spin:0,dy:2.0}
execute positioned ~ ~0.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"crack",color:2046478,s0:0.6,s1:5.0,t:4,life:40,spin:0,dy:0.0}
execute positioned ~ ~0.1 ~ run function ch:api/fx/wave {color:8114490,r:5.0,t:5}
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:5}
function ch:api/fx/shake {s:2,t:6,r:10}
