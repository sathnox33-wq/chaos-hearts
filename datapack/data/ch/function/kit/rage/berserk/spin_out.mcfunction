# Cut by the last Ravage spin and hurled away.
$function ch:api/hit {d:$(d)}
function ch:api/push {s:1.0,y:0.5}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"vignette",color:"#E0262B",in:0,stay:3,out:10}
