# As an enemy in the collapse.
function ch:kit/void/hurt
function ch:kit/void/afflict {e:"darkness",sec:4,amp:0}
function ch:api/push {s:1.3,y:0.6}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"shatter",color:"#8A3CFF",in:0,stay:4,out:14}
