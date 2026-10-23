# The ambush mark: a black rune snaps onto the victim.
playsound minecraft:entity.enderman.hurt player @a ~ ~ ~ 0.7 0.5
playsound chaoshearts:void_displace player @a ~ ~ ~ 0.4 1.8
particle minecraft:reverse_portal ~ ~1.2 ~ 0.3 0.4 0.3 0.1 25
execute positioned ~ ~1.2 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"rune",color:13864191,s0:2.0,s1:0.8,t:4,life:12,spin:120,dy:0.0}
function ch:api/fx/text {text:"AMBUSH",color:"#D38CFF"}
