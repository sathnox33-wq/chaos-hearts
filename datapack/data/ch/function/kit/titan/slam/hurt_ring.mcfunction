# An Epicenter ring hits this target: damage, thrown outward, slowed (stunned on a Cataclysm).
scoreboard players operation @s ch.titan.hid = #ti_cid ch.tmp
execute store result score #ti_ok ch.tmp run function ch:kit/titan/hit
execute unless score #ti_ok ch.tmp matches 1.. run return 0
function ch:api/push {s:0.6,y:0.5}
function ch:api/cc {effect:"minecraft:slowness",sec:2,amp:0}
execute if score #ti_cat ch.tmp matches 1 run function ch:api/stun {t:20}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"titan",color:"#C9A45C",in:1,stay:3,out:10}
execute at @s run function ch:api/fx/shake {s:2,t:6,r:1.5}
execute as @a[tag=ch.caster,limit=1] run function ch:kit/titan/slam/credit
