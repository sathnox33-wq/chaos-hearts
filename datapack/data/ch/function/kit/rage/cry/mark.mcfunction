# Challenged: dragged toward the Rage holder and marked for 5 seconds.
function ch:api/pull {s:0.9}
tag @s add ch.rage.marked
scoreboard players set @s ch.rage.mk 100
scoreboard players set #rmk ch.rage.g 1
effect give @s minecraft:glowing 5 0 true
execute at @s positioned ~ ~2.6 ~ rotated ~ 0 run function ch:api/fx/sprite {model:"skull",color:14689835,s0:0.2,s1:0.8,t:4,life:30,spin:0,dy:0.5}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"vignette",color:"#E0262B",in:0,stay:6,out:14}
execute if entity @s[type=player] run playsound minecraft:entity.elder_guardian.curse player @s ~ ~ ~ 0.5 1.4
