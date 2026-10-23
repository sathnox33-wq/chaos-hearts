# Judgement detonates: pillars of light erupt and everything still inside (radius $(r)) takes 5.
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16777215,w:3.0,h:18.0,t:3,life:10}
$function ch:api/fx/wave {color:16763210,r:$(r),t:6}
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:16763210,s:6.0,t:3,life:6}
particle minecraft:firework ~ ~1 ~ 1 1 1 0.3 60
particle minecraft:end_rod ~ ~1 ~ 1.5 1 1.5 0.2 50
playsound chaoshearts:celestial_nova player @a ~ ~ ~ 1.4 1.2
playsound minecraft:entity.firework_rocket.large_blast player @a ~ ~ ~ 1.4 0.8
function ch:api/fx/shake {s:3,t:8,r:10}
$function ch:kit/celestial/sanc/sides {r:$(r)}
scoreboard players set #ce_d ch.tmp 50
execute as @e[tag=ch.celestial.en] at @s run function ch:kit/celestial/sanc/blast
tag @a remove ch.celestial.al
tag @e[tag=ch.celestial.en] remove ch.celestial.en
