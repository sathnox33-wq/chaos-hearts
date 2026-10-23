# Storm became active.
scoreboard players set @s ch.storm.st 0
particle minecraft:electric_spark ~ ~1 ~ 0.4 0.6 0.4 0.2 25
execute rotated ~ 0 run function ch:api/fx/sprite {model:"ring",color:5220607,s0:0.3,s1:2.4,t:5,life:8,spin:150,dy:0.6}
playsound minecraft:item.trident.thunder player @a ~ ~ ~ 0.3 1.6
function ch:kit/storm/p/rain
