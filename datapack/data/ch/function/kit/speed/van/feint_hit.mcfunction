# As an enemy caught by the Mirror Feint blast.
function ch:kit/speed/fn/hit
function ch:api/cc {effect:"minecraft:blindness",sec:1,amp:0}
function ch:api/push {s:1.0,y:0.4}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"flash",color:"#FFE98A",in:0,stay:4,out:12}
