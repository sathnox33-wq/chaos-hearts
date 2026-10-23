# Shrapnel of the shell hits this target: damage, thrown back, a shatter overlay on players.
execute store result score #ti_ok ch.tmp run function ch:kit/titan/hit
execute unless score #ti_ok ch.tmp matches 1.. run return 0
function ch:api/push {s:0.9,y:0.6}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"shatter",color:"#FF7A2A",in:1,stay:4,out:12}
execute at @s run function ch:api/fx/shake {s:3,t:8,r:1.5}
scoreboard players add @a[tag=ch.caster,limit=1] ch.titan.trem 5
