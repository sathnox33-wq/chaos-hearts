# Heat is full: the next ability is Overheated.
scoreboard players set @s ch.infernal.heat 100
title @s times 2 24 10
title @s subtitle {text:"🔥 OVERHEAT READY 🔥",color:"#FFD23F",bold:true}
title @s title {text:""}
playsound minecraft:entity.blaze.ambient player @s ~ ~ ~ 0.8 1.4
playsound chaoshearts:infernal_burst player @s ~ ~ ~ 0.5 1.6
particle minecraft:flame ~ ~1 ~ 0.4 0.7 0.4 0.08 40
