# As an enemy the dash passed through: cut, and on Rising Rend thrown into the air.
function ch:kit/speed/fn/hit
execute if score #dv ch.speed.g matches 1 positioned ~ ~-1 ~ run function ch:api/push {s:0.2,y:1.1}
execute rotated as @a[tag=ch.caster,limit=1] run function ch:api/fx/slash {color:16113986,s:2.4,roll:35,t:3}
execute rotated as @a[tag=ch.caster,limit=1] run function ch:api/fx/slash {color:16777215,s:1.8,roll:-30,t:2}
particle minecraft:sweep_attack ~ ~1 ~ 0.3 0.3 0.3 0 2
particle minecraft:electric_spark ~ ~1 ~ 0.3 0.5 0.3 0.4 12
execute if entity @s[type=player] run function ch:api/fx/screen {o:"speed",color:"#F5E142",in:0,stay:3,out:8}
function ch:api/fx/shake {s:2,t:6,r:1}
