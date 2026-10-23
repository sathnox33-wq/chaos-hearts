# At the destination: the caster tears back out of nothing - ring burst, swirl, star flash, light, shake.
playsound chaoshearts:void_step player @a ~ ~ ~ 1 1.2
playsound minecraft:entity.enderman.teleport player @a ~ ~ ~ 0.8 0.9
playsound minecraft:block.respawn_anchor.deplete player @a ~ ~ ~ 0.5 1.6
particle minecraft:reverse_portal ~ ~1 ~ 0.3 0.7 0.3 0.15 70
particle minecraft:end_rod ~ ~1 ~ 0.2 0.5 0.2 0.12 10
particle minecraft:dust{color:[0.827,0.549,1.0],scale:1.5} ~ ~1 ~ 0.5 0.8 0.5 0 20
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:13864191,s0:0.3,s1:5.0,t:5,life:9,spin:150,dy:0.0}
execute positioned ~ ~1 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"swirl",color:9059583,s0:0.2,s1:3.2,t:4,life:7,spin:-170,dy:0.0}
execute positioned ~ ~1 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"star",color:15259903,s0:0.1,s1:1.8,t:2,life:5,spin:90,dy:0.0}
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:6}
function ch:api/fx/shake {s:1,t:4,r:6}
function ch:api/fx/screen {o:"void",color:"#8A3CFF",in:0,stay:2,out:6}
function ch:api/later {t:2,then:"ch:kit/void/fx/afterflash"}
