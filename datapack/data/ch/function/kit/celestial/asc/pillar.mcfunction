# A pillar of Judgment: 5 damage to everything within 2.5 blocks.
execute unless entity @a[tag=ch.caster,scores={ch.active=9},limit=1] run return 0
function ch:kit/celestial/fx/lget
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16777215,w:2.2,h:20.0,t:2,life:8}
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16765803,w:3.2,h:16.0,t:3,life:6}
function ch:api/fx/wave {color:16765803,r:2.5,t:4}
particle minecraft:end_rod ~ ~1 ~ 0.4 3 0.4 0.05 40
particle minecraft:firework ~ ~0.5 ~ 0.4 0.2 0.4 0.2 20
playsound chaoshearts:celestial_starfall player @a ~ ~ ~ 1 1.6
playsound minecraft:item.trident.thunder player @a ~ ~ ~ 0.6 2
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:4}
function ch:api/fx/shake {s:1,t:4,r:6}
execute positioned ~ ~0.8 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..2.5] run function ch:kit/celestial/star/hurt
