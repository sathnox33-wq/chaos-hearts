# Wrath Incarnate (awakened): above 100 Fury you burn with black flame and take 10% less damage.
scoreboard players set @s ch.rage.s100 1
attribute @s minecraft:armor modifier add ch:rage_wrath 2.5 add_value
attribute @s minecraft:armor_toughness modifier add ch:rage_wrath 2 add_value
playsound minecraft:entity.wither.ambient player @a ~ ~ ~ 0.6 1.4
playsound minecraft:item.firecharge.use player @a ~ ~ ~ 0.8 0.5
particle minecraft:soul_fire_flame ~ ~1 ~ 0.4 0.6 0.4 0.05 30
function ch:api/fx/screen {o:"vignette",color:"#1A0000",in:2,stay:6,out:14}
function ch:api/fx/text {text:"WRATH",color:"#5A0A0A"}
