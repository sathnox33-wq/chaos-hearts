# A slam hit near the centre: full damage and a big launch.
$function ch:api/hit {d:$(d)}
function ch:api/push {s:0.8,y:0.7}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"vignette",color:"#E0262B",in:0,stay:3,out:10}
