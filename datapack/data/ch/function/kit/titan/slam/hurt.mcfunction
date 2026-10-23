# A fault line catches this target: damage, a launch into the air, the Titan overlay and (Cataclysm) a stun.
scoreboard players operation @s ch.titan.hid = #ti_cid ch.tmp
execute store result score #ti_ok ch.tmp run function ch:kit/titan/hit
execute unless score #ti_ok ch.tmp matches 1.. run return 0
function ch:api/push {s:0.25,y:0.85}
execute if score #ti_cat ch.tmp matches 1 run function ch:api/stun {t:20}
particle minecraft:block{block_state:"minecraft:cobblestone"} ~ ~0.5 ~ 0.3 0.3 0.3 0.1 12
execute if entity @s[type=player] run function ch:api/fx/screen {o:"titan",color:"#C9A45C",in:1,stay:3,out:10}
execute at @s run function ch:api/fx/shake {s:2,t:6,r:1.5}
execute as @a[tag=ch.caster,limit=1] run function ch:kit/titan/slam/credit
