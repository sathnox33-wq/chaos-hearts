# Permafrost: a frozen enemy shatters.
tag @s remove ch.frozen.solid
scoreboard players set @s ch.frozen.fz 0
execute if score @s ch.stun matches 2.. run scoreboard players set @s ch.stun 1
kill @e[type=block_display,tag=ch.frozen.shell,distance=..1.5]
particle minecraft:block{block_state:"minecraft:blue_ice"} ~ ~1 ~ 0.4 0.6 0.4 0.2 40
particle minecraft:item_snowball ~ ~1 ~ 0.4 0.6 0.4 0.15 20
execute rotated 0 -40 run function ch:api/fx/sprite {model:"shard",color:15924223,s0:0.6,s1:0.1,t:8,life:10,spin:170,dy:2.0}
execute rotated 120 -60 run function ch:api/fx/sprite {model:"shard",color:10217471,s0:0.6,s1:0.1,t:8,life:10,spin:170,dy:2.5}
execute rotated 240 -50 run function ch:api/fx/sprite {model:"shard",color:6273256,s0:0.6,s1:0.1,t:8,life:10,spin:170,dy:1.8}
function ch:api/fx/sprite {model:"star",color:15924223,s0:0.5,s1:3.2,t:3,life:6,spin:170,dy:0.8}
function ch:api/fx/text {text:"SHATTER",color:"#9BE7FF"}
playsound chaoshearts:frozen_shatter player @a ~ ~ ~ 1.2 1
playsound minecraft:block.glass.break player @a ~ ~ ~ 1 0.7
execute if entity @s[type=player] run function ch:api/fx/screen {o:"shatter",color:"#F2FBFF",in:0,stay:4,out:12}
