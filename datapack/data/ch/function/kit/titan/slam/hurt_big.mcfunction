# A landing slam hits this target: damage, launch, slowness, and a stun on a Cataclysm.
scoreboard players operation @s ch.titan.hid = #ti_cid ch.tmp
execute store result score #ti_ok ch.tmp run function ch:kit/titan/hit
execute unless score #ti_ok ch.tmp matches 1.. run return 0
function ch:api/push {s:0.5,y:0.9}
function ch:api/cc {effect:"minecraft:slowness",sec:2,amp:1}
execute if score #ti_cat ch.tmp matches 1 run function ch:api/stun {t:24}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"titan",color:"#C9A45C",in:1,stay:4,out:12}
execute at @s run function ch:api/fx/shake {s:3,t:8,r:1.5}
execute as @a[tag=ch.caster,limit=1] run function ch:kit/titan/slam/credit
