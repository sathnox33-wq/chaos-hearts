# As an enemy caught in a burst.
function ch:kit/corruption/hurt
function ch:kit/corruption/poison {sec:4,amp:1}
tag @s add ch.corruption.bh
execute if entity @s[type=player] run function ch:api/fx/screen {o:"corruption",color:"#7BD13A",in:0,stay:5,out:14}
