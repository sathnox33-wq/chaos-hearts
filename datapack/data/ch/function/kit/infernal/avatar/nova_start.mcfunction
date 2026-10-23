# Supernova: you are rooted for 1.5 s while a sun gathers in you; the danger circle shows 7 blocks.
scoreboard players set @s ch.infernal.nova 30
effect give @s minecraft:slowness 2 3 true
effect give @s minecraft:resistance 2 1 true
$execute rotated 0 0 positioned ~ ~0.1 ~ run function ch:api/fx/sprite {model:"ring",color:$(c),s0:16.0,s1:0.6,t:28,life:30,spin:170,dy:0.0}
$execute rotated 0 0 positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"rune",color:$(c2),s0:14.0,s1:14.0,t:28,life:30,spin:170,dy:0.0}
$function ch:api/fx/pillar {model:"beam",color:$(c3),w:0.5,h:16.0,t:20,life:30}
playsound chaoshearts:infernal_rumble player @a ~ ~ ~ 1.6 0.6
playsound minecraft:block.beacon.activate player @a ~ ~ ~ 1.4 0.5
title @s subtitle {text:"☀ SUPERNOVA ☀",color:"#FFD23F",bold:true}
title @s title {text:""}
return 1
