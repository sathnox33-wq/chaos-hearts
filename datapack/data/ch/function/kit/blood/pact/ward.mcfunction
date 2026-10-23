# Blood Ward: a shell of clotted blood.
scoreboard players set @s ch.blood.pv 1
effect give @s minecraft:absorption 8 1
execute positioned ~ ~ ~ run function ch:api/fx/sprite {model:"dome",color:10357535,s0:3.2,s1:2.6,t:4,life:12,spin:90,dy:0.0}
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:16723263,s0:0.5,s1:4.5,t:5,life:30,spin:170,dy:0.0}
particle minecraft:dust{color:[0.17,0.0,0.02],scale:2.0} ~ ~1 ~ 0.8 0.9 0.8 0 40
function ch:api/fx/text {text:"BLOOD WARD",color:"#9E0B1F"}
playsound minecraft:block.honey_block.place player @a ~ ~ ~ 1 0.5
playsound minecraft:item.armor.equip_leather player @a ~ ~ ~ 1 0.5
return 1
