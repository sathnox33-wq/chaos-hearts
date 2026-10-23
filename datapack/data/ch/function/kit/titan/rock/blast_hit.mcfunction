# Caught in a boulder blast: damage and thrown from the impact.
execute store result score #ti_ok ch.tmp run function ch:kit/titan/hit
execute unless score #ti_ok ch.tmp matches 1.. run return 0
function ch:api/push {s:0.9,y:0.45}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"titan",color:"#C9A45C",in:1,stay:3,out:10}
execute at @s run function ch:api/fx/shake {s:2,t:6,r:1.5}
scoreboard players add @a[tag=ch.caster,limit=1] ch.titan.trem 6
