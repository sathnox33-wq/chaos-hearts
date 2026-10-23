# Prism Nova fires (as its marker, the Celestial tagged ch.caster): eight rays from where it was cast.
execute unless entity @a[tag=ch.caster,scores={ch.active=9},limit=1] run return 0
function ch:kit/celestial/fx/lget
scoreboard players set #hits ch.tmp 0
scoreboard players set #ce_ex ch.tmp 0
scoreboard players set #ce_first ch.tmp 1
scoreboard players operation #ce_d ch.tmp *= #7 ch.celestial.k
scoreboard players operation #ce_d ch.tmp /= #10 ch.g
execute rotated 0 0 positioned ~ ~1 ~ run function ch:kit/celestial/beam/nova_ray
execute rotated 45 0 positioned ~ ~1 ~ run function ch:kit/celestial/beam/nova_ray
execute rotated 90 0 positioned ~ ~1 ~ run function ch:kit/celestial/beam/nova_ray
execute rotated 135 0 positioned ~ ~1 ~ run function ch:kit/celestial/beam/nova_ray
execute rotated 180 0 positioned ~ ~1 ~ run function ch:kit/celestial/beam/nova_ray
execute rotated 225 0 positioned ~ ~1 ~ run function ch:kit/celestial/beam/nova_ray
execute rotated 270 0 positioned ~ ~1 ~ run function ch:kit/celestial/beam/nova_ray
execute rotated 315 0 positioned ~ ~1 ~ run function ch:kit/celestial/beam/nova_ray
execute as @e[tag=ch.celestial.bt] at @s run function ch:kit/celestial/beam/hurt
tag @e[tag=ch.celestial.bt] remove ch.celestial.bt
execute if score #hits ch.tmp matches 3.. as @a[tag=ch.caster,limit=1] run function ch:api/feat {h:"celestial",n:2}
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:16777215,s:3.0,t:2,life:6}
particle minecraft:firework ~ ~1 ~ 0.3 0.3 0.3 0.3 40
playsound chaoshearts:celestial_beam player @a ~ ~ ~ 1.4 1.3
playsound minecraft:entity.firework_rocket.large_blast player @a ~ ~ ~ 1 1.4
function ch:api/fx/shake {s:2,t:6,r:10}
