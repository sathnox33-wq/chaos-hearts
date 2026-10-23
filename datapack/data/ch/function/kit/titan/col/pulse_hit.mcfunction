# Hit by a Bastion quake.
execute store result score #ti_ok ch.tmp run function ch:kit/titan/hit
execute unless score #ti_ok ch.tmp matches 1.. run return 0
function ch:api/cc {effect:"minecraft:slowness",sec:1,amp:1}
function ch:api/push {s:0.4,y:0.6}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"titan",color:"#C9A45C",in:1,stay:3,out:10}
scoreboard players add @a[tag=ch.caster,limit=1] ch.titan.trem 3
