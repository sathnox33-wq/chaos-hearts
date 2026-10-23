# A kill during Rampage: +3 s, and Last Stand if a player died while you are at 3 hearts or less.
scoreboard players add @s ch.rage.ramp 60
particle minecraft:explosion ~ ~1 ~ 0.3 0.3 0.3 0 1
function ch:api/fx/text {text:"+3s",color:"#E0262B"}
playsound minecraft:entity.ender_dragon.growl player @s ~ ~ ~ 0.4 1.8
execute store result score #hp ch.tmp run data get entity @s Health 10
execute if score #hp ch.tmp matches ..60 if entity @a[distance=0.01..48,nbt={Health:0.0f},limit=1] run function ch:api/feat {h:"rage",n:3}
