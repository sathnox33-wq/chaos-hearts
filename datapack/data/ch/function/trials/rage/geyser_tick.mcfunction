# A geyser building; it bubbles, then erupts (6 damage within 1.8).
scoreboard players remove @s ch.life 1
particle minecraft:lava ~ ~0.2 ~ 0.6 0 0.6 0 1
execute if score @s ch.life matches 1.. run return 0
function ch:api/fx/pillar {model:"flame",color:16738847,w:2.0,h:7.0,t:3,life:12}
particle minecraft:lava ~ ~1 ~ 0.6 2 0.6 0 30
particle minecraft:flame ~ ~2 ~ 0.4 2 0.4 0.05 40
playsound minecraft:block.lava.extinguish master @a[distance=..90] ~ ~ ~ 1.5 0.5
playsound minecraft:entity.blaze.shoot master @a[distance=..90] ~ ~ ~ 1.2 0.5
tag @e[type=ravager,tag=ch.rage.boss,distance=..80,limit=1] add ch.caster
execute as @a[tag=ch.challenger,distance=..1.8] run function ch:trials/rage/met_dmg
tag @e[tag=ch.caster] remove ch.caster
kill @s
