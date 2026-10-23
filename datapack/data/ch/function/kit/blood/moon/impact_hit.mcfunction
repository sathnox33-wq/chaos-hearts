# Crushed by the falling moon.
$function ch:api/hit {d:$(d)}
function ch:kit/blood/bleed/apply
function ch:api/push {s:0.6,y:0.9}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"shatter",color:"#9E0B1F",in:0,stay:4,out:12}
