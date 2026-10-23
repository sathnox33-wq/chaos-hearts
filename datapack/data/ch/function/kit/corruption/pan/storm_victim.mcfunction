# As an enemy struck by a plague glob.
function ch:kit/corruption/hurt
function ch:kit/corruption/poison {sec:3,amp:1}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"corruption",color:"#7BD13A",in:0,stay:4,out:10}
