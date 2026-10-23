# As an enemy caught in the collapsing hole.
function ch:kit/void/hurt
function ch:kit/void/afflict {e:"darkness",sec:3,amp:0}
function ch:api/pull {s:0.6}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"void",color:"#14002B",in:0,stay:4,out:12}
