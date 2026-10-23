# Cataclysm finale: five spikes of molten stone burst out of the end of the fault.
execute rotated 0 0 run function ch:api/fx/pillar {model:"spike",color:16742954,w:1.1,h:3.6,t:3,life:18}
execute rotated 0 -25 positioned ^ ^ ^0.8 run function ch:api/fx/pillar {model:"spike",color:13214812,w:0.7,h:2.4,t:3,life:16}
execute rotated 90 -25 positioned ^ ^ ^0.8 run function ch:api/fx/pillar {model:"spike",color:13214812,w:0.7,h:2.2,t:3,life:16}
execute rotated 180 -25 positioned ^ ^ ^0.8 run function ch:api/fx/pillar {model:"spike",color:13214812,w:0.7,h:2.6,t:3,life:16}
execute rotated 270 -25 positioned ^ ^ ^0.8 run function ch:api/fx/pillar {model:"spike",color:13214812,w:0.7,h:2.0,t:3,life:16}
particle minecraft:lava ~ ~0.5 ~ 0.6 0.3 0.6 0 10
playsound minecraft:block.pointed_dripstone.break player @a ~ ~ ~ 1.5 0.5
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 0.8 0.8
function ch:api/fx/shake {s:2,t:6,r:6}
scoreboard players operation #ti_cid ch.tmp = @s ch.v2
scoreboard players set #ti_d ch.tmp 40
scoreboard players set #ti_cat ch.tmp 0
execute positioned ~ ~0.8 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..2.6] run function ch:kit/titan/slam/hurt
