# As an enemy caught in the Recoil trap: cut, slowed and thrown out.
function ch:kit/speed/fn/hit
function ch:api/cc {effect:"minecraft:slowness",sec:2,amp:2}
function ch:api/push {s:0.9,y:0.35}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"speed",color:"#F5E142",in:0,stay:3,out:8}
