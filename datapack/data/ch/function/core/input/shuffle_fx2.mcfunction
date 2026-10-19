$function ch:api/fx/screen {o:"vignette",color:"$(color)",in:1,stay:2,out:8}
$title @s subtitle [{text:"❤ ",color:"$(color)"},{text:"$(title) Heart",color:"$(color)",bold:true}]
playsound chaoshearts:heart_shuffle player @a ~ ~ ~ 0.8 1
$function ch:api/fx/sprite {model:"ring",color:$(rgb),s0:0.3,s1:3.2,t:6,life:10,spin:160,dy:0.0}
$execute positioned ~ ~1 ~ run function ch:api/fx/sprite {model:"star",color:$(rgb),s0:0.2,s1:1.6,t:4,life:9,spin:120,dy:0.4}
$particle dust{color:$(rgbf),scale:1.4} ~ ~1 ~ 0.5 0.8 0.5 0 30
