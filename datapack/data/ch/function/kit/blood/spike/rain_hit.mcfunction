# Struck by Crimson Rain.
function ch:api/hit {d:25}
function ch:kit/blood/bleed/apply
execute if entity @s[type=player] run function ch:api/fx/screen {o:"blood",color:"#9E0B1F",in:0,stay:2,out:8}
