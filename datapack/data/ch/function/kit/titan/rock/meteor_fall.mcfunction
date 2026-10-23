# The boulder reappears high above the mark and drops onto it (12 ticks).
data modify storage ch:tmp tg.b set from entity @s data.b
function ch:kit/titan/rock/fall_rock with storage ch:tmp tg
execute positioned ~ ~0.15 ~ run function ch:api/fx/ring {p:"minecraft:dust{color:[1.0,0.478,0.165],scale:1.8}",r:4.5}
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16742954,w:0.25,h:24.0,t:4,life:13}
playsound minecraft:entity.firework_rocket.launch player @a ~ ~ ~ 1.5 0.5
playsound minecraft:entity.ender_dragon.flap player @a ~ ~ ~ 1.2 0.6
