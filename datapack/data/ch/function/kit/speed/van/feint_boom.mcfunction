# Mirror Feint: the decoy explodes in a blinding gold flash.
execute unless entity @a[tag=ch.caster,limit=1] run return 0
scoreboard players set #d ch.speed.g 50
execute if score @s ch.v2 matches 1 run scoreboard players set #d ch.speed.g 60
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:16771466,s:3.6,t:3,life:6}
function ch:api/fx/wave {color:2741234,r:4.0,t:6}
particle minecraft:explosion ~ ~1 ~ 0.5 0.5 0.5 0 3
particle minecraft:firework ~ ~1 ~ 0.4 0.4 0.4 0.25 30
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:5}
playsound minecraft:entity.firework_rocket.large_blast player @a ~ ~ ~ 1.4 0.8
playsound chaoshearts:speed_afterimage player @a ~ ~ ~ 1 0.6
function ch:api/fx/shake {s:3,t:8,r:7}
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..3.6] run function ch:kit/speed/van/feint_hit
