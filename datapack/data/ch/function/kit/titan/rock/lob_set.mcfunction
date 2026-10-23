# As the Titan, at a spot: a warning ring grows on the ground, the boulder falls in 24 ticks.
execute positioned ~ ~0.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:16742954,s0:0.6,s1:9.0,t:22,life:26,spin:120,dy:0.0}
execute positioned ~ ~0.05 ~ rotated 0 0 run function ch:api/fx/sprite {model:"crack",color:3880238,s0:0.3,s1:4.0,t:22,life:30,spin:0,dy:0.0}
execute positioned ~ ~0.15 ~ run function ch:api/fx/ring {p:"minecraft:dust{color:[1.0,0.478,0.165],scale:1.6}",r:4.5}
playsound chaoshearts:trial_telegraph player @a ~ ~ ~ 1 0.8
playsound minecraft:block.respawn_anchor.charge player @a ~ ~ ~ 0.8 0.5
data modify storage ch:tmp tg.b set from storage ch:tmp trk.b
function ch:kit/titan/fx/later {t:12,then:"ch:kit/titan/rock/meteor_fall"}
data modify entity @e[type=marker,tag=ch.titan.lset,distance=..0.01,limit=1,sort=nearest] data.b set from storage ch:tmp trk.b
function ch:kit/titan/fx/later {t:24,then:"ch:kit/titan/rock/meteor"}
data modify entity @e[type=marker,tag=ch.titan.lset,distance=..0.01,limit=1,sort=nearest] data.b set from storage ch:tmp trk.b
