# As an enemy caught by the detonating echo.
function ch:kit/void/hurt
function ch:kit/void/afflict {e:"darkness",sec:3,amp:0}
function ch:api/push {s:0.9,y:0.45}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"void",color:"#8A3CFF",in:0,stay:3,out:10}
