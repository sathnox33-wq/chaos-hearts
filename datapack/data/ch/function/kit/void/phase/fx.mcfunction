# As the Void holder: the projectile slips through a fold in you.
playsound minecraft:entity.enderman.teleport player @a ~ ~ ~ 0.5 1.7
playsound chaoshearts:void_step player @a ~ ~ ~ 0.4 2
particle minecraft:reverse_portal ~ ~1 ~ 0.3 0.6 0.3 0.1 30
particle minecraft:dust{color:[0.827,0.549,1.0],scale:1.1} ~ ~1 ~ 0.35 0.6 0.35 0 10
execute positioned ~ ~1 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"swirl",color:9059583,s0:0.4,s1:2.2,t:4,life:7,spin:170,dy:0.0}
function ch:api/fx/text {text:"PHASED",color:"#D38CFF"}
function ch:api/fx/screen {o:"void",color:"#8A3CFF",in:0,stay:1,out:5}
