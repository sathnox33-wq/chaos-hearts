# Full Blight: Poison II and a sickly bloom on the victim.
function ch:kit/corruption/poison {sec:4,amp:1}
particle minecraft:item_slime ~ ~1.2 ~ 0.3 0.4 0.3 0.1 10
execute positioned ~ ~1.2 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"skull",color:10813263,s0:0.2,s1:1.0,t:4,life:12,spin:0,dy:0.6}
playsound minecraft:entity.slime.squish player @a ~ ~ ~ 0.6 0.6
function ch:api/fx/text {text:"BLIGHT",color:"#A4FF4F"}
