$function ch:api/fx/screen {o:"vignette",color:"$(color)",in:5,stay:30,out:10}
$function ch:api/fx/pillar {model:"beam",color:$(rgb),w:1.6,h:14.0,t:10,life:30}
$execute positioned ~ ~0.2 ~ run function ch:api/fx/sprite {model:"rune",color:$(rgb),s0:0.5,s1:6.0,t:12,life:30,spin:170,dy:0.0}
function ch:api/fx/shake {s:2,t:20,r:12}
playsound chaoshearts:altar_activate master @a ~ ~ ~ 1.5 1
playsound chaoshearts:trial_intro master @s ~ ~ ~ 1 1
$particle dust{color:$(rgbf),scale:2.0} ~ ~1 ~ 0.6 2 0.6 0 120 force
$tellraw @a[distance=..48] [{selector:"@s",color:"$(color)"},{text:" enters the Awakening Trial of the $(title) Heart.",color:"gray"}]
