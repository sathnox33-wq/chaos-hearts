# As an enemy flung out of the vortex.
function ch:kit/speed/fn/hit
execute positioned as @a[tag=ch.caster,limit=1] run function ch:api/push {s:1.5,y:0.6}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"speed",color:"#29D3F2",in:0,stay:3,out:8}
