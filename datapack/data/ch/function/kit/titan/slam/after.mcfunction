# Aftershock (as its marker, the Titan tagged ch.caster): a rumble, then the fault line runs again at half strength.
execute unless entity @a[tag=ch.caster,scores={ch.active=8},limit=1] run return 0
scoreboard players operation #ti_pid ch.tmp = @a[tag=ch.caster,limit=1] ch.pid
scoreboard players operation #ti_d ch.tmp = @s ch.v1
scoreboard players operation #ti_d ch.tmp /= #2 ch.g
scoreboard players operation #ti_len ch.tmp = @s ch.v4
scoreboard players operation #ti_big ch.tmp = @s ch.v3
scoreboard players set #ti_cat ch.tmp 0
scoreboard players add #ti_cid ch.titan.cid 1
scoreboard players operation #ti_cid ch.tmp = #ti_cid ch.titan.cid
playsound chaoshearts:titan_quake player @a ~ ~ ~ 1.2 1.3
playsound minecraft:block.deepslate.break player @a ~ ~ ~ 1 0.4
particle minecraft:campfire_cosy_smoke ~ ~0.2 ~ 0.8 0.1 0.8 0.02 8
function ch:api/fx/wave {color:3880238,r:2.5,t:5}
execute rotated ~ 0 run function ch:kit/titan/slam/walker
execute if entity @a[tag=ch.caster,scores={ch.b1=5..},limit=1] run function ch:kit/titan/slam/tectonic
