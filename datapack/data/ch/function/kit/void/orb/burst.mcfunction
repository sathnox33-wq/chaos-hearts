# As an enemy in the orb's implosion.
function ch:kit/void/hurt
function ch:kit/void/afflict {e:"darkness",sec:2,amp:0}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"void",color:"#8A3CFF",in:0,stay:3,out:10}
