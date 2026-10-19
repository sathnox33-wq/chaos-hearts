$scoreboard players set @s ch.awk.$(name) 1
$scoreboard players operation @s ch.pts.$(name) += #awaken_pts ch.cfg
$execute if score @s ch.pts.$(name) > #max_pts ch.cfg run scoreboard players operation @s ch.pts.$(name) = #max_pts ch.cfg
$function ch:api/fx/screen {o:"awaken",color:"$(color)",in:3,stay:40,out:20}
title @s times 10 70 20
$title @s subtitle {text:"Your $(title) Heart has awakened. Open /trigger hearts to shape its skill tree.",color:"$(color)"}
playsound chaoshearts:heart_awaken master @s ~ ~ ~ 1.3 1
playsound chaoshearts:trial_victory master @s ~ ~ ~ 1 1
$function ch:api/fx/pillar {model:"beam",color:$(rgb),w:2.5,h:30.0,t:12,life:80}
$function ch:api/fx/wave {color:$(rgb),r:16.0,t:16}
$tellraw @a [{text:"✦ ",color:"gold"},{selector:"@s",color:"$(color)",bold:true},{text:" has awakened the ",color:"gold"},{text:"$(title) Heart",color:"$(color)",bold:true},{text:".",color:"gold"}]
