# At the origin: space folds shut around the caster - a collapsing swirl, a shrinking ring and a black scar.
playsound chaoshearts:void_step player @a ~ ~ ~ 1 0.8
playsound minecraft:entity.enderman.teleport player @a ~ ~ ~ 0.8 0.6
particle minecraft:portal ~ ~1 ~ 0.4 0.8 0.4 1.2 60
particle minecraft:squid_ink ~ ~1 ~ 0.3 0.6 0.3 0.05 15
particle minecraft:dust{color:[0.039,0.0,0.078],scale:2.0} ~ ~1 ~ 0.3 0.7 0.3 0 25
execute positioned ~ ~1 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"swirl",color:1310763,s0:2.4,s1:0.1,t:6,life:8,spin:170,dy:0.0}
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:9059583,s0:3.0,s1:0.2,t:6,life:8,spin:-120,dy:0.0}
execute positioned ~ ~0.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"crack",color:655380,s0:1.0,s1:2.6,t:4,life:30,spin:0,dy:0.0}
execute positioned ~ ~1 ~ run function ch:api/later {t:3,then:"ch:kit/void/fx/scar"}
